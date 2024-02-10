import 'dart:async';

import 'package:get/get.dart';
import 'package:to_do_list/core/routes/app_pages.dart';
import 'package:to_do_list/main.dart';

class SplashPageController extends GetxController {


  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    Future.delayed(Duration(seconds: 3)).then((value) => Get.offAllNamed(Routes.onboarding));
  }

}