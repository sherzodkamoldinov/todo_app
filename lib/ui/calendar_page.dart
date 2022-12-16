import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/extra/dimen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/ui/widgets/custom_app_bar.dart';
import 'package:todo_app/ui/widgets/custom_button.dart';
import 'package:todo_app/ui/widgets/todo_item.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/text_style.dart';
import 'package:todo_app/utils/utils.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime currentDate;
  late DateTime firstDate;
  late DateTime lastDate;
  int difference = 21;
  DateTime now = DateTime.now();
  int activeButton = 0;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    firstDate = DateTime.now();
    lastDate = DateTime.now().add(const Duration(days: 21));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  _init() async {
    await context.read<TodoProvider>().getAllTodos();
    if (context.read<TodoProvider>().todos.isNotEmpty) {
      firstDate = DateTime.fromMillisecondsSinceEpoch(context.read<TodoProvider>().todos.first[0].dateTime);

      lastDate = DateTime.fromMillisecondsSinceEpoch(context.read<TodoProvider>().todos.last[0].dateTime).add(const Duration(days: 1));
      if (lastDate.difference(firstDate).inDays > 21) {
        difference = lastDate.difference(firstDate).inDays;
      }
    } else {}
    sundayAndSaturday();
    setState(() {});
    print(difference);
  }

  sundayAndSaturday() {
    if (firstDate.weekday != DateTime.sunday) {
      firstDate = DateTime(firstDate.year, firstDate.month, firstDate.day - firstDate.weekday);
    }
    if (lastDate.weekday != DateTime.saturday) {
      var beetwen = (DateTime.saturday - lastDate.weekday).abs();
      lastDate = DateTime(lastDate.year, lastDate.month, lastDate.day + beetwen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: const CustomAppBar(title: 'Calendar Page'),
      body: Column(
        children: [
          // DATE PICKER
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              color: MyColors.dialogColor,
            ),
            child: Column(
              children: [
                DatePicker(
                  firstDate,
                  daysCount: difference,
                  height: 65,
                  dayTextStyle: const TextStyle(
                    color: MyColors.buttonColor,
                    fontSize: Dimen.dayTextSize,
                    fontWeight: FontWeight.w500,
                  ),
                  dateTextStyle: TextStyle(
                    color: MyColors.fontColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  monthTextStyle: const TextStyle(
                    color: MyColors.buttonColor,
                    fontSize: Dimen.monthTextSize,
                    fontWeight: FontWeight.w500,
                  ),
                  deactivatedColor: Colors.white.withOpacity(0.2),
                  // controller: _controller,
                  activeDates: context.watch<TodoProvider>().todos.isNotEmpty
                      ? List.generate(context.watch<TodoProvider>().todos.length, (index) => DateTime.fromMillisecondsSinceEpoch(context.watch<TodoProvider>().todos[index][0].dateTime))
                      : [],
                  initialSelectedDate: DateTime.now(),
                  selectionColor: MyColors.buttonColor,
                  selectedTextColor: MyColors.fontColor,
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      currentDate = date;
                      debugPrint('CURRENT DATE: ${date.day}/${date.month}/${date.year}');
                    });
                  },
                ),
              ],
            ),
          ),

          // TODOS NOT DONE / DONE
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: MyColors.dialogColor),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    fillColor: activeButton == 0 ? true : false,
                    onPressed: () {
                      activeButton = 0;
                      setState(() {});
                    },
                    text: MyUtils.getDateStatus(currentDate.millisecondsSinceEpoch, isShort: true),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: CustomButton(
                    fillColor: activeButton == 1 ? true : false,
                    onPressed: () {
                      activeButton = 1;
                      setState(() {});
                    },
                    text: 'Completed',
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: context.read<TodoProvider>().notDoneTodos.where((element) => element.first.dateTime == currentDate.millisecondsSinceEpoch).toList().isNotEmpty ?
            ListView.builder(
              itemCount: context.read<TodoProvider>().notDoneTodos.where((element) => element.first.dateTime == currentDate.millisecondsSinceEpoch).toList()[0].length,
              itemBuilder: (context, index) {
                var todo = context.read<TodoProvider>().notDoneTodos.where((element) => element.first.dateTime == currentDate.millisecondsSinceEpoch).toList()[0][index];
                var categories = context.read<TodoProvider>().categories;
                return TodoItem(onPressed: (value) {}, todo: todo, category: categories.where((element) => element.id == todo.categoryId).first);
              },
            ): Center(child: Text('Here empty please add your tasks for this day', style: MyTextStyle.regularLato, textAlign: TextAlign.center,)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await TodoRepository().deleteAllCachedTodos();
          // context.read<TodoProvider>().getAllTodos();
          debugPrint('CURRENT DAY: $difference');
        },
      ),
    );
  }
}
