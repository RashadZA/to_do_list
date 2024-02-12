import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/core/localDatabase/folder_helper.dart';
import 'package:to_do_list/core/localDatabase/user_uuid_table.dart';
import 'package:to_do_list/core/routes/app_pages.dart';
import 'package:to_do_list/core/utils/design_utils.dart';

class SplashPageController extends GetxController {


  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    String saveUUID = await UserUUIDTable().getUserUUID();
    debugPrint("Save UUID: $saveUUID");
    if (saveUUID.isNotEmpty) {
      Get.offAllNamed(Routes.home,parameters: {
        userUuid : saveUUID,
      },);
    }else{
      Get.offAllNamed(Routes.onboarding);
    }
  }

}