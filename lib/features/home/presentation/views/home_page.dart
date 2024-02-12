import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/core/routes/app_pages.dart';
import 'package:to_do_list/core/utils/design_utils.dart';
import 'package:to_do_list/core/widgets/core_textField.dart';
import 'package:to_do_list/features/home/data/models/to_do_model.dart';
import 'package:to_do_list/features/home/presentation/controllers/home_page_controller.dart';
import 'package:to_do_list/features/home/presentation/widgets/add_to_do_list_dialog.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

class HomePage extends GetWidget<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomePageController>(
        builder: (controller) => OrientationBuilder(
          builder: (context, orientation) {
            return RefreshIndicator(
              onRefresh: () => controller.onRefresh(),
              child: Obx(() => Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      CoreTextField(
                        hintText: "Enter Todo Title",
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.searchTextEditController,
                        suffixIcon: controller.searchButtonIsTapped.isFalse
                            ? IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: AppColors.black,
                          ),
                          onPressed: controller.searchButtonOnPressed,
                        )
                            : defaultLoader(color: AppColors.primaryColor),
                      ).paddingOnly(left: 16, right: 16),
                      controller.gettingToDoData.isTrue
                          ? Expanded(
                        child: defaultLoader(
                            color: AppColors.primaryColor, radius: 40),
                      )
                          : controller.toDoList.isEmpty
                          ? SizedBox(
                        width: Get.width,
                        child: Text(
                          "Your To Do Is Empty",
                          textAlign: TextAlign.center,
                          style: AppTextTheme.text18,
                        ).defaultContainer().paddingAll(16),
                      )
                          : Expanded(
                        child: TransformableListView.builder(
                          itemCount: controller.toDoList.length,
                          padding: EdgeInsets.fromLTRB(
                            16,
                            16,
                            16,
                            Get.bottomBarHeight + 60,
                          ),
                          getTransformMatrix: getTransformMatrix,
                          itemBuilder:
                              (BuildContext context, int index) {
                            ToDoModel todo =
                            controller.toDoList[index];
                            return ListTile(
                              onTap: () => controller.toDoListTileIsTapped(todo),
                              leading: Icon(
                                Icons.done_all_rounded,
                                color: todo.toDoCompleted
                                    ? AppColors.primaryColor
                                    : AppColors.backgroundColor,
                              ),
                              trailing: IconButton(
                                onPressed: () =>
                                    Get.toNamed(Routes.editToDo,parameters: {"todo": todo.toString(),}),
                                icon: const Icon(Icons.edit),
                              ),
                              minVerticalPadding: 0.0,
                              contentPadding: const EdgeInsets.all(0),
                              title: Text(
                                todo.toDoTitle,
                                style: AppTextTheme.text18.copyWith(
                                    overflow: TextOverflow.visible),
                              ),
                            )
                                .defaultContainer()
                                .paddingSymmetric(vertical: 10);
                          },
                        ),
                      ),
                    ],
                  ),
                  !controller.updatingToDoAsCompletedOrNot.value
                      ? const SizedBox(
                    height: 0.0,
                    width: 0.0,
                  )
                      : defaultLoader(),
                ],
              )),
            );
          },
        ),
      ),
      floatingActionButton: Obx(() =>  defaultFloatingActionButton(
        isLoading: controller.updatingToDoAsCompletedOrNot.value,
        onPressed: () => Get.dialog(const AddToDoListDialog(),
            barrierDismissible: controller.dialogAddButtonIsTapped.value),
      ),),
    );
  }
}
