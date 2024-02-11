import 'dart:convert';

class ToDoModel {
  String id = "";
  String toDoKey = "";
  String toDoTitle = "";
  String toDoDetails = "";
  String toDoCreatedTime = "";
  bool toDoUploaded = false;
  bool toDoCompleted = false;

  ToDoModel({
    required this.id,
    required this.toDoKey,
    required this.toDoTitle,
    required this.toDoDetails,
    required this.toDoCreatedTime,
    required this.toDoUploaded,
    required this.toDoCompleted,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "toDoKey": toDoKey,
      "toDoTitle": toDoTitle,
      "toDoDetails": toDoDetails,
      "toDoCreatedTime": toDoCreatedTime,
      "toDoUploaded": toDoUploaded,
      "toDoCompleted": toDoCompleted,
    };
  }

  factory ToDoModel.fromMapDataToModel(Map<String, dynamic> map) {
    return ToDoModel(
      id: map['id'].toString(),
      toDoKey: map['toDoKey'] ?? "",
      toDoTitle:  map['toDoTitle'] ?? "",
      toDoDetails:  map['toDoDetails'] ?? "",
      toDoCreatedTime:  map['toDoCreatedTime'] ?? "",
      toDoUploaded:  map['toDoUploaded'].toString() == "1" ? true : false,
      toDoCompleted: map['toDoCompleted'].toString() == "1" ? true : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDoModel.fromJson(String source) => ToDoModel.fromMapDataToModel(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '{"id": "$id", "toDoKey": "$toDoKey", "toDoTitle": "$toDoTitle", "toDoDetails": "$toDoDetails", "toDoCreatedTime": "$toDoCreatedTime", "toDoUploaded": $toDoUploaded, "toDoCompleted": $toDoCompleted}';
  }

}