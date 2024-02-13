import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/features/home/data/models/to_do_model.dart';

class DataFromFirebase {
  /// Create To Do
  static Future<void> createTodoList({
    required String userUUID,
    required String title,
    required String details,
  }) async {
    final todoCollection = FirebaseFirestore.instance.collection(userUUID);
    final todoId = todoCollection.doc().id;
    final toDo = ToDoModel(
      uuid: userUUID,
      toDoKey: todoId,
      toDoTitle: title,
      toDoDetails: details,
      toDoCreatedTime: Timestamp.now(),
      toDoUploaded: true,
      toDoCompleted: false,
    ).toMap();
    try {
      todoCollection.doc(todoId).set(toDo);
      debugPrint("Some error occur");
    } catch (e) {
      debugPrint("Some error occur $e");
    }
  }

  /// Read To Do
  static Stream<List<ToDoModel>> getTodoList({required String userUUID}) {
    debugPrint("getTodoList userUUID: $userUUID");
    final noteCollection = FirebaseFirestore.instance
        .collection(userUUID)
        .orderBy("toDoCreatedTime", descending: true);
    return noteCollection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((e) => ToDoModel.fromSnapshotToModel(e))
        .toList());
  }

  /// Update/Edit To Do
  static Future<void> updateTodo(
    ToDoModel todo, {
    String? uuID,
    String? todoKey,
    String? title,
    String? details,
    Timestamp? createdTime,
    bool? uploaded,
    bool? completed,
  }) async {
    final noteCollection = FirebaseFirestore.instance.collection(todo.uuid);
    final newToDo = ToDoModel(
      uuid: uuID ?? todo.uuid,
      toDoKey: todoKey ?? todo.toDoKey,
      toDoTitle: title ?? todo.toDoTitle,
      toDoDetails: details ?? todo.toDoDetails,
      toDoCreatedTime: createdTime ?? todo.toDoCreatedTime,
      toDoUploaded: uploaded ?? todo.toDoUploaded,
      toDoCompleted: completed ?? todo.toDoCompleted,
    ).toMap();

    try {
      await noteCollection.doc(todo.toDoKey).update(newToDo);
    } catch (e) {
      debugPrint("Some error occur $e");
    }
  }

  /// Delete To Do
  static Future<void> deleteTod(ToDoModel todo) async {
    final noteCollection = FirebaseFirestore.instance.collection(todo.uuid);
    try {
      await noteCollection.doc(todo.toDoKey).delete();
    } catch (e) {
      debugPrint("Some error occur $e");
    }
  }

  /// Get To Do Details
  static Future<ToDoModel> getTodoDetails(
      {required String userUUID, required String todoKey}) async {
    debugPrint("getTodoList userUUID: $userUUID");
    DocumentSnapshot<Map<String, dynamic>> todoSnapShot =
        await FirebaseFirestore.instance
            .collection(userUUID)
            .doc(todoKey)
            .get();
    debugPrint("Todo Snap: ${todoSnapShot.data().toString()}");
    return ToDoModel.fromSnapshotToModel(todoSnapShot);
  }

  /// Get Search To DO List
  static Future<List<ToDoModel>> getSearchToDoList(
      {required String userUUID, required String todoTitle}) async {
    List<ToDoModel> todoList = [];
    debugPrint("getTodoList userUUID: $userUUID");
    QuerySnapshot<Map<String, dynamic>> todoCollection =
        await FirebaseFirestore.instance.collection(userUUID).get();
    for (QueryDocumentSnapshot toDo in todoCollection.docs) {
      Map<String, dynamic> data = toDo.data() as Map<String, dynamic>;
      String title = data['toDoTitle'];
      if (title.contains(todoTitle)) {
        todoList.add(ToDoModel.fromSnapshotToModel(toDo));
      }
      debugPrint(
          "Data From Firebase UUID: ${data['uuid']} and toDoTitle: ${data['toDoTitle']}");
    }
    debugPrint("Data From Firebase todoList: ${todoList.length}");
    return todoList;
  }
}
