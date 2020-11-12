import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = 'question.db';
  //static final _databaseVersion = 2;
  static final table = 'Questions';

  // Constructor
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data =
          await rootBundle.load(join("assets/database", _databaseName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flust the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print('Opening existing database');
    }

    return await openDatabase(path);
  }

  // CRUD
  //===================================
  // SELECT ALL
  Future<List> getAllQuestions() async {
    Database db = await instance.database;
    var result = await db.query(table);
    return result.toList();
  }

  // RAW Query
  Future<List> getRandom() async {
    var db = await instance.database;
    var result =
        await db.rawQuery('SELECT * FROM $table ORDER BY RANDOM() LIMIT 15');
    return result.toList();
  }

  Future<List> getCategoryRandom(String category, String difficulty) async {
    var db = await instance.database;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE Category == '$category' AND Difficulty == '$difficulty' ORDER BY RANDOM() LIMIT 5");
    return result.toList();
  }
}
