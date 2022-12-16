import 'package:todo_app/services/db_sqflite/models/todo_cached_model.dart';
import 'package:todo_app/services/db_sqflite/sqlflite_service.dart';

class TodoRepository {
  static final TodoRepository _instance = TodoRepository._();
  factory TodoRepository() {
    return _instance;
  }

  TodoRepository._();

  Future<CachedTodoModel> insertCachedTodo({required CachedTodoModel cachedTodo}) async {
    return await LocalDatabase.insertCachedTodo(cachedTodo);
  }

  Future<CachedTodoModel> getSingleTodoById({required int id}) async {
    return await LocalDatabase.getSingleTodoById(id);
  }

  Future<List<CachedTodoModel>> getAllCachedTodos() async {
    return await LocalDatabase.getAllCachedTodos();
  }

  Future<List<CachedTodoModel>> getAllCachedTodosByDone({required int isDone}) async {
    return await LocalDatabase.getAllCachedTodosByDone(isDone);
  }

  Future<int> updateCachedTodoIsDone({required int isDone, required int id}) async {
    return await LocalDatabase.updateCachedTodoIsDone(id, isDone);
  }

  Future<int> updateCachedTodoById({required int id, required CachedTodoModel cachedTodo}) async {
    return await LocalDatabase.updateCachedTodo(id: id, todo: cachedTodo);
  }

  Future<int> deleteAllCachedTodos() async {
    return await LocalDatabase.deleteAllCachedTodos();
  }

  Future<int> deleteCachedTodoById({required int id}) async {
    return await LocalDatabase.deleteCachedTodoById(id);
  }
}
