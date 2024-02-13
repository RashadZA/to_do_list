import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/core/routes/app_pages.dart';
import 'package:to_do_list/core/utils/design_utils.dart';
import 'package:to_do_list/features/home/data/models/to_do_model.dart';

class SearchFieldBottomSheet extends StatelessWidget {
  final List<ToDoModel> todoList;
  final bool showInBottomSheet;
  const SearchFieldBottomSheet({super.key, this.showInBottomSheet = true, required this.todoList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index){
      return listTile(todoList[index]);
    }).paddingSymmetric(horizontal: 24);
  }

  Widget listTile(ToDoModel todo) => ListTile(
    onTap: () => Get.toNamed(Routes.editToDo, parameters: {
      userUuid: todo.uuid,
      todoUuidKey: todo.toDoKey,
    },),
    minVerticalPadding: 0.0,
    contentPadding: const EdgeInsets.all(0),
    title: Text(
      DateFormat.yMMMEd().format(
          todo.toDoCreatedTime.toDate()),
      style: AppTextTheme.text14,
    ),
    subtitle: Text(
      todo.toDoTitle,
      style: AppTextTheme.text18.copyWith(overflow: TextOverflow.visible),
    ),
  ).defaultContainer(backgroundColor: AppColors.backgroundColor).paddingSymmetric(vertical: 10);
}