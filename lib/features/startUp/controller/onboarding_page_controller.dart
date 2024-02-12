import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/core/localDatabase/database_helper.dart';
import 'package:to_do_list/core/localDatabase/user_uuid_table.dart';
import 'package:to_do_list/core/routes/app_pages.dart';
import 'package:to_do_list/core/utils/design_utils.dart';
import 'package:uuid/uuid.dart';

class OnboardingPageController extends GetxController {

  RxBool getStartButtonIsTapped = false.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {

  }

  Future<void> getStartButtonOnPressed() async {
    getStartButtonIsTapped.value = true;
    await Permission.storage.request();
    PermissionStatus status = await Permission.storage.status;
    if(status.isGranted){
      Database db = await DatabaseHelper().database;
      debugPrint("Database Status: ${db.isOpen}");
      String uuid = const Uuid().v1();
      debugPrint("Database uuid: $uuid");
      await UserUUIDTable().deleteUserUUID();
      await UserUUIDTable().insertUserUUID(uuId: uuid);
      getStartButtonIsTapped.value = false;
      Get.offAllNamed(Routes.home);
    }else{
      "Please give storage permission for creating database for saving to do list".infoSnackBar();
      if(status.isPermanentlyDenied){
        openAppSettings();
      }
      getStartButtonIsTapped.value = false;
    }

  }
}