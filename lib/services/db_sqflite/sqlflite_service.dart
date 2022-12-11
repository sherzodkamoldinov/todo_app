import 'package:sqflite/sqflite.dart';
import 'package:todo_app/services/db_sqflite/models/category_cached_model.dart';
import 'package:todo_app/services/db_sqflite/models/todo_cached_model.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._init();

  factory LocalDatabase() {
    return _instance;
  }

  LocalDatabase._init();

  static Database? _database;

  // ===== CREATE DATABASE ======
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB('todos.db');
      return _database!;
    }
  }

  Future<Database> _initDB(String dataName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dataName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
    CREATE TABLE $todoTable(
      ${CachedTodoFields.id} $idType,
      ${CachedTodoFields.todoTitle} $textType,
      ${CachedTodoFields.todoDescription} $textType,
      ${CachedTodoFields.categoryId} $intType,
      ${CachedTodoFields.dateTime} $intType,
      ${CachedTodoFields.isDone} $boolType,
      ${CachedTodoFields.urgentLevel} $intType
    )
    ''');

    await db.execute('''
    CREATE TABLE $categoryTable (
    ${CachedCategoryFields.id} $idType,
    ${CachedCategoryFields.categoryName} $textType,
    ${CachedCategoryFields.iconPath} $intType,
    ${CachedCategoryFields.categoryColor} $intType
    )
    ''');
  }

  // --------------------------- CACHED TODOS TABLE --------------------------

  static Future<CachedTodoModel> insertCachedTodo(CachedTodoModel todo) async {
    final db = await _instance.database;
    final id = await db.insert(todoTable, todo.toJson());
    return todo.copyWith(id: id);
  }

  static Future<CachedTodoModel> getSingleTodoById(int id) async {
    final db = await _instance.database;
    final result = await db.query(
      todoTable,
      columns: CachedTodoFields.values,
      where: '${CachedTodoFields.id} = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return CachedTodoModel.fromJson(result.first);
    } else {
      throw Exception('$id ID not found');
    }
  }

  static Future<List<CachedTodoModel>> getAllCachedTodos() async {
    final db = await _instance.database;
    const orderBy = '${CachedTodoFields.dateTime} ASC';
    final result = await db.query(
      todoTable,
      orderBy: orderBy,
    );
    return result.map((json) => CachedTodoModel.fromJson(json)).toList();
  }

  static Future<List<CachedTodoModel>> getAllCachedTodosByDone(bool isDone) async {
    final db = await _instance.database;
    final result = await db.query(todoTable, where: '${CachedTodoFields.isDone}=?', whereArgs: [isDone]);
    return result.map((json) => CachedTodoModel.fromJson(json)).toList();
  }

  static Future deleteAllCachedTodos() async {
    final db = await _instance.database;
    return db.delete(todoTable);
  }

  static Future<int> deleteCachedTodoById(int id) async {
    final db = await _instance.database;
    var todo = await db.delete(
      todoTable,
      where: '${CachedTodoFields.id}=?',
      whereArgs: [id],
    );
    if (todo > 0) {
      return todo;
    } else {
      return -1;
    }
  }

  static Future<int> updateCachedTodo({
    required int id,
    required CachedTodoModel todo,
  }) async {
    Map<String, dynamic> row = {
      CachedTodoFields.todoTitle: todo.todoTitle,
      CachedTodoFields.todoDescription: todo.todoDescription,
      CachedTodoFields.categoryId: todo.categoryId,
      CachedTodoFields.dateTime: todo.dateTime,
      CachedTodoFields.urgentLevel: todo.urgentLevel,
      CachedTodoFields.isDone: todo.isDone,
    };
    final db = await _instance.database;
    final result = await db.update(
      todoTable,
      row,
      where: '${CachedTodoFields.id}=?',
      whereArgs: [id],
    );
    return result;
  }

  static Future<int> updateCachedTodoIsDone(int id, bool isDone) async {
    Map<String, dynamic> row = {
      CachedTodoFields.isDone: isDone,
    };
    final db = await _instance.database;
    return db.update(
      todoTable,
      row,
      where: '${CachedTodoFields.id}=?',
      whereArgs: [id],
    );
  }
  // --------------------------- CACHED TODOS CATEGORY --------------------------

  static Future<CachedCategoryModel> insetCachedCategory(CachedCategoryModel category) async {
    final db = await _instance.database;
    final id = await db.insert(categoryTable, category.toJson());
    return category.copyWith(id: id);
  }

  static Future<List<CachedCategoryModel>> getAllCachedCategories() async {
    const orderBy = '${CachedCategoryFields.categoryName} ASC';
    final db = await _instance.database;
    final result = await db.query(categoryTable, orderBy: orderBy);
    return result.map((json) => CachedCategoryModel.fromJson(json)).toList();
  }

  static Future<CachedCategoryModel> getSingleCachedCategory(int id) async {
    final db = await _instance.database;
    final result = await db.query(
      categoryTable,
      columns: CachedCategoryFields.values,
      where: '${CachedCategoryFields.id}=?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return CachedCategoryModel.fromJson(result.first);
    } else {
      throw Exception('$id ID not found');
    }
  }

  static Future<int> deleteCachedCategoryById(int id) async {
    final db = await _instance.database;
    final deletedCategoryId = await db.delete(
      todoTable,
      where: '${CachedCategoryFields.id}=?',
      whereArgs: [id],
    );
    if (deletedCategoryId > 0) {
      return deletedCategoryId;
    } else {
      return -1;
    }
  }

  Future close() async {
    final db = await _instance.database;
    db.close();
  }
}
