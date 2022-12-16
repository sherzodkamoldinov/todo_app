import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/extra/dimen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/services/db_sqflite/models/todo_cached_model.dart';
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
  int activeButton = 0;

  List<CachedTodoModel> notDoneTodos = [];
  List<CachedTodoModel> doneTodos = [];

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

    getTodos();

    if (context.read<TodoProvider>().todos.isNotEmpty) {
      firstDate = DateTime.fromMillisecondsSinceEpoch(context.read<TodoProvider>().todos.first[0].dateTime);

      lastDate = DateTime.fromMillisecondsSinceEpoch(context.read<TodoProvider>().todos.last[0].dateTime).add(const Duration(days: 1));

      if (lastDate.difference(firstDate).inDays > 21) {
        difference = lastDate.difference(firstDate).inDays;
      }
    }

    sundayAndSaturday();
    setState(() {});

    debugPrint('COUNT DAYS: $difference');
  }

// SET SUNDAY AND SATURDAY
  sundayAndSaturday() {
    if ((firstDate.weekday != DateTime.sunday)) {
      firstDate = DateTime(firstDate.year, firstDate.month, firstDate.day - firstDate.weekday);
    }

    if (lastDate.weekday != DateTime.saturday) {
      var beetwen = (DateTime.saturday - lastDate.weekday).abs();
      lastDate = DateTime(lastDate.year, lastDate.month, lastDate.day + beetwen);
    }
  }

// GET TODOS AT EACH DATES (DONE AND NOT DONE TODOS)
  void getTodos() {
    notDoneTodos = [];
    doneTodos = [];
    debugPrint('>>CURRENT DATE: $currentDate');
    List<List<CachedTodoModel>> allTodos = context.read<TodoProvider>().todos;
    debugPrint('>>ALL TODOS: ${allTodos.length}');
    for (var sortedTodosByDate in allTodos) {
      if (MyUtils.getDateWithoutHourAndMinut(DateTime.fromMillisecondsSinceEpoch(sortedTodosByDate.first.dateTime)) == MyUtils.getDateWithoutHourAndMinut(currentDate)) {
        for (var element in sortedTodosByDate) {
          element.isDone == 0 ? notDoneTodos.add(element) : doneTodos.add(element);
        }
      }
    }
    debugPrint('>>AFTER GET NOT DONE TODOS: ${notDoneTodos.length}');
    debugPrint('>>AFTER GET DONE TODOS: ${doneTodos.length}');
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

                    // GET TODOS AT EACH DATES (DONE AND NOT DONE TODOS)
                    getTodos();
                  },
                ),
              ],
            ),
          ),

          // TODOS NOT DONE / DONE
          Container(
            margin: const EdgeInsets.fromLTRB(15,10,15,4),
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

          activeButton == 0 ? buildListView(notDoneTodos, 0) : buildListView(doneTodos, 1)
        ],
      ),
    );
  }

  Widget buildListView(List<CachedTodoModel> typeTodo, int type) {
    debugPrint(typeTodo.length.toString());
    return Expanded(
      child: typeTodo.isNotEmpty
          ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: typeTodo.length,
              itemBuilder: (context, index) {
                final todo = typeTodo[index];
                final categories = context.read<TodoProvider>().categories;
                return TodoItem(
                  onPressed: (value) async {
                    setState(() {
                      type == 0 
                      ? notDoneTodos[index] = typeTodo[index].copyWith(isDone: value ? 1 : 0) 
                      : doneTodos[index] = typeTodo[index].copyWith(isDone: value ? 1 : 0);
                    });
                    Future.delayed(const Duration(milliseconds: 300), () async {
                      await context.read<TodoProvider>().updateTodoisDone(typeTodo[index].id!, value == true ? 1 : 0);
                      await context.read<TodoProvider>().getAllTodos();
                      getTodos();
                    });
                  },
                  todo: todo,
                  category: categories.where((element) => element.id == todo.categoryId).first,
                );
              },
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                activeButton == 0 ? 'Here empty please first add tasks for this day.' : 'Here empty please first complite tasks for this day.',
                style: MyTextStyle.regularLato,
                textAlign: TextAlign.center,
                          ),
              )),
    );
  }
}
