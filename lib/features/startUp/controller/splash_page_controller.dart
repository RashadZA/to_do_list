import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:to_do_list/core/localDatabase/folder_helper.dart';
import 'package:to_do_list/core/routes/app_pages.dart';

class SplashPageController extends GetxController {


  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    String savePath = await Folder().getDBDirectoryPath();
    if (await File(savePath).exists()) {
      Get.offAllNamed(Routes.home);
    }else{
      Get.offAllNamed(Routes.onboarding);
    }
  }

}