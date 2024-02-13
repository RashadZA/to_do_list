import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ToDoModel {
  String uuid = "";
  String toDoKey = "";
  String toDoTitle = "";
  String toDoDetails = "";
  Timestamp toDoCreatedTime = Timestamp.now();
  bool toDoUploaded = false;
  bool toDoCompleted = false;

  ToDoModel({
    required this.uuid,
    required this.toDoKey,
    required this.toDoTitle,
    required this.toDoDetails,
    required this.toDoCreatedTime,
    required this.toDoUploaded,
    required this.toDoCompleted,
  });


  Map<String, dynamic> toMap() => {
      "uuid": uuid,
      "toDoKey": toDoKey,
      "toDoTitle": toDoTitle,
      "toDoDetails": toDoDetails,
      "toDoCreatedTime": toDoCreatedTime,
      "toDoUploaded": toDoUploaded,
      "toDoCompleted": toDoCompleted,
    };


  factory ToDoModel.fromMapDataToModel(Map<String, dynamic> map) {
    return ToDoModel(
      uuid: map['uuid'].toString(),
      toDoKey: map['toDoKey'] ?? "",
      toDoTitle:  map['toDoTitle'] ?? "",
      toDoDetails:  map['toDoDetails'] ?? "",
      toDoCreatedTime:  map['toDoCreatedTime'] ?? Timestamp.now(),
      toDoUploaded:  map['toDoUploaded'].toString() == "1" ? true : false,
      toDoCompleted: map['toDoCompleted'].toString() == "1" ? true : false,
    );
  }


  factory ToDoModel.fromJson(String source) => ToDoModel.fromMapDataToModel(json.decode(source) as Map<String, dynamic>);

  factory ToDoModel.defaultModel() {
    return ToDoModel(
      uuid: "",
      toDoKey: "",
      toDoTitle: "",
      toDoDetails: "",
      toDoCreatedTime:  Timestamp.now(),
      toDoUploaded:  false,
      toDoCompleted: false,
    );
  }

  factory ToDoModel.fromSnapshotToModel(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    debugPrint("TodoModel snap: $snap");
    return ToDoModel(
      uuid: snap['uuid'],
      toDoKey: snap['toDoKey'],
      toDoTitle: snap['toDoTitle'],
      toDoDetails: snap['toDoDetails'],
      toDoCreatedTime: snap['toDoCreatedTime'],
      toDoUploaded: snap['toDoUploaded'],
      toDoCompleted: snap['toDoCompleted'],
    );
  }

  factory ToDoModel.fromSearchFieldSnapshotToModel(
      {required DocumentSnapshot snapshot, required String searchTitle}) {
    final snap = snapshot.data() as Map<String, dynamic>;
    debugPrint("TodoModel snap: $snap");
    return ToDoModel(
      uuid: snap['uuid'],
      toDoKey: snap['toDoKey'],
      toDoTitle: snap['toDoTitle'],
      toDoDetails: snap['toDoDetails'],
      toDoCreatedTime: snap['toDoCreatedTime'],
      toDoUploaded: snap['toDoUploaded'],
      toDoCompleted: snap['toDoCompleted'],
    );
  }
}