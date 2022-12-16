import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/services/db_sqflite/models/category_cached_model.dart';
import 'package:todo_app/services/db_sqflite/models/todo_cached_model.dart';
import 'package:todo_app/ui/widgets/little_category_item.dart';
import 'package:todo_app/ui/widgets/little_priority_item.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.onPressed, required this.todo, required this.category});

  final ValueChanged onPressed;
  final CachedTodoModel todo;
  final CachedCategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(color: MyColors.dialogColor, borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              checkColor: MyColors.dialogColor,
              fillColor: const MaterialStatePropertyAll<Color>(Colors.white),
              side: const BorderSide(color: Colors.white),
              tristate: false,
              activeColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              value: todo.isDone == 0 ? false : true,
              onChanged: onPressed,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  todo.todoTitle,
                  style: MyTextStyle.regularLato,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      DateTime.fromMillisecondsSinceEpoch(todo.dateTime).day == DateTime.now().day
                          ? 'Today'
                          : DateTime.fromMillisecondsSinceEpoch(todo.dateTime).day == DateTime.now().day + 1
                              ? 'Yesterday'
                              : DateFormat('d MMM, ').format(DateTime.fromMillisecondsSinceEpoch(todo.dateTime)).toLowerCase() +
                                  DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(todo.dateTime)),
                      style: MyTextStyle.regularLato.copyWith(fontSize: 14, color: const Color(0xFFAFAFAF)),
                    ),
                    const Expanded(child: SizedBox()),
                    littleCategoryItem(category: category),
                    const SizedBox(width: 12),
                    littlePriorityItem(todo.urgentLevel)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
