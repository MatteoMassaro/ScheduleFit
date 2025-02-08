import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/horizontal_scrollbar.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/enums/schedule_fit_days_of_week.dart';
import 'package:schedule_fit/widgets/schedule_fit_series_card.dart';

import '../database/schedule_fit_database.dart';
import '../enums/schedule_fit_colors.dart';
import '../l10n/app_localizations.dart';
import '../providers/exercise_info_provider.dart';
import '../providers/series_info_provider.dart';
import '../providers/theme_provider.dart';
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

class _ViewExercisePageState extends State<ViewExercisePage> {
  late SeriesInfoProvider seriesInfoProvider;
  late ExerciseInfoProvider exerciseInfoProvider;
  late TextEditingController _nomeEsercizioController;
  late List<SeriesInfoData> seriesList = [];
  late List<String> giorniSettimanaTradotti = [];
  bool _isLoading = false;
  bool startTraining = false;
  String firstButtonText = '';
  String secondButtonText = '';

  @override
  void initState() {
    super.initState();
    exerciseInfoProvider = context.read<ExerciseInfoProvider>();
    seriesInfoProvider = context.read<SeriesInfoProvider>();
    seriesInfoProvider.clearSeries();
    _nomeEsercizioController =
        TextEditingController(text: widget.nomeEsercizio);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      giorniSettimanaTradotti = widget.giorniSettimana
          .map((g) => getDayOfWeekTranslated(context, g))
          .toList();
      firstButtonText = AppLocalizations.of(context)!.sospendiAllenamento;
      secondButtonText = AppLocalizations.of(context)!.terminaAllenamento;
    });
    _getSeries();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading == false && seriesList.isEmpty) {
      _getSeries();
    }
  }

  @override
  void dispose() {
    _nomeEsercizioController.dispose();
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

  ///Open Dialog
  _openDialog(ExerciseInfoProvider exerciseInfoProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeProvider.getColor(AppColors.primaryColor),
          title: Center(
            child: Text(
              AppLocalizations.of(context)!.terminaAllenamento,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          content: Text(
            AppLocalizations.of(context)!.confermaTerminaAllenamento,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ThemeProvider.getColor(AppColors.secondaryColor),
                fontSize: 15),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => setState(() {
                firstButtonText =
                    AppLocalizations.of(context)!.iniziaAllenamento;
                secondButtonText = AppLocalizations.of(context)!.modificaScheda;
                startTraining = false;
                Navigator.of(context).pop();
              }),
              child: Text(AppLocalizations.of(context)!.si,
                  style: const TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)!.annulla,
                style: TextStyle(
                    color: ThemeProvider.getColor(AppColors.cancelColor)),
              ),
            ),
          ],
        );
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
        return Column(
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
                          color:
                              ThemeProvider.getColor(AppColors.secondaryColor)),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.giorniAllenamento,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ThemeProvider.getColor(
                            AppColors.dropdownButtonTextColor),
                      ),
                    ),
                  ),
                  MultiSelectChipDisplay(
                    scroll: true,
                    scrollBar: HorizontalScrollBar(isAlwaysShown: false),
                    chipColor: ThemeProvider.getColor(AppColors.primaryColor),
                    textStyle: TextStyle(
                        color: ThemeProvider.getColor(AppColors.secondaryColor),
                        fontSize: 14),
                    items: getDaysOfWeekTranslated(context)
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
                ? Expanded(
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
                              firstButtonText = firstButtonText ==
                                      AppLocalizations.of(context)!
                                          .sospendiAllenamento
                                  ? AppLocalizations.of(context)!
                                      .riprendiAllenamento
                                  : AppLocalizations.of(context)!
                                      .sospendiAllenamento;
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
                              backgroundColor:
                                  ThemeProvider.getColor(AppColors.cancelColor),
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
                : Expanded(
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
                              startTraining = true;
                              firstButtonText = AppLocalizations.of(context)!
                                  .sospendiAllenamento;
                              secondButtonText = AppLocalizations.of(context)!
                                  .terminaAllenamento;
                            }),
                            child: Text(
                                AppLocalizations.of(context)!.iniziaAllenamento,
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
                                  AppColors.primaryColor),
                              padding: const EdgeInsets.all(10),
                            ),
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditExercisePage(
                                    id: widget.id,
                                    nomeEsercizio: widget.nomeEsercizio,
                                    nomeMuscolo: widget.nomeMuscolo,
                                    immagineMuscolo: widget.immagineMuscolo,
                                    serieTotali: widget.serieTotali,
                                    serieCompletate: widget.serieCompletate,
                                    giorniSettimana: widget.giorniSettimana,
                                    onSave: () {
                                      exerciseInfoProvider.loadExercises();
                                    },
                                  ),
                                ),
                              ),
                            },
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
        );
      }),
    );
  }
}
