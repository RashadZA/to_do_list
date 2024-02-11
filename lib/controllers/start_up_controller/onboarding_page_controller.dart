import 'dart:async';

import 'package:get/get.dart';
import 'package:to_do_list/core/routes/app_pages.dart';

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
      getStartButtonIsTapped.value = false;
      Get.offAllNamed(Routes.home);
  }
}