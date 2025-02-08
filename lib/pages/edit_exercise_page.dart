import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/enums/schedule_fit_days_of_week.dart';
import 'package:schedule_fit/widgets/schedule_fit_series_card.dart';

import '../database/schedule_fit_database.dart';
import '../enums/schedule_fit_colors.dart';
import '../l10n/app_localizations.dart';
import '../providers/exercise_info_provider.dart';
import '../providers/series_info_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/schedule_fit_days_of_week_dropdown.dart';

class EditExercisePage extends StatefulWidget {
  int id;
  String nomeEsercizio;
  final String nomeMuscolo;
  final String immagineMuscolo;
  int serieTotali;
  int serieCompletate;
  List<int> giorniSettimana;
  final Function onSave;

  EditExercisePage({
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
  State<EditExercisePage> createState() => _EditExercisePageState();
}

class _EditExercisePageState extends State<EditExercisePage> {
  late SeriesInfoProvider seriesInfoProvider;
  late ExerciseInfoProvider exerciseInfoProvider;
  late TextEditingController _nomeEsercizioController;
  late List<SeriesInfoData> seriesList = [];
  late List<String> weekDaysTranslated = [];
  bool _isSaveButtonEnabled = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    exerciseInfoProvider = context.read<ExerciseInfoProvider>();
    seriesInfoProvider = context.read<SeriesInfoProvider>();
    _nomeEsercizioController =
        TextEditingController(text: widget.nomeEsercizio);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      weekDaysTranslated = widget.giorniSettimana
          .map((g) => getDayOfWeekTranslated(context, g))
          .toList();
    });
    _getSeries();
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

  ///Add Series Card
  Future<void> _addSeriesCard() async {
    seriesInfoProvider.addSeries(widget.id);
    setState(() {
      widget.serieTotali++;
    });
  }

  ///Update Completed Series
  Future<void> _updateCompletedSeries(
      Map<String, dynamic> updatedValues, int index) async {
    setState(() {
      widget.serieCompletate = updatedValues['serieCompletate'];
      _updateSaveButtonState();
    });
  }

  ///Update Week Days
  void _updateWeekDays(List<String> updatedList) {
    setState(() {
      weekDaysTranslated = updatedList;
      _updateSaveButtonState();
    });
  }

  ///Upsert Exercise
  Future<void> _upsertExercise() async {
    ExerciseInfoCompanion exerciseInfo = ExerciseInfoCompanion(
        id: widget.id != -1
            ? drift.Value(widget.id)
            : const drift.Value.absent(),
        nomeEsercizio: drift.Value(_nomeEsercizioController.text),
        categoriaEsercizio: drift.Value(widget.nomeMuscolo),
        immagine: drift.Value(widget.immagineMuscolo),
        serieCompletate: drift.Value(widget.serieCompletate),
        serieTotali: drift.Value(widget.serieTotali),
        giorniSettimana: drift.Value(weekDaysTranslated
            .map((g) => getDayOfWeekTranslatedFromString(context, g))
            .toList()),
        data: drift.Value(DateTime.now()));
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
        ripetizioni: drift.Value(series.ripetizioni),
        peso: drift.Value(series.peso),
        unitaMisura: drift.Value(series.unitaMisura),
        completata: drift.Value(series.completata),
      ));
    }
  }

  ///Remove Series
  void _removeSeries(int seriesId, int index) async {
    widget.serieTotali--;
    seriesList[index].completata == true ? widget.serieCompletate-- : null;
    seriesId != -1
        ? {
            await seriesInfoProvider.deleteSeries(seriesId, widget.id),
            await exerciseInfoProvider.upsertExerciseSeries(
                ExerciseInfoCompanion(
                    id: drift.Value(widget.id),
                    serieTotali: drift.Value(widget.serieTotali),
                    serieCompletate: drift.Value(widget.serieCompletate)))
          }
        : seriesList.removeAt(index);
    _getSeries();
  }

  ///Update Save Button
  void _updateSaveButtonState() {
    setState(() {
      _isSaveButtonEnabled = _nomeEsercizioController.text.isNotEmpty &&
          (seriesInfoProvider.seriesList.isNotEmpty
              ? seriesInfoProvider.seriesList
                  .every((serie) => serie.ripetizioni > 0)
              : true);
    });
  }

  ///Save Changes
  _saveChanges() async {
    await _upsertExercise();
    await _upsertSeries();
    await _getSeries();
    setState(() {
      _isSaveButtonEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: widget.nomeEsercizio != ''
            ? Text(AppLocalizations.of(context)!.modificaScheda)
            : Text(AppLocalizations.of(context)!.creaScheda),
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
                    child: AutoSizeTextField(
                      controller: _nomeEsercizioController,
                      style: TextStyle(
                          fontSize: 25,
                          color:
                              ThemeProvider.getColor(AppColors.secondaryColor)),
                      decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.inserisciTitolo,
                          hintStyle: const TextStyle(color: Colors.grey),
                          counterText: "",
                          border: InputBorder.none),
                      maxLines: 2,
                      textInputAction: TextInputAction.done,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      minFontSize: 23,
                      maxFontSize: 25,
                      maxLength: 30,
                      textAlign: TextAlign.center,
                      onChanged: (text) {
                        setState(() {
                          _isSaveButtonEnabled = text.isNotEmpty;
                          if (text.isNotEmpty) {
                            final newText = text.substring(0, 1).toUpperCase() +
                                text.substring(1);
                            _nomeEsercizioController.value = TextEditingValue(
                              text: newText,
                              selection: TextSelection.collapsed(
                                  offset: newText.length),
                            );
                          }
                          _updateSaveButtonState();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            ///Days Of Week Dropdown
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 10, left: 24, right: 24),
              child: ScheduleFitDaysOfWeekDropdown(
                  giorniSettimanaTradotti: weekDaysTranslated,
                  onUpdate: _updateWeekDays),
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
                          left: 20, right: 20, bottom: 20),
                      key: ValueKey(seriesList.length),
                      shrinkWrap: true,
                      itemCount: seriesList.length,
                      itemBuilder: (context, index) {
                        return ScheduleFitSeriesCard(
                          key: ValueKey(seriesList[index].idEsercizio),
                          index: index,
                          onDelete: () =>
                              _removeSeries(seriesList[index].id ?? -1, index),
                          ripetizioni: seriesList[index].ripetizioni,
                          unitaMisura: seriesList[index].unitaMisura,
                          peso: seriesList[index].peso,
                          completata: seriesList[index].completata,
                          serieCompletate: widget.serieCompletate,
                          onUpdate: (updatedValues) {
                            _updateCompletedSeries(updatedValues, index);
                          },
                          onlyView: false,
                        );
                      },
                    ),
            ),

            ///Buttons
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
                        backgroundColor:
                            ThemeProvider.getColor(AppColors.primaryColor),
                        padding: const EdgeInsets.all(10),
                      ),
                      onPressed: _addSeriesCard,
                      child: Text(AppLocalizations.of(context)!.aggiungiSerie,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 65),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: _isSaveButtonEnabled
                            ? Colors.green
                            : Colors.grey.withOpacity(0.2),
                        padding: const EdgeInsets.all(10),
                      ),
                      onPressed: _isSaveButtonEnabled ? _saveChanges : null,
                      child: Text(
                        AppLocalizations.of(context)!.salva,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
