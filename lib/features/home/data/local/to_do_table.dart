import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/core/localDatabase/database_helper.dart';
import 'package:to_do_list/features/home/data/models/to_do_model.dart';

class ToDoTable {
  String toDoTable = 'toDoTable';
  String id = 'id';
  String uuid = 'uuid';
  String toDoKey = 'toDoKey';
  String toDoTitle = 'toDoTitle';
  String toDoDetails = 'toDoDetails';
  String toDoCreatedTime = 'toDoCreatedTime';
  String toDoUploaded = 'toDoUploaded';
  String toDoCompleted = 'toDoCompleted';

  Future<List<ToDoModel>> getToDoList() async {
    Database db = await DatabaseHelper().database;
    List<Map<String, Object?>> result =
        await db.query(toDoTable, orderBy: '$id DESC');
    debugPrint("Getting All To Do List From Table: $result");
    return result
        .map(
          (todo) => ToDoModel.fromMapDataToModel(todo),
        )
        .toList();
  }

  Future insertToDo({
  required ToDoModel todoModel,
  }) async {
    Database db = await DatabaseHelper().database;
    Map<String, Object?> row = {
      toDoKey: todoModel.toDoKey,
      toDoTitle: todoModel.toDoTitle,
      toDoDetails: todoModel.toDoDetails,
      toDoCreatedTime: todoModel.toDoCreatedTime,
      toDoCompleted: todoModel.toDoCompleted == false ? 0 : 1,
      toDoUploaded: todoModel.toDoUploaded == false ? 0 : 1,
    };
    int result = await db.insert(
      toDoTable,
      row,
    );
    debugPrint("Result in Inserting todo: $result");
    return result;
  }

  Future updateToDoStatus(ToDoModel toDoModel) async {
    Database db = await DatabaseHelper().database;
    int result = await db.rawUpdate(
        "UPDATE $toDoTable SET $toDoCompleted = ${toDoModel.toDoCompleted != true ? 1 : 0} WHERE $id == ${toDoModel.uuid} AND $toDoKey == '${toDoModel.toDoKey}'");
    debugPrint("Result in updating todo: $result");
    return result;
  }

  Future getToDoAccordingToTitle(String title) async {
    debugPrint("SELECT * FROM $toDoTable WHERE $toDoTitle LIKE '%$title%'");
    Database db = await DatabaseHelper().database;
    List<Map<String, Object?>> result = await db
        .rawQuery("SELECT * FROM $toDoTable WHERE $toDoTitle LIKE '%$title%'");
    debugPrint("Result in getting todo according to title: $result");
    return result
        .map(
          (todo) => ToDoModel.fromMapDataToModel(todo),
        )
        .toList();
  }
  Future updateToDoFullDetails({
    required String todoID,
    required String todoKey,
    required String todoTitle,
    required String todoDetails,
    required String todoCreatedTime,
    required int todoCompleted,
    required int todoUploaded,
  }) async {
    Database db = await DatabaseHelper().database;
    Map<String, Object?> row = {
      id: todoID,
      toDoKey: todoKey,
      toDoTitle: todoTitle,
      toDoDetails: todoDetails,
      toDoCreatedTime: todoCreatedTime,
      toDoCompleted: todoCompleted,
      toDoUploaded: todoUploaded,
    };
    int result = await db.update(
      toDoTable,
      row,
      where: "$id == $todoID AND $toDoKey == '$todoKey'"
    );
    debugPrint("Result in full update todo: $result");
    return result;
  }

  Future deleteToDo(ToDoModel todoModel) async {
    Database db = await DatabaseHelper().database;
    int result = await db.rawDelete(
        "DELETE FROM $toDoTable WHERE $id = ${todoModel.uuid} AND $toDoKey = '${todoModel.toDoKey}'"
    );
    debugPrint("Result in delete todo: $result");
    return result;
  }
}
