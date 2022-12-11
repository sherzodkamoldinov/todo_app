import 'package:flutter/material.dart';
import 'package:todo_app/ui/home_page/widgets/bottom_navigator_items.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

class CustomBottomNavigatorBar extends StatelessWidget {
  const CustomBottomNavigatorBar({super.key, required this.onTap, required this.currentIndex});
  final ValueChanged onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: MyTextStyle.regularLato.copyWith(fontSize: 12, color: MyColors.buttonColor),
      unselectedLabelStyle: MyTextStyle.regularLato.copyWith(fontSize: 12),
      currentIndex: currentIndex,
      onTap: onTap,
      unselectedItemColor: MyColors.fontColor,
      backgroundColor: MyColors.dialogColor,
      iconSize: 24,
      selectedItemColor: MyColors.buttonColor,
      type: BottomNavigationBarType.fixed,
      items: bottomNavigatoItems(),
    );
  }
}
