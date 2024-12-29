import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:schedule_fit/database/schedule_fit_database.dart';
import 'package:schedule_fit/enums/schedule_fit_app_info.dart';

class SeriesInfoProvider extends ChangeNotifier {
  final ScheduleFitDatabase _database;
  List<SeriesInfoData> _seriesList = [];

  SeriesInfoProvider(this._database);

  List<SeriesInfoData> get seriesList => _seriesList;

  ///Load Series
  Future<void> loadSeries(int exerciseId) async {
    _seriesList = await _database.getSeriesInfoByExerciseId(exerciseId);
    notifyListeners();
  }

  ///Empty Series
  void clearSeries() {
    _seriesList.clear();
  }

  ///Add Series
  void addSeries(int? exerciseId) {
    final newSeries = SeriesInfoData(
      id: const Value.absent().value,
      idEsercizio: Value(exerciseId).value ?? const Value.absent().value,
      ripetizioni: const Value(0).value,
      peso: const Value(0.0).value,
      unitaMisura: Value(getAppInfo(AppInfo.defaultMeasurement)).value,
      completata: const Value(false).value,
    );

    _seriesList.add(newSeries);
    notifyListeners();
  }

  ///Upsert Series
  Future<int> upsertSeries(SeriesInfoCompanion series) async {
    int id = await _database.upsertSeriesInfo(series);
    await loadSeries(series.idEsercizio.value ?? -1);
    return id;
  }

  ///Delete Series
  Future<void> deleteSeries(int id, int exerciseId) async {
    await _database.deleteSeriesInfo(id);
    await loadSeries(exerciseId);
  }
}
