import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/core/routes/app_pages.dart';
import 'package:to_do_list/core/utils/design_utils.dart';
import 'package:to_do_list/core/widgets/core_textField.dart';
import 'package:to_do_list/features/home/presentation/controllers/edit_to_do_controller.dart';

class EditToDoPage extends GetWidget<EditToDoPageController> {
  const EditToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: OrientationBuilder(
          builder: (context, orientation) {
            return SingleChildScrollView(
                child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Get.offAllNamed(Routes.home),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          size: 30,
                          color: AppColors.black,
                        )),
                    Text(
                      "Edit To Do",
                      style: AppTextTheme.text22
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Obx(() => IconButton(
                      onPressed: controller.deleteButtonOnPressedFunction,
                      icon:  Icon(
                        Icons.delete,
                        size: 30,
                        color: controller.makingChangesInToDo.isTrue
                            ? AppColors.transparent : AppColors.redAccent,
                      ),
                    ),),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    CoreTextField(
                      hintText: 'Title',
                      minLines: 2,
                      maxLines: 5,
                      fillColor: AppColors.backgroundColor,
                      keyboardType: TextInputType.text,
                      controller:
                          controller.editToDoListTitleTextEditController,
                      validator: AppValidators.emptyNullValidator,
                    ),
                    const SizedBox(height: 20),
                    CoreTextField(
                      hintText: 'Description',
                      minLines: 7,
                      maxLines: 15,
                      fillColor: AppColors.backgroundColor,
                      controller:
                          controller.editToDoListDescriptionTextEditController,
                      validator: AppValidators.emptyNullValidator,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                    )
                  ],
                ).paddingSymmetric(horizontal: 15),
              ],
            ));
          },
        ),
        floatingActionButton: Obx(() => defaultFloatingActionButton(
          isLoading: controller.makingChangesInToDo.value,
            onPressed: () => controller.addButtonOnPressedFunction(),
            icon: Icons.done_all_rounded,
        ),
        ),
      ),
    );
  }
}
