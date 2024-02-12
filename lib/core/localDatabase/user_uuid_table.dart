import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/core/localDatabase/database_helper.dart';

class UserUUIDTable {
  String userUUiDTable = 'userUUiDTable';
  String uuid = 'uuid';

  Future getUserUUID() async {
    Database db = await DatabaseHelper().database;
    List<Map<String, Object?>> result =
    await db.query(userUUiDTable, orderBy: '$uuid DESC');
    debugPrint("uuid From Table: $result");
    return result.isNotEmpty ? result[0]['uuid'].toString() : "";
  }

  Future insertUserUUID({
    required String uuId,
  }) async {
    Database db = await DatabaseHelper().database;
    Map<String, Object?> row = {
      uuid: uuId,
    };
    int result = await db.insert(
      userUUiDTable,
      row,
    );
    debugPrint("Result in Inserting uuid: $result");
    return result;
  }

  Future deleteUserUUID() async {
    Database db = await DatabaseHelper().database;
    int result = await db.rawDelete(
        "DELETE FROM $userUUiDTable"
    );
    debugPrint("Result in delete uuid: $result");
    return result;
  }
}
