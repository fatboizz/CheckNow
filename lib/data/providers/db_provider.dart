import 'package:sqflite/sqflite.dart';
import '../../core/constants/app_constants.dart';
import '../models/task_model.dart';

/// Database provider handling SQLite persistence for Tasks.
class DBProvider {
  DBProvider._();

  static Database? _db;
  static const int _version = AppConstants.dbVersion;
  static const String _tableName = AppConstants.taskTableName;

  /// Initializes the SQLite database.
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      final String databasesPath = await getDatabasesPath();
      final String path = '$databasesPath/${AppConstants.dbName}';

      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) async {
          await db.execute(
            '''CREATE TABLE $_tableName (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              note TEXT,
              date TEXT,
              startTime TEXT,
              endTime TEXT,
              remind INTEGER,
              repeat TEXT,
              color INTEGER,
              isCompleted INTEGER
            )''',
          );
        },
      );
    } catch (e) {
      // Graceful error logging
    }
  }

  /// Inserts a new task and returns its auto-generated ID.
  static Future<int> insert(Task? task) async {
    if (_db == null || task == null) return -1;
    return await _db!.insert(_tableName, task.toJson());
  }

  /// Queries all tasks from the table.
  static Future<List<Map<String, dynamic>>> query() async {
    if (_db == null) return [];
    return await _db!.query(_tableName);
  }

  /// Deletes a task by ID.
  static Future<int> delete(Task task) async {
    if (_db == null || task.id == null) return 0;
    return await _db!.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  /// Marks a task as completed (isCompleted = 1).
  static Future<int> update(int id) async {
    if (_db == null) return 0;
    return await _db!.rawUpdate(
      '''UPDATE $_tableName
         SET isCompleted = ?
         WHERE id = ?''',
      [1, id],
    );
  }

  /// Resets daily recurring tasks to incomplete (isCompleted = 0).
  static Future<int> updateIsCompletedToZero() async {
    if (_db == null) return 0;
    return await _db!.rawUpdate(
      'UPDATE $_tableName SET isCompleted = 0 WHERE repeat = ?',
      [AppConstants.repeatDaily],
    );
  }
}

/// Backward compatibility class alias.
class DBHelper {
  static Future<void> initDb() => DBProvider.initDb();
  static Future<int> insert(Task? task) => DBProvider.insert(task);
  static Future<List<Map<String, dynamic>>> query() => DBProvider.query();
  static Future<int> delete(Task task) => DBProvider.delete(task);
  static Future<int> update(int id) => DBProvider.update(id);
  static Future<int> updateIsCompletedToZero() =>
      DBProvider.updateIsCompletedToZero();
}
