import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/utils/colors.dart';

List<BottomNavigationBarItem> bottomNavigatoItems() => const [
  BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Todos',
      backgroundColor: MyColors.dialogColor
    ),
  BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month),
      label: 'Calendar',
      backgroundColor: MyColors.dialogColor
    ),
  BottomNavigationBarItem(
      icon: Icon(Icons.timer),
      label: 'Focus',
      backgroundColor: MyColors.dialogColor
    ),
  BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.userAstronaut),
      label: 'Profile',
      tooltip: 'My Profile',
      backgroundColor: MyColors.dialogColor
    ),
];
