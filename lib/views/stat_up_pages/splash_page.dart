import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/controllers/start_up_controller/splash_page_controller.dart';
import 'package:to_do_list/core/utils/design_utils.dart';

class SplashPage extends GetWidget<SplashPageController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Stack(
            children: [
              SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: Image.asset("assets/icons/logo.png",fit: BoxFit.fill,)),
              defaultLoader(
                  color: AppColors.primaryColor,
                  radius: 40
              ),
            ],
          );
        },
      ),
    );
  }
}
