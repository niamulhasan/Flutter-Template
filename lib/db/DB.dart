import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class DB {
  Database db;

  static Future<String> getDbPath() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, 'quran.db');

    try {
      await Directory(databasePath).create(recursive: true);
    } catch (e) {
      print(e);
    }
    return path;
  }

  static Future<Database> openDb() async {
    //check if the database exists
    var path = await getDbPath();
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      //copy from asset
      ByteData data = await rootBundle.load(join("assets", "quran.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //write and flush the byte written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print('Opening existing database');
    }
    //open the database
    Database db = await openDatabase(path);

    return db;
  }

  static Future<List<Map>> getSuraList() async {
    Database database = await DB.openDb();
    return await database.rawQuery('SELECT * FROM sura');
  }
}
