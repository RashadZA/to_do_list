import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/controllers/start_up_controller/onboarding_page_controller.dart';
import 'package:to_do_list/core/widgets/buttons/core_flat_button.dart';

class OnboardingPage extends GetWidget<OnboardingPageController> {
  const OnboardingPage({Key? key}) : super(key: key);


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
              Positioned(
                bottom: 40,
                left: Get.width * 0.25,
                child: Obx(() => CoreFlatButton(
                  width: Get.width * 0.4,
                  height: 40,
                  text: 'Get Start',
                  isGradientBg: true,
                  onPressed: controller.getStartButtonOnPressed,
                  isLoading: controller.getStartButtonIsTapped.value,
                ).paddingSymmetric(horizontal: 17),),
              )
            ],
          );
        },
      ),
    );
  }
}