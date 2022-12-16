import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/repository/category_repository.dart';
import 'package:todo_app/data/repository/todo_repository.dart';
import 'package:todo_app/services/db_sqflite/models/category_cached_model.dart';
import 'package:todo_app/services/db_sqflite/models/todo_cached_model.dart';

class TodoProvider extends ChangeNotifier {
  final TodoRepository _repository;
  final CategoryRepository _categoryRepository;
  TodoProvider({required TodoRepository repository, required CategoryRepository categoryRepository})
      : _repository = repository,
        _categoryRepository = categoryRepository;

  bool get isLoading => _isLoading;

  bool _isLoading = false;
  List<List<CachedTodoModel>> todos = [];
  List<List<CachedTodoModel>> doneTodos = [];
  List<List<CachedTodoModel>> notDoneTodos = [];
  List<CachedCategoryModel> categories = [];

  // --------------- TODOS -------------------

  Future<void> getAllTodos() async {
    notify(true);
    List<CachedTodoModel> allTodos = await _repository.getAllCachedTodos();
    if (allTodos.isNotEmpty) {
      todos = sortTime(allTodos);
    } else {
      todos = [];
    }

    notify(false);
  }

  // types
  // 1 - done
  // 0 - not done
  Future<void> getTodosByDone(int doneType) async {
    notify(true);
    var todos = await _repository.getAllCachedTodosByDone(isDone: doneType);
    List<List<CachedTodoModel>> sortedTodos = [];
    if (todos.isNotEmpty) {
      sortedTodos = sortTime(todos);
    }
    if (doneType == 0) {
      notDoneTodos = sortedTodos;
    } else {
      doneTodos = sortedTodos;
    }
    notify(false);
  }

  Future<CachedTodoModel> insertNewTodo(CachedTodoModel newTodo) async {
    var newMyTodo = await _repository.insertCachedTodo(cachedTodo: newTodo);
    getTodosByDone(0);
    return newMyTodo;
  }

  Future<void> updateTodoisDone(int id, int isDone) async {
    await _repository.updateCachedTodoIsDone(id: id, isDone: isDone);
    if (isDone == 1) {
      getTodosByDone(0);
    } else {
      getTodosByDone(1);
    }
  }

  Future<void> deleteAllTodos() async {
    await _repository.deleteAllCachedTodos();
    todos = [];
    notDoneTodos = [];
    doneTodos = [];
    categories = [];
    notify(false);
  }

  // ------------------ CATEGORIES -------------------
  Future<void> getCategories() async {
    notify(true);
    categories = await _categoryRepository.getAllCachedCategories();
    notify(false);
  }

  Future<void> insertNewCategory(CachedCategoryModel newCategory) async {
    notify(true);
    await _categoryRepository.insertCachedCategory(category: newCategory);
    notify(false);
  }

  // ---------------------- HELPER METHODS --------------------
  void notify(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  List<List<CachedTodoModel>> sortTime(List<CachedTodoModel> todosData) {
    todosData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    List<CachedTodoModel> times = [];
    List<List<CachedTodoModel>> sortedTodos = [];
    int currentTime = todosData[0].dateTime;
    for (var element in todosData) {
      if (DateFormat.yMd().format(DateTime.fromMillisecondsSinceEpoch(element.dateTime)) != DateFormat.yMd().format(DateTime.fromMillisecondsSinceEpoch(currentTime))) {
        currentTime = element.dateTime;
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
        print(element.dateTime);
      });
    });
    return sortedTodos;
  }
}
