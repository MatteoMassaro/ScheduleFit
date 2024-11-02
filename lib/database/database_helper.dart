import 'package:path/path.dart';
import 'package:schedule_fit/models/exercise_info.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'schedule_fit_database.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE exercise_info(id INTEGER PRIMARY KEY AUTOINCREMENT, nomeEsercizio TEXT, categoriaEsercizio TEXT, immagine TEXT, serieTotali INTEGER, serieCompletate INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<int> insertExerciseInfo(ExerciseInfo exerciseInfo) async {
    Database db = await database;
    return await db.insert('exercise_info', exerciseInfo.toMap());
  }

  Future<int> updateExerciseInfo(ExerciseInfo exerciseInfo) async {
    Database db = await database;
    return await db.update(
      'exercise_info',
      exerciseInfo.toMap(),
      where: 'id = ?',
      whereArgs: [exerciseInfo.id],
    );
  }

  Future<int> deleteExerciseInfo(int id) async {
    Database db = await database;
    return await db.delete(
      'exercise_info',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ExerciseInfo>> getAllExerciseInfo() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('exercise_info');
    return List.generate(maps.length, (i) {
      return ExerciseInfo.fromMap(maps[i]);
    });
  }

  Future<ExerciseInfo?> getExerciseInfoById(int id) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'exercise_info',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ExerciseInfo.fromMap(maps.first);
    }
    return null;
  }

  Future<int> getExerciseCount() async {
    Database db = await database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) FROM exercise_info');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> deleteDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'schedule_fit_database.db');
    databaseFactory.deleteDatabase(path);
    print('database eliminato');
  }
}
