import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/enums/schedule_fit_days_of_week.dart';
import 'package:schedule_fit/widgets/schedule_fit_series_card.dart';

import '../database/schedule_fit_database.dart';
import '../enums/schedule_fit_colors.dart';
import '../l10n/app_localizations.dart';
import '../providers/exercise_info_provider.dart';
import '../providers/series_info_provider.dart';

class EditCardPage extends StatefulWidget {
  int id;
  String nomeEsercizio;
  final String nomeMuscolo;
  final String immagineMuscolo;
  int serieTotali;
  int serieCompletate;
  List<int> giorniSettimana;
  final Function onSave;

  EditCardPage({
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
  State<EditCardPage> createState() => _EditCardPageState();
}

class _EditCardPageState extends State<EditCardPage> {
  late SeriesInfoProvider seriesInfoProvider;
  late ExerciseInfoProvider exerciseInfoProvider;
  late TextEditingController _nomeEsercizioController;
  late List<SeriesInfoData> seriesList = [];
  late List<String> daysOfWeek = [];
  bool _isSaveButtonEnabled = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    exerciseInfoProvider = context.read<ExerciseInfoProvider>();
    seriesInfoProvider = context.read<SeriesInfoProvider>();
    seriesInfoProvider.clearSeries();
    _nomeEsercizioController =
        TextEditingController(text: widget.nomeEsercizio);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      daysOfWeek =
          widget.giorniSettimana.map((g) => getDayOfWeekTranslated(context, g))
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

  ///Update CompletedSeries
  Future<void> _updateCompletedSeries(
      Map<String, dynamic> updatedValues, int index) async {
    setState(() {
      widget.serieCompletate = updatedValues['serieCompletate'];
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
        giorniSettimana: drift.Value(daysOfWeek
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
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  widget.nomeMuscolo.toLowerCase()),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: getAppColors(AppColors.secondaryColor),
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
                            color: getAppColors(AppColors.secondaryColor)),
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
                              final newText =
                                  text.substring(0, 1).toUpperCase() +
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
            ),

            ///Days Of Week Dropdown
            Padding(
              padding: const EdgeInsets.all(20),
              child: MultiSelectDialogField(
                initialValue: daysOfWeek,
                items: getDaysOfWeekTranslated(context)
                    .map((e) => MultiSelectItem(e, e))
                    .toList(),
                listType: MultiSelectListType.LIST,
                backgroundColor: getAppColors(AppColors.primaryColor),
                checkColor: Colors.white,
                selectedColor: getAppColors(AppColors.secondaryColor),
                searchable: true,
                dialogHeight: MediaQuery.of(context).size.height * 0.5,
                itemsTextStyle: TextStyle(
                    color: getAppColors(AppColors.secondaryColor),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                selectedItemsTextStyle: TextStyle(
                    color: getAppColors(AppColors.secondaryColor),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                title: Text(
                  AppLocalizations.of(context)?.giorniAllenamento ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                barrierColor: Colors.transparent,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 2, color: Colors.white)),
                buttonIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 20,
                ),
                buttonText: Text(
                  AppLocalizations.of(context)?.giorniAllenamento ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                confirmText: Text(
                  AppLocalizations.of(context)?.conferma ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                cancelText: Text(
                  AppLocalizations.of(context)?.chiudi ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                onConfirm: (values) {
                  values.isNotEmpty
                      ? daysOfWeek = values
                      : daysOfWeek = [];
                  _updateSaveButtonState();
                },
                chipDisplay: MultiSelectChipDisplay(
                  scroll: true,
                  scrollBar: HorizontalScrollBar(isAlwaysShown: false),
                  chipColor: getAppColors(AppColors.primaryColor),
                  textStyle: const TextStyle(color: Colors.white, fontSize: 14),
                  items: getDaysOfWeekTranslated(context)
                      .map((d) => MultiSelectItem(d, d))
                      .toList(),
                ),
              ),
            ),

            ///Series Card List
            Expanded(
              flex: 5,
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: ListView.builder(
                        key: ValueKey(seriesList.length),
                        itemCount: seriesList.length,
                        itemBuilder: (context, index) {
                          return ScheduleFitSeriesCard(
                            key: ValueKey(seriesList[index].idEsercizio),
                            index: index,
                            onDelete: () => _removeSeries(
                                seriesList[index].id ?? -1, index),
                            ripetizioni: seriesList[index].ripetizioni,
                            unitaMisura: seriesList[index].unitaMisura,
                            peso: seriesList[index].peso,
                            completata: seriesList[index].completata,
                            serieCompletate: widget.serieCompletate,
                            onUpdate: (updatedValues) {
                              _updateCompletedSeries(updatedValues, index);
                            },
                          );
                        },
                      ),
                    ),
            ),

            ///Buttons
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 65),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: getAppColors(AppColors.primaryColor),
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
