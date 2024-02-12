import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/core/utils/design_utils.dart';
import 'package:to_do_list/core/widgets/buttons/core_flat_button.dart';
import 'package:to_do_list/core/widgets/core_textField.dart';
import 'package:to_do_list/features/home/presentation/controllers/home_page_controller.dart';

class AddToDoListDialog extends GetWidget<HomePageController> {
  const AddToDoListDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Form(
          key: controller.toDoListFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add your To Do",
                style: AppTextTheme.text18.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              CoreTextField(
                hintText: 'Title',
                maxLines: 3,
                focusNode: controller.dialogTitleFocusNode,
                fillColor: AppColors.backgroundColor,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: controller.toDoListTitleTextEditController,
                validator: AppValidators.emptyNullValidator,
              ),
              const SizedBox(height: 5),
              CoreTextField(
                hintText: 'Description',
                maxLines: 5,
                fillColor: AppColors.backgroundColor,
                focusNode: controller.dialogDescriptionFocusNode,
                controller: controller.toDoListDescriptionTextEditController,
                validator: AppValidators.emptyNullValidator,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 80,
                    child: CoreFlatButton(
                      text: "Cancel",
                      textColor: AppColors.backgroundColor,
                      bgColor: Colors.transparent,
                      border: Border.all(color: AppColors.backgroundColor),
                      onPressed: controller.dialogCancelButtonOnPressed,
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Obx(() => CoreFlatButton(
                      text: 'Add',
                      isGradientBg: true,
                      isLoading: controller.dialogAddButtonIsTapped.value,
                      loaderColor: AppColors.white,
                      onPressed: controller.dialogAddButtonOnPressed,
                    ),),
                  ),
                ],
              ),
            ],
          ).defaultContainer(),
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}