import 'package:flutter/material.dart';
import 'package:todo_app/data/repository/category_repository.dart';
import 'package:todo_app/data/repository/todo_repository.dart';
import 'package:todo_app/services/db_sqflite/models/category_cached_model.dart';
import 'package:todo_app/services/db_sqflite/models/todo_cached_model.dart';
import 'package:todo_app/ui/home_page/widgets/emty_view.dart';
import 'package:todo_app/ui/home_page/widgets/todos_view.dart';
import 'package:todo_app/ui/widgets/custom_home_app_bar.dart';
import 'package:todo_app/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CachedTodoModel> todos = [];
  List<CachedCategoryModel> categories = [];

  _init() async {
    todos = await TodoRepository.getAllCachedTodosByDone(isDone: false);
    categories = await CategoryRepository.getAllCachedCategories();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

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
          children: [
            todos.isEmpty ?
            const EmptyView() :
            Expanded(
                child: TodosView(
              categories: categories,
              todos: todos,
            ))
          ],
        ),
      ),
    );
  }
}
