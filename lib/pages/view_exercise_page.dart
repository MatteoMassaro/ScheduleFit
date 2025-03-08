import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/horizontal_scrollbar.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/enums/schedule_fit_days_of_week.dart';
import 'package:schedule_fit/providers/stopwatch_provider.dart';
import 'package:schedule_fit/widgets/schedule_fit_countdown_animation.dart';
import 'package:schedule_fit/widgets/schedule_fit_series_card.dart';
import 'package:schedule_fit/widgets/schedule_fit_stopwatch.dart';

import '../database/schedule_fit_database.dart';
import '../enums/schedule_fit_colors.dart';
import '../enums/schedule_fit_images.dart';
import '../l10n/app_localizations.dart';
import '../managers/countdown_manager.dart';
import '../providers/exercise_info_provider.dart';
import '../providers/series_info_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/schedule_fit_alert_dialog.dart';
import 'edit_exercise_page.dart';

class ViewExercisePage extends StatefulWidget {
  int id;
  final Function onSave;

  ViewExercisePage({
    super.key,
    required this.id,
    required this.onSave,
  });

  @override
  State<ViewExercisePage> createState() => _ViewExercisePageState();
}

class _ViewExercisePageState extends State<ViewExercisePage>
    with TickerProviderStateMixin {
  late ExerciseInfoData exercise;
  late SeriesInfoProvider seriesInfoProvider;
  late ExerciseInfoProvider exerciseInfoProvider;
  late StopwatchProvider stopwatchProvider;
  late CountdownManager countdownManager;
  late TextEditingController _nomeEsercizioController;
  late List<SeriesInfoData> seriesList = [];
  late List<String> giorniSettimanaTradotti = [];
  late AnimationController _countdownController;
  late AnimationController _opacityController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isLoading = false;
  bool startTraining = false;
  String firstButtonText = '';
  String secondButtonText = '';
  int _countdown = 3;
  bool _showCountdown = false;

  @override
  void initState() {
    super.initState();
    exerciseInfoProvider = context.read<ExerciseInfoProvider>();
    seriesInfoProvider = context.read<SeriesInfoProvider>();
    stopwatchProvider = context.read<StopwatchProvider>();

    _getExercise();
    seriesInfoProvider.clearSeries();
    _getSeries();

    _nomeEsercizioController =
        TextEditingController(text: exercise.nomeEsercizio);
    _countdownController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    countdownManager = CountdownManager(
      countdownController: _countdownController,
      opacityController: _opacityController,
      onCountdownUpdate: (int remainingTime) =>
          setState(() => _countdown = remainingTime),
      onTrainingStart: () => setState(() {
        _showCountdown = true;
        _countdown = 3;
      }),
      onCountdownFinished: () => setState(() {
        _showCountdown = false;
        startTraining = true;
        stopwatchProvider.start();
        firstButtonText = AppLocalizations.of(context)!.sospendiAllenamento;
        secondButtonText = AppLocalizations.of(context)!.terminaAllenamento;
      }),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getDaysOfWeekTranslated();
      firstButtonText = AppLocalizations.of(context)!.sospendiAllenamento;
      secondButtonText = AppLocalizations.of(context)!.terminaAllenamento;
    });

    _scaleAnimation = Tween<double>(begin: 1, end: 0.2).animate(
      CurvedAnimation(parent: _countdownController, curve: Curves.easeOut),
    );
    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _countdownController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _nomeEsercizioController.dispose();
    _countdownController.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stopwatchProvider.reset();
    });
    super.dispose();
  }

  ///Get Days of Week Translated
  Future<void> _getDaysOfWeekTranslated() async {
    giorniSettimanaTradotti = exercise.giorniSettimana.isNotEmpty
        ? exercise.giorniSettimana
            .map((g) => getDayOfWeekTranslatedFromInt(context, g!))
            .toList()
        : [];
  }

  ///Get Exercise
  void _getExercise() {
    setState(() =>
        exercise = exerciseInfoProvider.getExerciseById(widget.id) ?? exercise);
  }

  ///Get Series
  Future<void> _getSeries() async {
    setState(() => _isLoading = true);
    await seriesInfoProvider.loadSeries(widget.id).then(
      (value) {
        setState(() {
          seriesList = seriesInfoProvider.seriesList;
          _isLoading = false;
        });
      },
    );
  }

  ///Update Completed Series
  Future<void> _updateCompletedSeries(
      Map<String, dynamic> updatedValues, int index) async {
    setState(() => exercise.serieCompletate = updatedValues['serieCompletate']);
  }

  ///Upsert Exercise
  Future<void> _upsertExercise() async {
    ExerciseInfoCompanion exerciseInfo = ExerciseInfoCompanion(
        id: widget.id != -1
            ? drift.Value(widget.id)
            : const drift.Value.absent(),
        serieCompletate: drift.Value(exercise.serieCompletate));
    final exerciseId = await exerciseInfoProvider.upsertExercise(exerciseInfo);
    widget.id = exerciseId;
  }

  ///Upsert Series
  Future<void> _upsertSeries() async {
    for (var series in seriesList) {
      series.id = await seriesInfoProvider.upsertSeries(SeriesInfoCompanion(
        id: drift.Value(series.id),
        idEsercizio: drift.Value(
            series.idEsercizio != -1 ? series.idEsercizio : widget.id),
        completata: drift.Value(series.completata),
      ));
    }
  }

  ///Open Dialog
  _openDialog(ExerciseInfoProvider exerciseInfoProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ScheduleFitAlertDialog(
            title: AppLocalizations.of(context)!.terminaAllenamento,
            message: AppLocalizations.of(context)!.confermaTerminaAllenamento,
            onPressed: () async {
              setState(() {
                firstButtonText =
                    AppLocalizations.of(context)!.iniziaAllenamento;
                secondButtonText = AppLocalizations.of(context)!.modificaScheda;
                startTraining = false;
                stopwatchProvider.reset();
                Navigator.of(context).pop();
              });
              await _upsertSeries();
              await _upsertExercise();
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.visualizzaScheda),
        ),
        body: Consumer<SeriesInfoProvider>(
            builder: (context, seriesInfoProvider, child) {
          return Stack(children: [
            Column(
              children: [
                ///Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      ///Icon
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.nomeMuscolo(
                                  exercise.categoriaEsercizio[0].toLowerCase() +
                                      exercise.categoriaEsercizio
                                          .substring(1)
                                          .replaceAllMapped(
                                            RegExp(r' \w'),
                                            (match) => match
                                                .group(0)!
                                                .toUpperCase()
                                                .trim(),
                                          ),
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ThemeProvider.getColor(
                                      AppColors.secondaryColor),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Image.asset(
                                exercise.immagine,
                                width: 40,
                                height: 40,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      ///Title
                      Expanded(
                        flex: 3,
                        child: AutoSizeText(
                          _nomeEsercizioController.text,
                          style: TextStyle(
                              fontSize: 25,
                              color: ThemeProvider.getColor(
                                  AppColors.secondaryColor)),
                          maxLines: 2,
                          minFontSize: 23,
                          maxFontSize: 25,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                ///Days Of Week List
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 10, left: 24, right: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            image: AssetImage(getImage(Images.stopwatch)),
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          const ScheduleFitStopwatch()
                        ],
                      ),
                      MultiSelectChipDisplay(
                        scroll: true,
                        scrollBar: HorizontalScrollBar(isAlwaysShown: false),
                        chipColor:
                            ThemeProvider.getColor(AppColors.primaryColor),
                        textStyle: TextStyle(
                            color: ThemeProvider.getColor(
                                AppColors.secondaryColor),
                            fontSize: 14),
                        items: giorniSettimanaTradotti
                            .map((d) => MultiSelectItem(d, d))
                            .toList(),
                      ),
                    ],
                  ),
                ),

                ///Series Card List
                Expanded(
                  flex: 5,
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, bottom: 10),
                          key: ValueKey(seriesList.length),
                          shrinkWrap: true,
                          itemCount: seriesList.length,
                          itemBuilder: (context, index) {
                            return ScheduleFitSeriesCard(
                              key: ValueKey(seriesList[index].idEsercizio),
                              index: index,
                              ripetizioni: seriesList[index].ripetizioni,
                              unitaMisura: seriesList[index].unitaMisura,
                              peso: seriesList[index].peso,
                              completata: seriesList[index].completata,
                              serieCompletate: exercise.serieCompletate,
                              onDelete: null,
                              onUpdate: (updatedValues) =>
                                  _updateCompletedSeries(updatedValues, index),
                              onlyView: true,
                              startTraining: startTraining,
                            );
                          },
                        ),
                ),

                ///Buttons
                startTraining
                    ?

                    ///Stopwatch Buttons
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Flexible(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width, 0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  backgroundColor: ThemeProvider.getColor(
                                      AppColors.secondaryColor),
                                  padding: const EdgeInsets.all(10),
                                ),
                                onPressed: () => setState(() =>
                                    firstButtonText ==
                                            AppLocalizations.of(context)!
                                                .sospendiAllenamento
                                        ? {
                                            firstButtonText =
                                                AppLocalizations.of(context)!
                                                    .riprendiAllenamento,
                                            stopwatchProvider.stop()
                                          }
                                        : {
                                            firstButtonText =
                                                AppLocalizations.of(context)!
                                                    .sospendiAllenamento,
                                            stopwatchProvider.start()
                                          }),
                                child: Text(firstButtonText,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width, 0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  backgroundColor: ThemeProvider.getColor(
                                      AppColors.cancelColor),
                                  padding: const EdgeInsets.all(10),
                                ),
                                onPressed: () =>
                                    _openDialog(exerciseInfoProvider),
                                child: Text(
                                  secondButtonText,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    :

                    ///Only View Buttons
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width, 0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  backgroundColor: !_showCountdown
                                      ? ThemeProvider.getColor(
                                          AppColors.secondaryColor)
                                      : Colors.grey.withOpacity(0.2),
                                  padding: const EdgeInsets.all(10),
                                ),
                                onPressed: () => !_showCountdown
                                    ? countdownManager.startCountdown()
                                    : null,
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .iniziaAllenamento,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width, 0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  backgroundColor: !_showCountdown
                                      ? ThemeProvider.getColor(
                                          AppColors.primaryColor)
                                      : Colors.grey.withOpacity(0.2),
                                  padding: const EdgeInsets.all(10),
                                ),
                                onPressed: () => !_showCountdown
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditExercisePage(
                                            id: widget.id,
                                            categoriaEsercizio:
                                                exercise.categoriaEsercizio,
                                            immagine: exercise.immagine,
                                            onSave: () => exerciseInfoProvider
                                                .loadExercises(),
                                          ),
                                        ),
                                      ).then((values) => {
                                          _getExercise(),
                                          _getDaysOfWeekTranslated(),
                                          _getSeries(),
                                        })
                                    : null,
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .modificaScheda
                                      .toUpperCase(),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),

            ///Countdown Animation
            ScheduleFitCountdownAnimation(
              countdown: _countdown,
              countdownController: _countdownController,
              scaleAnimation: _scaleAnimation,
              opacityAnimation: _opacityAnimation,
              showCountdown: _showCountdown,
              onCountdownFinished: () {
                stopwatchProvider.start();
                setState(() {
                  startTraining = true;
                  firstButtonText =
                      AppLocalizations.of(context)!.sospendiAllenamento;
                  secondButtonText =
                      AppLocalizations.of(context)!.terminaAllenamento;
                });
              },
            ),
          ]);
        }),
      ),
    );
  }
}
