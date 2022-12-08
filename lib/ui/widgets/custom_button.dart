import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.width, required this.text, required this.onPressed});
  final double? width;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        width: width,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: MyColors.buttonColor,
        ),
        child: Center(
          child: Text(text, style: MyTextStyle.regularLato),
        ),
      ),
    );
  }
}
