import 'package:drift/drift.dart';

class ExerciseInfo extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get nomeEsercizio => text().withLength(min: 1, max: 50)();
  TextColumn get categoriaEsercizio => text().withLength(min: 1, max: 50)();
  TextColumn get immagine => text().withLength(min: 1, max: 50)();
  IntColumn get serieTotali => integer().withDefault(const Constant(0))();
  IntColumn get serieCompletate => integer().withDefault(const Constant(0))();
  DateTimeColumn get data => dateTime().withDefault(currentDate)();
}

class SeriesInfo extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  IntColumn get idEsercizio => integer().nullable().references(ExerciseInfo, #id)();
  IntColumn get ripetizioni => integer().withDefault(const Constant(0))();
  RealColumn get peso => real().withDefault(const Constant(0))();
  TextColumn get unitaMisura => text().withLength(min: 1, max: 10)();
  BoolColumn get completata => boolean().withDefault(const Constant(false))();
}