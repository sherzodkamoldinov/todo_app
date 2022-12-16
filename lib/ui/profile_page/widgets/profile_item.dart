import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

Widget profileItem({required VoidCallback onPressed, required String title, bool? isLogOut,required IconData icon}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    onTap: onPressed,
    title: Text(title, style: MyTextStyle.regularLato.copyWith(color: isLogOut != null ? Colors.red: null)),
    leading: Icon(icon, color: isLogOut != null ? Colors.red: MyColors.fontColor),
    horizontalTitleGap: 0.0,
    trailing: isLogOut == null ? Icon(CupertinoIcons.right_chevron, color: MyColors.fontColor) : null,
  );
}
