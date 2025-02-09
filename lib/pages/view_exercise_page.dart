import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
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
import '../providers/exercise_info_provider.dart';
import '../providers/series_info_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/schedule_fit_alert_dialog.dart';
import 'edit_exercise_page.dart';

class ViewExercisePage extends StatefulWidget {
  int id;
  String nomeEsercizio;
  final String nomeMuscolo;
  final String immagineMuscolo;
  int serieTotali;
  int serieCompletate;
  List<int> giorniSettimana;
  final Function onSave;

  ViewExercisePage({
    super.key,
    required this.id,
    required this.nomeEsercizio,
    required this.nomeMuscolo,
    required this.immagineMuscolo,
    required this.serieTotali,
    required this.serieCompletate,
    required this.giorniSettimana,
    required this.onSave,
  });

  @override
  State<ViewExercisePage> createState() => _ViewExercisePageState();
}

class _ViewExercisePageState extends State<ViewExercisePage>
    with TickerProviderStateMixin {
  late SeriesInfoProvider seriesInfoProvider;
  late ExerciseInfoProvider exerciseInfoProvider;
  late StopwatchProvider stopwatchProvider;
  late TextEditingController _nomeEsercizioController;
  late List<SeriesInfoData> seriesList = [];
  late List<String> giorniSettimanaTradotti = [];
  bool _isLoading = false;
  bool startTraining = false;
  String firstButtonText = '';
  String secondButtonText = '';
  int _countdown = 3;
  bool _showCountdown = false;
  late AnimationController _countdownController;
  late AnimationController _opacityController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    exerciseInfoProvider = context.read<ExerciseInfoProvider>();
    seriesInfoProvider = context.read<SeriesInfoProvider>();
    stopwatchProvider = context.read<StopwatchProvider>();
    _nomeEsercizioController =
        TextEditingController(text: widget.nomeEsercizio);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      giorniSettimanaTradotti = widget.giorniSettimana
          .map((g) => getDayOfWeekTranslated(context, g))
          .toList();
      firstButtonText = AppLocalizations.of(context)!.sospendiAllenamento;
      secondButtonText = AppLocalizations.of(context)!.terminaAllenamento;
    });

    seriesInfoProvider.clearSeries();
    _getSeries();
    _countdownController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.2).animate(
      CurvedAnimation(parent: _countdownController, curve: Curves.easeOut),
    );
    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _countdownController, curve: Curves.easeOut),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getSeries();
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

  ///Get Series
  Future<void> _getSeries() async {
    setState(() {
      _isLoading = true;
    });
    await seriesInfoProvider.loadSeries(widget.id).then(
      (value) {
        setState(() {
          seriesList = seriesInfoProvider.seriesList;
          _isLoading = false;
        });
      },
    );
  }

  ///Start Countdown
  void startCountdown() {
    setState(() {
      _showCountdown = true;
      _countdown = 3;
    });

    _countdownController.reset();
    _countdownController.forward();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
        _countdownController.forward(from: 0);
      } else {
        stopwatchProvider.start();
        setState(() {
          startTraining = true;
          firstButtonText = AppLocalizations.of(context)!.sospendiAllenamento;
          secondButtonText = AppLocalizations.of(context)!.terminaAllenamento;
        });
        timer.cancel();
        _opacityController.forward();
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _showCountdown = false;
          });
        });
      }
    });
  }

  ///Open Dialog
  _openDialog(ExerciseInfoProvider exerciseInfoProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ScheduleFitAlertDialog(
            title: AppLocalizations.of(context)!.terminaAllenamento,
            message: AppLocalizations.of(context)!.confermaTerminaAllenamento,
            onPressed: () => setState(() {
                  firstButtonText =
                      AppLocalizations.of(context)!.iniziaAllenamento;
                  secondButtonText =
                      AppLocalizations.of(context)!.modificaScheda;
                  startTraining = false;
                  stopwatchProvider.reset();
                  Navigator.of(context).pop();
                }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                widget.nomeMuscolo[0].toLowerCase() +
                                    widget.nomeMuscolo
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
                              widget.immagineMuscolo,
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
                      chipColor: ThemeProvider.getColor(AppColors.primaryColor),
                      textStyle: TextStyle(
                          color:
                              ThemeProvider.getColor(AppColors.secondaryColor),
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
                            serieCompletate: widget.serieCompletate,
                            onDelete: null,
                            onUpdate: (updatedValues) => (),
                            onlyView: true,
                          );
                        },
                      ),
              ),

              ///Buttons
              startTraining
                  ?

                  ///Stopwatch Buttons
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(150, 65),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                backgroundColor: ThemeProvider.getColor(
                                    AppColors.secondaryColor),
                                padding: const EdgeInsets.all(10),
                              ),
                              onPressed: () => setState(() {
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
                                      };
                              }),
                              child: Text(firstButtonText,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(150, 65),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                backgroundColor: ThemeProvider.getColor(
                                    AppColors.cancelColor),
                                padding: const EdgeInsets.all(10),
                              ),
                              onPressed: () => setState(() {
                                _openDialog(exerciseInfoProvider);
                              }),
                              child: Text(
                                secondButtonText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  :

                  ///Only View Buttons
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(150, 65),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                backgroundColor: !_showCountdown
                                    ? ThemeProvider.getColor(
                                        AppColors.secondaryColor)
                                    : Colors.grey.withOpacity(0.2),
                                padding: const EdgeInsets.all(10),
                              ),
                              onPressed: () =>
                                  !_showCountdown ? startCountdown() : null,
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .iniziaAllenamento,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(150, 65),
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
                                        builder: (context) => EditExercisePage(
                                          id: widget.id,
                                          nomeEsercizio: widget.nomeEsercizio,
                                          nomeMuscolo: widget.nomeMuscolo,
                                          immagineMuscolo:
                                              widget.immagineMuscolo,
                                          serieTotali: widget.serieTotali,
                                          serieCompletate:
                                              widget.serieCompletate,
                                          giorniSettimana:
                                              widget.giorniSettimana,
                                          onSave: () {
                                            exerciseInfoProvider
                                                .loadExercises();
                                          },
                                        ),
                                      ),
                                    ).then((values) => _getSeries())
                                  : null,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .modificaScheda
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
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
    );
  }
}
