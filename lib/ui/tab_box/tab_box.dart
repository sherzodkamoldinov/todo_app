import 'package:flutter/material.dart';
import 'package:todo_app/ui/calendar_page.dart';
import 'package:todo_app/ui/focus_page.dart';
import 'package:todo_app/ui/home_page/home_page.dart';
import 'package:todo_app/ui/home_page/widgets/bottom_navigator_bar.dart';
import 'package:todo_app/ui/profile_page.dart';
import 'package:todo_app/ui/tab_box/widgets/date_picker.dart';
import 'package:todo_app/ui/tab_box/widgets/show_categories_list.dart';
import 'package:todo_app/ui/tab_box/widgets/show_priorities_list.dart';

import '../../utils/colors.dart';
import '../../utils/text_style.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  int currentPage = 0;

  late final TextEditingController _titleController;
  late final TextEditingController _descController;

  List<Widget> pages = const [
    HomePage(),
    CalendarPage(),
    FocusPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: CustomBottomNavigatorBar(
          onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
          currentIndex: currentPage),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.buttonColor,
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            clipBehavior: Clip.hardEdge,
            isDismissible: false,
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                height: 240,
                width: double.infinity,
                decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(16)), color: MyColors.dialogColor),
                child: Column(
                  children: [
                    // TITLE
                    Text('Add Task', style: MyTextStyle.boldLato.copyWith(fontSize: 20)),
                    const SizedBox(height: 14),

                    // MYTODO TITLE
                    SizedBox(
                      height: 43,
                      child: TextField(
                        controller: _titleController,
                        autofocus: _titleController.text.isEmpty ? true : false,
                        textInputAction: TextInputAction.next,
                        cursorColor: MyColors.fontColor,
                        style: MyTextStyle.regularLato,
                        decoration: InputDecoration(
                          hintText: 'Title',
                          hintStyle: MyTextStyle.regularLato.copyWith(color: MyColors.hintTextColor),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: MyColors.borderColor)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: MyColors.dialogColor)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // MYTODO SUBTITLE
                    SizedBox(
                      height: 43,
                      child: TextField(
                        controller: _descController,
                        autofocus: _titleController.text.isNotEmpty && _descController.text.isEmpty ? true : false,
                        cursorColor: MyColors.fontColor,
                        style: MyTextStyle.regularLato,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          hintStyle: MyTextStyle.regularLato.copyWith(color: MyColors.hintTextColor),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: MyColors.borderColor)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: MyColors.dialogColor)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // CATEGORY, DATE, PRIORITY, SEND
                    Row(
                      children: [
                        // DATETIME PICKER
                        IconButton(
                          onPressed: () async {
                            DateTime? time = await datePicker(context);
                            if (time != null) {
                              debugPrint('TIME IS PICKED');
                            }
                          },
                          icon: Icon(Icons.timer_outlined, color: MyColors.fontColor),
                        ),

                        // CATEGORIES
                        IconButton(
                          onPressed: () {
                            showCategoriesList(context);
                          },
                          icon: Icon(Icons.tag, color: MyColors.fontColor),
                        ),

                        // PRIORITIES
                        IconButton(
                          onPressed: () {
                            showPrioritiesList(context);
                          },
                          icon: Icon(Icons.flag_outlined, color: MyColors.fontColor),
                        ),
                        const Expanded(child: SizedBox()),

                        // SEND
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.send, color: MyColors.buttonColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
