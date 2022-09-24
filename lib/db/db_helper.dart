import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';

class DBHelper {
  static Database? todoDatabase;
  static const int _todoDatabaseVersion = 1;
  static const String _tableName = 'Tasks';

  static Future<void> initDatabase() async {
    if (todoDatabase != null) {
      return;
    } else {
      try {
        String _dbPath = '${await getDatabasesPath()}task.db';

        todoDatabase =
            await openDatabase(_dbPath, version: _todoDatabaseVersion,
                onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, note TEXT, date STRING, startTime STRING, endTime STRING, remind INTEGER, repeat STRING, color INTEGER, isCompleted INTEGER)');
        });
      } catch (e) {}
    }
  }

  static Future<int> insertTask(Task? task) async {
    try {
      return await todoDatabase!.insert(
        _tableName,
        task!.toJson(),
      );
    } catch (e) {
      return 9000;
    }
  }

  static Future<int> deleteTask(Task task) async {
    return await todoDatabase!.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  static Future<int> deleteAll() async {
    return await todoDatabase!.delete(_tableName);
  }

  static Future<int> updateTask(int id) async {
    return await todoDatabase!.rawUpdate('''
        UPDATE Tasks
        SET isCompleted = ?
        WHERE id = ?
    ''', [1, id]);
  }

  static Future<List<Map<String, Object?>>> queryTask() async {
    return await todoDatabase!.query(_tableName);
  }
}
