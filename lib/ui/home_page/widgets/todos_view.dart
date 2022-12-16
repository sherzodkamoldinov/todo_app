import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/services/db_sqflite/models/todo_cached_model.dart';
import 'package:todo_app/ui/widgets/todo_item.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/icons.dart';
import 'package:todo_app/utils/text_style.dart';
import 'package:todo_app/utils/utils.dart';

class TodosView extends StatefulWidget {
  const TodosView({super.key});

  @override
  State<TodosView> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todo, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SEARCH FIELD
            TextField(
              controller: _searchController,
              style: MyTextStyle.regularLato.copyWith(color: MyColors.fontColor),
              cursorColor: MyColors.hintTextColor,
              decoration: InputDecoration(
                // prefixIconConstraints: BoxConstraints.tight(const Size(20,20)),
                fillColor: MyColors.textFieldColor,
                filled: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: SvgPicture.asset(MyIcons.search, color: MyColors.hintTextColor),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                hintText: 'Search for your task...',
                hintStyle: MyTextStyle.regularLato.copyWith(color: MyColors.hintTextColor),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: MyColors.borderColor, width: 0.8)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: MyColors.borderColor, width: 0.8)),
              ),
            ),
            const SizedBox(height: 12),

            // TODOS
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Expansion Tiles
                    ...List.generate(todo.notDoneTodos.length, (index) {
                      List<CachedTodoModel> time = todo.notDoneTodos[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        color: Colors.transparent,
                        child: ExpansionTileTheme(
                          data: ExpansionTileThemeData(
                              backgroundColor: MyColors.backgroundColor,
                              collapsedTextColor: MyColors.fontColor,
                              collapsedIconColor: MyColors.fontColor,
                              iconColor: MyColors.fontColor,
                              textColor: MyColors.fontColor,
                              tilePadding: const EdgeInsets.symmetric(horizontal: 5),
                              childrenPadding: const EdgeInsets.only(left: 5),
                              collapsedBackgroundColor: MyColors.dialogColor,
                              expandedAlignment: Alignment.topLeft),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: ExpansionTile(
                              onExpansionChanged: (value) {},
                              title: Text(
                                MyUtils.getDateStatus(time[0].dateTime),
                              ),
                              expandedCrossAxisAlignment: CrossAxisAlignment.start,

                              // TODOS
                              children: List.generate(
                                  time.length,
                                  (index) => TodoItem(
                                        todo: time[index],
                                        onPressed: (value) {
                                          setState(() {
                                            time[index] = time[index].copyWith(isDone: value ? 1 : 0);
                                          });
                                          Future.delayed(const Duration(milliseconds: 600), () async {
                                            context.read<TodoProvider>().updateTodoisDone(time[index].id!, value == true ? 1 : 0);
                                          });
                                        },
                                        category: todo.categories.where((element) => element.id == time[index].categoryId).toList().first,
                                      )),
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
