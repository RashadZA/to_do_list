import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

import 'package:to_do_list/core/localDatabase/folder_helper.dart';

class DatabaseHelper  {

  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database;
  Folder folder = Folder(); // Singleton Data// base

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper


  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper
          ._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    String savePath = await folder.getDBDirectoryPath();
    if (await File(savePath).exists()) {
      _database = await openDatabase(savePath, version: 1,onUpgrade: _upgradeDB,onDowngrade: onDatabaseDowngradeDelete);
      // print("DB exists: $savePath");
      return _database!;
    } else {
      _database = await initializeDatabase();
      return _database!;
    }
  }

  Future<Database> initializeDatabase() async {
    String path = await folder.createDBDirectory();
    // print("DB Created: $path");
    var restaurantDatabase = await openDatabase(
        path, version: 1,onCreate: _createDb);
    return restaurantDatabase;
  }


  void _createDb(Database db, int newVersion) async {

    await db.execute(
        'CREATE TABLE IF NOT EXISTS toDoTable( id TEXT PRIMARY KEY , toDoKey TEXT, toDoTitle TEXT, toDoDetails TEXT, toDoCreatedTime TEXT, toDoUploaded BOOLEAN, toDoCompleted BOOLEAN)');

  }

  Future<void> removeDatabase() async {
    String fileName = "toDo.db";
    String dir = (await getApplicationDocumentsDirectory()).path;
    String path = "$dir/$fileName";
    // debugPrint(path);
    deleteDatabase(path);
  }

  // UPGRADE DATABASE TABLES
  void _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if(oldVersion == 1) {
      _versionOne(db);
    }
  }
  void _versionOne(Database db) async {
    try{
      await db.rawQuery("SELECT toDoCompleted FROM toDoTable");
    } on DatabaseException catch(e){
      debugPrint("Error : $e");
      await db.execute("ALTER TABLE toDoTable ADD COLUMN toDoCompleted BOOLEAN");
    }
  }

}

