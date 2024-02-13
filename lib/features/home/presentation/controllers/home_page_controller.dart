import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/core/internet.dart';
import 'package:to_do_list/core/localDatabase/user_uuid_table.dart';
import 'package:to_do_list/core/utils/design_utils.dart';
import 'package:to_do_list/features/home/data/local/to_do_table.dart';
import 'package:to_do_list/features/home/data/models/to_do_model.dart';
import 'package:to_do_list/features/home/data/remote/data_from_friebase.dart';
import 'package:to_do_list/features/home/presentation/widgets/searchfield_bottomsheet.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  RxString userUUID = "".obs;

  RxList<ToDoModel> toDoList = <ToDoModel>[].obs;
  FocusNode searchFieldFocusNode = FocusNode();

  FocusNode dialogTitleFocusNode = FocusNode();
  FocusNode dialogDescriptionFocusNode = FocusNode();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    userUUID.value = Get.parameters[userUuid] ?? "";
  }

  Future<void> searchButtonOnPressed() async {
    searchFieldFocusNode.unfocus();
    if (searchTextEditController.text.isNotEmpty) {
      toDoList.value = await DataFromFirebase.getSearchToDoList(
        userUUID: userUUID.value,
        todoTitle: searchTextEditController.text,
      );
      if (toDoList.isEmpty) {
        "No todo found according to title you enter".infoSnackBar();
      }else{
        Get.bottomSheet(
            SearchFieldBottomSheet(todoList: toDoList,),
          backgroundColor: AppColors.white,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),),
          ),
        );
      }
    }
  }

  Future<void> toDoListTileIsTapped(ToDoModel todo) async {
    DataFromFirebase.updateTodo(todo, completed: !todo.toDoCompleted);
  }

  Future<void> dialogAddButtonOnPressed() async {
    dialogAddButtonIsTapped.value = true;

    if (toDoListFormKey.currentState!.validate()) {
      DataFromFirebase.createTodoList(
          userUUID: userUUID.value,
          title: toDoListTitleTextEditController.text,
          details: toDoListDescriptionTextEditController.text);
      dialogTitleFocusNode.unfocus();
      dialogDescriptionFocusNode.unfocus();
      toDoListTitleTextEditController.clear();
      toDoListDescriptionTextEditController.clear();
      // await getData();
      Get.back();
      // }
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
