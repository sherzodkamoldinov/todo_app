import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

showPrioritiesList(BuildContext context, ValueChanged<int> valueSelected) {
  showDialog(
    context: context,
    builder: (context) {
      List<int> priorities = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
      return AlertDialog(
        backgroundColor: MyColors.dialogColor,
        scrollable: true,
        titlePadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        title: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                splashRadius: 25,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: MyColors.buttonColor,
                ),
              ),
            ),
            Text(
              'Choose Priority',
              style: MyTextStyle.regularLato,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Divider(
                color: MyColors.hintTextColor,
                thickness: 2,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: GridView.count(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: List.generate(
              priorities.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    valueSelected.call(index);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: MyColors.backgroundColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flag_outlined, color: MyColors.fontColor),
                        const SizedBox(height: 7),
                        Text('${priorities[index]}', style: MyTextStyle.regularLato),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
