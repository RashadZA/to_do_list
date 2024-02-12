import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/core/utils/design_utils.dart';
import 'package:to_do_list/features/home/data/local/to_do_table.dart';
import 'package:to_do_list/features/home/data/models/to_do_model.dart';
import 'package:uuid/uuid.dart';

class HomePageController extends GetxController {
  final TextEditingController searchTextEditController =
      TextEditingController();
  final TextEditingController toDoListTitleTextEditController =
      TextEditingController();
  final TextEditingController toDoListDescriptionTextEditController =
      TextEditingController();

  final SearchController searchController = SearchController();
  final GlobalKey<FormState> toDoListFormKey = GlobalKey<FormState>();

  RxBool searchButtonIsTapped = false.obs;

  RxBool dialogAddButtonIsTapped = false.obs;

  RxBool gettingToDoData = false.obs;
  RxBool updatingToDoAsCompletedOrNot = false.obs;

  RxList<ToDoModel> toDoList = <ToDoModel>[].obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    gettingToDoData.value = true;
    await getData();
    gettingToDoData.value = false;
  }
  Future<void> onRefresh() async {
    searchTextEditController.clear();
    getData();
  }

  Future<void> getData() async {
    toDoList.value = await ToDoTable().getToDoList();
  }
  Future<void> searchButtonOnPressed() async {
    if(searchTextEditController.text.isNotEmpty){
      gettingToDoData.value = true;
      toDoList.value = await ToDoTable().getToDoAccordingToTitle(searchTextEditController.text);
      if(toDoList.isEmpty){
        "No todo found according to title you enter".infoSnackBar();
        await getData();
      }
      gettingToDoData.value = false;
    }
  }

  Future<void> toDoListTileIsTapped(ToDoModel todo) async {
    updatingToDoAsCompletedOrNot.value = true;
    await ToDoTable().updateToDoStatus(todo);
    await getData();
    updatingToDoAsCompletedOrNot.value = false;
  }

  Future<void> dialogAddButtonOnPressed() async {
    dialogAddButtonIsTapped.value = true;
    if (toDoListFormKey.currentState!.validate()) {
      String todoId = const Uuid().v1();
      await ToDoTable().insertToDo(
        todoKey: todoId,
        todoTitle: toDoListTitleTextEditController.text,
        todoDetails: toDoListDescriptionTextEditController.text,
        todoCreatedTime: "${DateTime.now()}",
        todoCompleted: 0,
        todoUploaded: 0,
      );
      toDoListTitleTextEditController.clear();
      toDoListDescriptionTextEditController.clear();
      await getData();
      Get.back();
    }
    dialogAddButtonIsTapped.value = false;

  }

  Future<void> dialogCancelButtonOnPressed() async {
    if (dialogAddButtonIsTapped.isFalse) {
      toDoListTitleTextEditController.clear();
      toDoListDescriptionTextEditController.clear();
      Get.back();
    }
  }
}
