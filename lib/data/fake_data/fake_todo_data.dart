import 'package:intl/intl.dart';
import 'package:todo_app/data/models/todo_model.dart';

List<TodoModel> todosData = [
  TodoModel(
    id: '1',
    title: 'Do Math Homework',
    subTitle: 'Do chapter 2 to 5 for next week',
    categoryId: 1,
    priority: 5,
    isDone: false,
    createdAt: DateTime(2022, 12, 9, 19, 30).millisecondsSinceEpoch,
  ),
  TodoModel(
    id: '1',
    title: 'Tack out dogs',
    subTitle: 'Do chapter 2 to 5 for next week',
    categoryId: 2,
    priority: 2,
    isDone: false,
    createdAt: DateTime(2022, 12, 9, 19, 0).millisecondsSinceEpoch,
  ),
  TodoModel(
    id: '1',
    title: 'Business meeting with CEO',
    subTitle: 'Do chapter 2 to 5 for next week',
    categoryId: 5,
    priority: 3,
    isDone: false,
    createdAt: DateTime(2022, 12, 9, 19, 27).millisecondsSinceEpoch,
  ),
  TodoModel(
    id: '1',
    title: 'Buy Grocery',
    subTitle: 'Do chapter 2 to 5 for next week',
    categoryId: 3,
    priority: 5,
    isDone: true,
    createdAt: DateTime(2022, 12, 9, 16, 30).millisecondsSinceEpoch,
  ),
  TodoModel(
    id: '1',
    title: 'Go to gym',
    subTitle: 'Do chapter 2 to 5 for next week',
    categoryId: 4,
    priority: 1,
    isDone: true,
    createdAt: DateTime(2022, 12, 10, 19, 30).millisecondsSinceEpoch,
  ),
  TodoModel(
    id: '1',
    title: 'Go to gym',
    subTitle: 'Do chapter 2 to 5 for next week',
    categoryId: 4,
    priority: 1,
    isDone: true,
    createdAt: DateTime(2022, 12, 10, 19, 30).millisecondsSinceEpoch,
  ),
  TodoModel(
    id: '1',
    title: 'Go to gym',
    subTitle: 'Do chapter 2 to 5 for next week',
    categoryId: 4,
    priority: 1,
    isDone: true,
    createdAt: DateTime(2022, 12, 11, 19, 30).millisecondsSinceEpoch,
  ),
  TodoModel(
    id: '1',
    title: 'Go to gym',
    subTitle: 'Do chapter 2 to 5 for next week',
    categoryId: 4,
    priority: 1,
    isDone: true,
    createdAt: DateTime(2022, 12, 13, 19, 30).millisecondsSinceEpoch,
  ),
];

List<List<TodoModel>> sortTime() {
  todosData.sort((a, b) => a.createdAt.compareTo(b.createdAt));
  List<TodoModel> times = [];
  int a = 0;
  List<List<TodoModel>> sortedTodos = [];
  int currentTime = todosData[0].createdAt;
  for (var element in todosData) {
    if (DateFormat.yMd().format(DateTime.fromMillisecondsSinceEpoch(element.createdAt)) != DateFormat.yMd().format(DateTime.fromMillisecondsSinceEpoch(currentTime))) {
      currentTime = element.createdAt;
      sortedTodos.add(times);
      times = [];
      if (element == todosData.last) {
        sortedTodos.add([element]);
        return sortedTodos;
      }
      times.add(element);
    } else {
      times.add(element);
      if (element == todosData.last) {
        sortedTodos.add(times);
        return sortedTodos;
      }
    }
  }
  sortedTodos.forEach((element) {
    element.forEach((element) {
      print(element.createdAt);
    });
  });
  return sortedTodos;
}
