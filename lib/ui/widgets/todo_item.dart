import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/fake_data/fake_category.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/ui/widgets/little_category_item.dart';
import 'package:todo_app/ui/widgets/little_priority_item.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.onPressed, required this.todo});

  final ValueChanged onPressed;
  final TodoModel todo;

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
              value: todo.isDone,
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
                  todo.title,
                  style: MyTextStyle.regularLato,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      'Today at ${DateFormat('HH: mm').format(DateTime.fromMillisecondsSinceEpoch(todo.createdAt))}',
                      style: MyTextStyle.regularLato.copyWith(fontSize: 14, color: const Color(0xFFAFAFAF)),
                    ),
                    const Expanded(child: SizedBox()),
                    littleCategoryItem(category: categories.where((element) => element.id == todo.categoryId).toList()[0]),
                    const SizedBox(width: 12),
                    littlePriorityItem(todo.priority)
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
