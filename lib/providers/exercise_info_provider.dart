import 'package:flutter/material.dart';
import 'package:schedule_fit/database/schedule_fit_database.dart';
import 'package:table_calendar/table_calendar.dart';

class ExerciseInfoProvider extends ChangeNotifier {
  final ScheduleFitDatabase _database;
  List<ExerciseInfoData> _exerciseList = [];

  int _serieCompletate = 0;

  ExerciseInfoProvider(this._database) {
    loadExercises();
  }

  int get serieCompletate => _serieCompletate;

  List<ExerciseInfoData> get exerciseList => _exerciseList;

  ///Load Exercises
  Future<void> loadExercises() async {
    _exerciseList = await _database.getAllExercisesInfo;
    notifyListeners();
  }

  ///Get Execises For Date
  List<ExerciseInfoData> getExercisesForDate(DateTime date) {
    return _exerciseList.where((exercise) => isSameDay(exercise.data, date)).toList();
  }

  ///Upsert Exercise
  Future<int> upsertExercise(ExerciseInfoCompanion exercise) async {
    int id = await _database.upsertExerciseInfo(exercise);
    await loadExercises();
    return id;
  }

  ///Upsert Exercise Series
  Future<int> upsertExerciseSeries(ExerciseInfoCompanion exercise) async {
    int id = await _database.upsertExerciseSeries(exercise);
    await loadExercises();
    return id;
  }

  ///Delete Exercise
  Future<void> deleteExercise(int id) async {
    await _database.deleteExerciseInfo(id);
    await _database.deleteSeriesInfoByIdExercise(id);
    await loadExercises();
  }

  ///Increase Completed Series
  void increaseCompletedSeries() {
    _serieCompletate++;
    notifyListeners();
  }

  ///Decrease Completed Series
  void decreaseCompletedSeries() {
    if (_serieCompletate > 0) {
      _serieCompletate--;
      notifyListeners();
    }
  }
}
