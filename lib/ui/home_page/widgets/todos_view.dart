import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/fake_data/fake_todo_data.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/ui/widgets/todo_item.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/icons.dart';
import 'package:todo_app/utils/text_style.dart';

class TodosView extends StatefulWidget {
  const TodosView({super.key});

  @override
  State<TodosView> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosView> {
  int currentTile = -1;
  List<List<TodoModel>> times = sortTime();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(times.length, (index) {
                  var time = times[index];
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
                            DateTime.fromMillisecondsSinceEpoch(time[0].createdAt).day == DateTime.now().day
                                ? 'Today'
                                : DateTime.fromMillisecondsSinceEpoch(time[0].createdAt).day == DateTime.now().day+1 ? 'Yesterday' : DateFormat('d MMM, ').format(DateTime.fromMillisecondsSinceEpoch(time[0].createdAt)).toLowerCase() +
                                    DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(time[0].createdAt)),
                          ),
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              time.length,
                              (index) => TodoItem(
                                    todo: time[index],
                                    onPressed: (value) {
                                      setState(() {
                                         time[index] =  time[index].copyWith(isDone: value);
                                      });
                                    },
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
  }
}
