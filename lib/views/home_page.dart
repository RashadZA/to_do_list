import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/controllers/home_page_controller.dart';
import 'package:to_do_list/core/utils/design_utils.dart';
import 'package:to_do_list/core/widgets/buttons/core_flat_button.dart';
import 'package:to_do_list/core/widgets/core_textField.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

class HomePage extends GetWidget<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              CoreTextField(
                hintText: "Search",
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                controller: controller.searchTextEditController,
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: AppColors.black,
                  ),
                  onPressed: controller.searchButtonOnPressed,
                ),
              ).paddingOnly(left: 16, right: 16),

              Expanded(
                child: TransformableListView.builder(
                  itemCount: 20,
                  padding: EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    Get.bottomBarHeight + 60,
                  ),
                  getTransformMatrix: getTransformMatrix,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: const Icon(
                        Icons.check_box,
                        color: AppColors.primaryColor,
                      ),
                      minVerticalPadding: 0.0,
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        "Test1111111111111111111111111111111111111111111111111111",
                        style: AppTextTheme.text18
                            .copyWith(overflow: TextOverflow.visible),
                      ),
                    ).defaultContainer().paddingSymmetric(vertical: 10);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.dialog(
          const AddToDoListDialog(),
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.white,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.gradientStartColor,
                AppColors.gradientEndColor,
              ],
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

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
                fillColor: AppColors.backgroundColor,
                keyboardType: TextInputType.text,
                controller: controller.toDoListTitleTextEditController,
                validator: AppValidators.emptyNullValidator,
              ),
              const SizedBox(height: 5),
              CoreTextField(
                hintText: 'Description',
                maxLines: 5,
                fillColor: AppColors.backgroundColor,
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
                    width: 70,
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
                    child: CoreFlatButton(
                      text: 'Add',
                      isGradientBg: true,
                      loaderColor: AppColors.white,
                      onPressed: controller.dialogAddButtonOnPressed,
                    ),
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
