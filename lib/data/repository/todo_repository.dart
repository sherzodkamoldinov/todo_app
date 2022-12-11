import 'package:todo_app/services/db_sqflite/models/todo_cached_model.dart';
import 'package:todo_app/services/db_sqflite/sqlflite_service.dart';

class TodoRepository {
  static final TodoRepository _instance = TodoRepository._();
  factory TodoRepository() {
    return _instance;
  }

  TodoRepository._();

  static Future<CachedTodoModel> insertCachedTodo({required CachedTodoModel cachedTodo}) async {
    return await LocalDatabase.insertCachedTodo(cachedTodo);
  }

  static Future<CachedTodoModel> getSingleTodoById({required int id}) async {
    return await LocalDatabase.getSingleTodoById(id);
  }

  static Future<List<CachedTodoModel>> getAllCachedTodos() async {
    return await LocalDatabase.getAllCachedTodos();
  }

  static Future<List<CachedTodoModel>> getAllCachedTodosByDone({required bool isDone}) async {
    return await LocalDatabase.getAllCachedTodosByDone(isDone);
  }

  static Future<int> updateCachedTodoIsDone({required bool isDone, required int id}) async {
    return await LocalDatabase.updateCachedTodoIsDone(id, isDone);
  }

  static Future<int> updateCachedTodoById({required int id, required CachedTodoModel cachedTodo}) async {
    return await LocalDatabase.updateCachedTodo(id: id, todo: cachedTodo);
  }

  static Future<int> deleteAllCachedTodos() async {
    return await LocalDatabase.deleteAllCachedTodos();
  }

  static Future<int> deleteCachedTodoById({required int id}) async {
    return await LocalDatabase.deleteCachedTodoById(id);
  }
}
