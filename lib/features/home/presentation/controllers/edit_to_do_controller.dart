import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/core/routes/app_pages.dart';
import 'package:to_do_list/core/utils/design_utils.dart';
import 'package:to_do_list/features/home/data/local/to_do_table.dart';
import 'package:to_do_list/features/home/data/models/to_do_model.dart';
import 'dart:async';

import 'package:to_do_list/features/home/data/remote/data_from_friebase.dart';

class EditToDoPageController extends GetxController {
  final TextEditingController editToDoListTitleTextEditController =
      TextEditingController();
  final TextEditingController editToDoListDescriptionTextEditController =
      TextEditingController();

  RxBool makingChangesInToDo = false.obs;

  RxString todoString = "".obs;
  ToDoModel toDo = ToDoModel.defaultModel();
  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    await getData();
    update();
  }

  Future<void> getData() async {
    String uuid = Get.parameters[userUuid] ?? "";
    String todoKey = Get.parameters[todoUuidKey] ?? "";
    debugPrint("In Edit Page uuid: $uuid and todoKey: $todoKey");
    toDo =
        await DataFromFirebase.getTodoDetails(userUUID: uuid, todoKey: todoKey);
    // debugPrint("In Edit Page: $todoString");
    // toDo = ToDoModel.fromJson(todoString.value);
    editToDoListTitleTextEditController.text = toDo.toDoTitle;
    editToDoListDescriptionTextEditController.text = toDo.toDoDetails;
    update();
  }

  Future<void> addButtonOnPressedFunction() async {
    makingChangesInToDo.value = true;
    titleFocusNode.unfocus();
    descriptionFocusNode.unfocus();
    if (editToDoListTitleTextEditController.text != toDo.toDoTitle ||
        editToDoListDescriptionTextEditController.text != toDo.toDoDetails || dropDownValue.value != toDo.toDoCompleted) {
      await DataFromFirebase.updateTodo(toDo,
          title: editToDoListTitleTextEditController.text,
          details: editToDoListDescriptionTextEditController.text,
          completed: dropDownValue.value,
      );
      editToDoListTitleTextEditController.clear();
      editToDoListDescriptionTextEditController.clear();
    }
    makingChangesInToDo.value = false;
    Get.offAllNamed(Routes.home, parameters: {
      userUuid: toDo.uuid,
    });
  }

  Future<void> deleteButtonOnPressedFunction() async {
    makingChangesInToDo.value = true;
    await DataFromFirebase.deleteTod(toDo);
    makingChangesInToDo.value = false;
    Get.offAllNamed(Routes.home, parameters: {
      userUuid: toDo.uuid,
    });
  }

  RxBool dropDownValue = false.obs;
  List<DropdownMenuItem<bool>> get dropdownItems {
    List<DropdownMenuItem<bool>> menuItems = [
      DropdownMenuItem(value: true, child: Text("True",style: AppTextTheme.text16,),),
      DropdownMenuItem(value: false, child: Text("False",style: AppTextTheme.text16,),),
    ];
    return menuItems;
  }
  Future<void> changeDropdownValue(bool? status) async {
    dropDownValue.value = status ?? false;
    update();
  }
}
