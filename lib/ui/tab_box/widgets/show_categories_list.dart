import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/services/db_sqflite/models/category_cached_model.dart';
import 'package:todo_app/ui/widgets/custom_button.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/const.dart';
import 'package:todo_app/utils/text_style.dart';


showCategoriesList(BuildContext context, ValueChanged<CachedCategoryModel> valueChanged) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
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
              children: List.generate(context.watch<TodoProvider>().categories.length, (index) {
                CachedCategoryModel category = context.watch<TodoProvider>().categories[index];
                return GestureDetector(
                  onTap: () {
                    valueChanged.call(category);
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Color(category.categoryColor).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                            child: Icon(
                          IconData(category.iconPath, fontFamily: 'MaterialIcons'),
                          color: Color(category.categoryColor),
                        )),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        category.categoryName,
                        style: MyTextStyle.regularLato.copyWith(fontSize: 14),
                      )
                    ],
                  ),
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
    ),
  );
}
