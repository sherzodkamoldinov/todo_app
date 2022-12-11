import 'package:flutter/material.dart';
import 'package:todo_app/data/fake_data/fake_category.dart';
import 'package:todo_app/data/models/category_model.dart';
import 'package:todo_app/ui/widgets/custom_button.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/const.dart';
import 'package:todo_app/utils/text_style.dart';

showCategoriesList(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: MyColors.dialogColor,
      scrollable: true,
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
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
                  ))),
          Text('Choose Category', style: MyTextStyle.regularLato),
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
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 0.75,
            children: List.generate(categories.length, (index) {
              CategoryModel category = categories[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: category.color.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                        child: Icon(
                      category.icon,
                      color: category.color,
                    )),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    category.title,
                    style: MyTextStyle.regularLato.copyWith(fontSize: 14),
                  )
                ],
              );
            })),
      ),
      actions: [
        CustomButton(
          fillColor: true,
          onPressed: () {
            Navigator.pushNamed(context, createCategoryPage);
          },
          icon: Icons.add,
          text: 'Create New',
          width: double.infinity,
        )
      ],
    ),
  );
}
