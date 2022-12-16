import 'package:flutter/cupertino.dart';
import 'package:todo_app/services/db_sqflite/models/category_cached_model.dart';
import 'package:todo_app/utils/text_style.dart';

Widget littleCategoryItem({required CachedCategoryModel category}) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Color(category.categoryColor).withOpacity(0.6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(IconData(category.iconPath, fontFamily: 'MaterialIcons'), color: Color(category.categoryColor), size: 13),
        const SizedBox(width: 6),
        Text(category.categoryName, style: MyTextStyle.regularLato.copyWith(fontSize: 12)),
      ]),
    );
