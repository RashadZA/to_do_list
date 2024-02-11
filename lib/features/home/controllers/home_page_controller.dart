import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {

  final TextEditingController searchTextEditController = TextEditingController();
  final TextEditingController toDoListTitleTextEditController = TextEditingController();
  final TextEditingController toDoListDescriptionTextEditController = TextEditingController();

  final SearchController searchController = SearchController();
  final GlobalKey<FormState> toDoListFormKey = GlobalKey<FormState>();

  RxBool searchButtonIsTapped = false.obs;
  RxBool checkBoxIsTapped = false.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {

  }

  Future<void> searchButtonOnPressed() async {

  }
  Future<void> dialogAddButtonOnPressed() async {
    toDoListTitleTextEditController.clear();
    toDoListDescriptionTextEditController.clear();
    Get.back();

  }
  Future<void> dialogCancelButtonOnPressed() async {
    toDoListTitleTextEditController.clear();
    toDoListDescriptionTextEditController.clear();
    Get.back();
  }
  Future<void> checkBoxButtonOnChanged(bool? status) async {
    checkBoxIsTapped.value = status ?? false;
  }
}