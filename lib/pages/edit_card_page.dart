import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/widgets/schedule_fit_series_card.dart';

import '../database/schedule_fit_database.dart';
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
  final Function onSave;

  EditCardPage({
    super.key,
    required this.id,
    required this.nomeEsercizio,
    required this.nomeMuscolo,
    required this.immagineMuscolo,
    required this.serieTotali,
    required this.serieCompletate,
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
        serieTotali: drift.Value(widget.serieTotali));
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
                              (widget.nomeMuscolo),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFFfbc24c),
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
                        style: const TextStyle(
                            fontSize: 25, color: Color(0xFFfbc24c)),
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
            ///Series Card List
            Expanded(
              flex: 6,
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
                        backgroundColor: const Color(0xFF556EAA),
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
