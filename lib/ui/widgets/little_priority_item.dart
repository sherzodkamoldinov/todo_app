import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

Widget littlePriorityItem(int priority) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      border: Border.all(
        color: MyColors.buttonColor,
      ),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.emoji_flags_sharp, color: MyColors.fontColor,size: 14),
        const SizedBox(width: 5),
        Text('$priority', style: MyTextStyle.regularLato.copyWith(fontSize: 12),)
      ],
    ),
    
  );
}
