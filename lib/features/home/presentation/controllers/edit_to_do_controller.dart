import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:uuid/uuid.dart';

class EditToDoPageController extends GetxController {

  final TextEditingController editToDoListTitleTextEditController = TextEditingController();
  final TextEditingController editToDoListDescriptionTextEditController = TextEditingController();

  RxBool addButtonTapped = false.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
  }
  Future<void> addButtonOnPressedFunction() async {
    addButtonTapped.value = true;
    String messageId = const Uuid().v1();
  }

}