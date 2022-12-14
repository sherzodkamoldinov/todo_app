import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/repository/category_repository.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/services/db_sqflite/models/category_cached_model.dart';
import 'package:todo_app/ui/widgets/custom_app_bar.dart';
import 'package:todo_app/ui/widgets/custom_button.dart';
import 'package:todo_app/ui/widgets/custom_textfield.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';
import 'package:todo_app/utils/utils.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  late final TextEditingController _controller;
  List<IconData> icons = [
    Icons.home,
    Icons.work_outline,
    Icons.video_camera_back_outlined,
    FontAwesomeIcons.music,
    FontAwesomeIcons.gamepad,
    FontAwesomeIcons.heart,
    FontAwesomeIcons.cookie,
    FontAwesomeIcons.book,
    FontAwesomeIcons.kitchenSet,
    FontAwesomeIcons.amazon,
    Icons.sports_baseball_outlined,
    Icons.school_outlined,
  ];
  IconData? selectedIcon;
  Color selectedColor = MyColors.fontColor;
  int myColor = 0xFFFFFFFF;
  Color selectedBackColor = MyColors.dialogColor;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.backgroundColor,
      appBar: const CustomAppBar(
        title: 'Create new category',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // enter category name and choose icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TEXT FIELD
                Text('Category name:', style: MyTextStyle.regularLato),
                const SizedBox(height: 10),
                CustomTextField(maxLength: 12, controller: _controller, isEnd: false, hintText: 'Category name', isPassword: false, isFill: true,),
                const SizedBox(height: 20),
                // CHOOSE ICON
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
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
                                Text('Choose Icon', style: MyTextStyle.regularLato),
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
                                crossAxisCount: 3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                children: List.generate(
                                  icons.length,
                                  (index) {
                                    return CircleAvatar(
                                      backgroundColor: MyColors.buttonColor,
                                      minRadius: 30,
                                      maxRadius: 30,
                                      child: Center(
                                          child: IconButton(
                                        icon: Icon(
                                          icons[index],
                                          color: MyColors.fontColor,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            selectedIcon = icons[index];
                                          });
                                          Navigator.pop(context);
                                        },
                                      )),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  style: ElevatedButton.styleFrom(primary: selectedBackColor),
                  child: selectedIcon != null
                      ? Icon(
                          selectedIcon!,
                          color: selectedColor,
                        )
                      : Text(
                          'Choose icon',
                          style: MyTextStyle.regularLato,
                        ),
                ),
                const SizedBox(height: 20),
                Text('Category color:', style: MyTextStyle.regularLato),
                const SizedBox(height: 10),
              ],
            ),
          ),

          // choose colors
          SizedBox(
            height: 40,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              reverse: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              children: List.generate(
                  MyColors.categoryColors.length,
                  (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = Color(MyColors.categoryColors[index]);
                            selectedBackColor = Color(MyColors.categoryColors[index]).withOpacity(0.5);
                            myColor = MyColors.categoryColors[index];
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(MyColors.categoryColors[index]),
                          minRadius: 30,
                          child: const SizedBox.square(
                            dimension: 30,
                          ),
                        ),
                      )),
            ),
          ),

          // cancel and create button
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: MyTextStyle.regularLato.copyWith(color: MyColors.buttonColor),
                      )),
                  CustomButton(
                      fillColor: true,
                      onPressed: () async {
                        if (_controller.text.trim().isNotEmpty) {
                          if (selectedIcon != null) {
                            var newCategory = CachedCategoryModel(
                              categoryName: _controller.text,
                              iconPath: selectedIcon!.codePoint,
                              categoryColor: myColor,
                            );
                            await context.read<TodoProvider>().insertNewCategory(newCategory);
                            await context.read<TodoProvider>().getCategories();
                            if (!mounted) return;
                            Navigator.pop(context);
                          } else {
                            CustomSnackbar.showSnackbar(context, 'Please select icon', SnackbarType.warning, fromTop: true);
                          }
                        } else {
                          CustomSnackbar.showSnackbar(context, 'Fill name of category', SnackbarType.warning, fromTop: true);
                        }
                      },
                      text: 'Create Category')
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
