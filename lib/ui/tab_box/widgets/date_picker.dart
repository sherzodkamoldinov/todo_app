import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

Future<DateTime?> datePicker(BuildContext context) async {
    final DateTime? date;
    final TimeOfDay? time;

    date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              backgroundColor: MyColors.dialogColor,
              colorScheme: ColorScheme.dark(
                  onPrimary: MyColors.dialogColor, // selected text color
                  onSurface: MyColors.fontColor, // default text color
                  primary: MyColors.buttonColor // circle color
                  ),
              primaryColor: MyColors.dialogColor,
              dialogBackgroundColor: MyColors.dialogColor,
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: MyColors.fontColor,
                  textStyle: MyTextStyle.regularLato.copyWith(fontSize: 14), // color of button's letters
                  backgroundColor: MyColors.buttonColor, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            child: child!,
          );
        });

    if (date != null) {
      time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                backgroundColor: MyColors.dialogColor,
                colorScheme: ColorScheme.dark(
                    onPrimary: MyColors.dialogColor, // selected text color
                    onSurface: MyColors.fontColor, // default text color
                    primary: MyColors.buttonColor // circle color
                    ),
                primaryColor: MyColors.dialogColor,
                dialogBackgroundColor: MyColors.dialogColor,
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: MyColors.fontColor,
                    textStyle: MyTextStyle.regularLato.copyWith(fontSize: 14), // color of button's letters
                    backgroundColor: MyColors.buttonColor, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              child: child!,
            );
          });
      if (time != null) {
        return DateTime(date.year, date.month, date.day, time.hour, time.minute);
      }
    }
    return null;
  }