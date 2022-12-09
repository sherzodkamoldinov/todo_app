import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.width, required this.text, required this.onPressed, required this.fillColor, this.icon});
  final double? width;
  final String text;
  final VoidCallback onPressed;
  final bool fillColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        width: width,
        height: 48,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(4), color: fillColor ? MyColors.buttonColor : null, border: !fillColor ? Border.all(color: MyColors.buttonColor, width: 2) : null),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Icon(
                      icon,
                      color: MyColors.fontColor,
                      size: 20,
                    )
                  : const SizedBox.shrink(),
              if (icon != null) const SizedBox(width: 15),
              Text(text, style: MyTextStyle.regularLato),
            ],
          ),
        ),
      ),
    );
  }
}
