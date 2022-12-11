import 'package:flutter/material.dart';
import 'package:todo_app/ui/home_page/widgets/bottom_navigator_bar.dart';
import 'package:todo_app/ui/home_page/widgets/show_categories_list.dart';
import 'package:todo_app/ui/home_page/widgets/show_priorities_list.dart';
import 'package:todo_app/ui/home_page/widgets/todos_view.dart';
import 'package:todo_app/ui/widgets/custom_home_app_bar.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descController = TextEditingController();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: CustomHomeAppBar(
        onPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            // EmptyView(),
            Expanded(child: TodosView())
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigatorBar(
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          currentIndex: currentIndex),
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
                            DateTime? time = await _datePicker();
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

  Future<DateTime?> _datePicker() async {
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
}
