import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/core/routes/app_pages.dart';
import 'package:to_do_list/features/home/data/local/to_do_table.dart';
import 'package:to_do_list/features/home/data/models/to_do_model.dart';
import 'dart:async';

class EditToDoPageController extends GetxController {
  final TextEditingController editToDoListTitleTextEditController =
      TextEditingController();
  final TextEditingController editToDoListDescriptionTextEditController =
      TextEditingController();

  RxBool makingChangesInToDo = false.obs;

  RxString todoString = "".obs;
  ToDoModel toDo = ToDoModel.defaultModel();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    todoString.value = Get.parameters['todo'] ?? "";
    debugPrint("In Edit Page: $todoString");
    toDo = ToDoModel.fromJson(todoString.value);
    editToDoListTitleTextEditController.text = toDo.toDoTitle;
    editToDoListDescriptionTextEditController.text = toDo.toDoDetails;
    update();
  }

  Future<void> addButtonOnPressedFunction() async {
    makingChangesInToDo.value = true;
    if (editToDoListTitleTextEditController.text != toDo.toDoTitle ||
        editToDoListDescriptionTextEditController.text != toDo.toDoDetails) {
     await ToDoTable().updateToDoFullDetails(
        todoID: toDo.uuid,
        todoKey: toDo.toDoKey,
        todoTitle: editToDoListTitleTextEditController.text,
        todoDetails: editToDoListDescriptionTextEditController.text,
        todoCreatedTime: "${DateTime.now()}",
        todoCompleted: toDo.toDoCompleted == true ? 1 : 0,
        todoUploaded: toDo.toDoUploaded == true ? 1 : 0,
      );
    }
    makingChangesInToDo.value = false;
    Get.offAllNamed(Routes.home);
  }

  Future<void> deleteButtonOnPressedFunction() async {
    makingChangesInToDo.value = true;
      await ToDoTable().deleteToDo(
       toDo
      );
    makingChangesInToDo.value = false;
    Get.offAllNamed(Routes.home);
  }
}
