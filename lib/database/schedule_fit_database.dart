import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:schedule_fit/database/tables.dart';
import 'package:schedule_fit/enums/schedule_fit_app_info.dart';

part 'schedule_fit_database.g.dart';

@DriftDatabase(tables: [ExerciseInfo, SeriesInfo])
class ScheduleFitDatabase extends _$ScheduleFitDatabase {
  ScheduleFitDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: getAppInfo(AppInfo.databaseName));
  }

  Future<List<ExerciseInfoData>> get getAllExercisesInfo =>
      select(exerciseInfo).get();

  Future<ExerciseInfoData?> getExerciseInfoById(int id) =>
      (select(exerciseInfo)..where((e) => e.id.equals(id))).getSingleOrNull();

  Future<List<SeriesInfoData>> getSeriesInfoByExerciseId(int exerciseId) =>
      (select(seriesInfo)..where((s) => s.idEsercizio.equals(exerciseId)))
          .get();

  Future<int> getExerciseCount() =>
      (selectOnly(exerciseInfo)..addColumns([exerciseInfo.id.count()]))
          .getSingle()
          .then((result) => result.read(exerciseInfo.id.count())!);

  Future<int> getSeriesCountByExerciseId(int exerciseId) async =>
      (selectOnly(seriesInfo)
            ..addColumns([seriesInfo.id.count()])
            ..where(seriesInfo.idEsercizio.equals(exerciseId)))
          .getSingle()
          .then((result) => result.read(seriesInfo.id.count())!);

  Future<int> upsertExerciseInfo(
          ExerciseInfoCompanion exerciseInfoCompanion) async =>
      await (select(exerciseInfo)
            ..where(
                (tbl) => tbl.id.equals(exerciseInfoCompanion.id.value ?? -1)))
          .getSingleOrNull()
          .then((existingRecord) => existingRecord != null
              ? (update(exerciseInfo)
                    ..where((tbl) => tbl.id.equals(existingRecord.id!)))
                  .write(exerciseInfoCompanion)
                  .then((_) => existingRecord.id!)
              : into(exerciseInfo).insert(exerciseInfoCompanion));

  Future<int> upsertExerciseSeries(
          ExerciseInfoCompanion exerciseInfoCompanion) async =>
      (update(exerciseInfo)
            ..where(
                (tbl) => tbl.id.equals(exerciseInfoCompanion.id.value ?? -1)))
          .write(ExerciseInfoCompanion(
              serieCompletate: exerciseInfoCompanion.serieCompletate,
              serieTotali: exerciseInfoCompanion.serieTotali));

  Future<int> upsertSeriesInfo(SeriesInfoCompanion serieInfo) async =>
      await (select(seriesInfo)
                    ..where((tbl) =>
                        tbl.id.equals(serieInfo.id.value ?? -1) &
                        tbl.idEsercizio
                            .equals(serieInfo.idEsercizio.value ?? -1)))
                  .getSingleOrNull() !=
              null
          ? (update(seriesInfo)
                ..where((tbl) =>
                    tbl.id.equals(serieInfo.id.value ?? -1) &
                    tbl.idEsercizio.equals(serieInfo.idEsercizio.value ?? -1)))
              .write(serieInfo)
          : into(seriesInfo).insert(serieInfo);

  Future<int> deleteExerciseInfo(int id) async =>
      (delete(exerciseInfo)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> deleteSeriesInfo(int id) async =>
      (delete(seriesInfo)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> deleteSeriesInfoByIdExercise(int id) async =>
      (delete(seriesInfo)..where((tbl) => tbl.idEsercizio.equals(id))).go();
}
