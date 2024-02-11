import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class EditToDoPageController extends GetxController {

  final TextEditingController editToDoListTitleTextEditController = TextEditingController();
  final TextEditingController editToDoListDescriptionTextEditController = TextEditingController();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
  }

}