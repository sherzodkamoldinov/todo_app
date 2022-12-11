import 'package:flutter/cupertino.dart';
import 'package:todo_app/data/models/category_model.dart';
import 'package:todo_app/utils/text_style.dart';

Widget littleCategoryItem({required CategoryModel category}) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: category.color.withOpacity(0.6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(category.icon, color: category.color, size: 13),
        const SizedBox(width: 6),
        Text(category.title, style: MyTextStyle.regularLato.copyWith(fontSize: 12)),
      ]),
    );
