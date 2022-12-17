import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/services/db_sqflite/models/category_cached_model.dart';
import 'package:todo_app/services/db_sqflite/models/todo_cached_model.dart';
import 'package:todo_app/ui/tab_box/widgets/date_picker.dart';
import 'package:todo_app/ui/tab_box/widgets/show_categories_list.dart';
import 'package:todo_app/ui/tab_box/widgets/show_priorities_list.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';
import 'package:todo_app/utils/utils.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key, required this.valueChanged});

  final ValueChanged<CachedTodoModel> valueChanged;

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.clear();
    _descController.clear();
    _titleController.dispose();
    _descController.dispose();
  }

  DateTime? selectedDate;
  CachedCategoryModel? selectedCategory;
  int? urgentLevel;

  _clearData() {
    selectedDate = null;
    selectedCategory = null;
    urgentLevel = null;
    _descController.clear();
    _titleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: MyColors.buttonColor,
      child: const Icon(Icons.add),
      onPressed: () async {
        _clearData();
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
                      GestureDetector(
                        onTap: () async {
                          selectedDate = await datePicker(context);
                        },
                        child: selectedDate != null
                            ? Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: MyColors.buttonColor,
                                ),
                                child: Text(
                                  DateFormat('dd/MM/yy HH:mm').format(selectedDate!),
                                  style: MyTextStyle.regularLato,
                                ),
                              )
                            : Icon(Icons.timer_outlined, color: MyColors.fontColor),
                      ),

                      // CATEGORIES
                      IconButton(
                        onPressed: () {
                          showCategoriesList(
                            context,
                            (CachedCategoryModel value) {
                              setState(() {
                                selectedCategory = value;
                              });
                            },
                          );
                        },
                        icon: Icon(selectedCategory != null ? IconData(selectedCategory!.iconPath, fontFamily: 'MaterialIcons') : Icons.tag,
                            color: selectedCategory != null ? Color(selectedCategory!.categoryColor) : MyColors.fontColor),
                      ),

                      // PRIORITIES
                      GestureDetector(
                        onTap: () {
                          showPrioritiesList(
                            context,
                            (int index) {
                              urgentLevel = index + 1;
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: MyColors.buttonColor,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [urgentLevel != null ? Text('$urgentLevel', style: MyTextStyle.regularLato) : const SizedBox.shrink(), Icon(Icons.flag_outlined, color: MyColors.fontColor)]),
                        ),
                      ),
                      const Expanded(child: SizedBox()),

                      // SEND
                      IconButton(
                        onPressed: () async {
                          if (_titleController.text.trim().isNotEmpty) {
                            if (selectedDate != null) {
                              if (selectedCategory != null) {
                                var newTodo = CachedTodoModel(
                                    todoTitle: _titleController.text,
                                    todoDescription: _descController.text,
                                    categoryId: selectedCategory!.id!,
                                    dateTime: selectedDate!.millisecondsSinceEpoch,
                                    isDone: 0,
                                    urgentLevel: urgentLevel ?? 5);
                                Navigator.of(context).pop();
                                await context.read<TodoProvider>().insertNewTodo(newTodo);
                                _clearData();
                              } else {
                                MyUtils.closeKeyboard(context);
                                CustomSnackbar.showSnackbar(context, 'Please select category', SnackbarType.warning, fromTop: true);
                              }
                            } else {
                              MyUtils.closeKeyboard(context);
                              CustomSnackbar.showSnackbar(context, 'Please select date time', SnackbarType.warning, fromTop: true);
                            }
                          } else {
                            MyUtils.closeKeyboard(context);
                            CustomSnackbar.showSnackbar(context, 'Please fill title', SnackbarType.error, fromTop: true);
                          }
                        },
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
    );
  }
}
