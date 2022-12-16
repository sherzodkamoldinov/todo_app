const String todoTable = 'cached_todos';

class CachedTodoFields {
  static final List<String> values = [id, categoryId, dateTime, isDone, todoDescription, todoTitle, urgentLevel];

  static const String id = "_id";
  static const String todoTitle = "todo_title";
  static const String todoDescription = "todo_description";
  static const String categoryId = "category_id";
  static const String dateTime = "date_time";
  static const String isDone = "is_done";
  static const String urgentLevel = "urgent_level";
}

class CachedTodoModel {
  final int? id;
  final String todoTitle;
  final String todoDescription;
  final int categoryId;
  final int dateTime;
  // 0 - false
  // 1 - true
  final int isDone;
  final int urgentLevel;

  CachedTodoModel({
    this.id,
    required this.todoTitle,
    required this.todoDescription,
    required this.categoryId,
    required this.dateTime,
    required this.isDone,
    required this.urgentLevel,
  });

  CachedTodoModel copyWith({
    int? id,
    String? todoTitle,
    String? todoDescription,
    int? categoryId,
    int? dateTime,
    int? isDone,
    int? urgentLevel,
  }) =>
      CachedTodoModel(
        id: id ?? this.id,
        todoTitle: todoTitle ?? this.todoTitle,
        todoDescription: todoDescription ?? this.todoDescription,
        categoryId: categoryId ?? this.categoryId,
        dateTime: dateTime ?? this.dateTime,
        isDone: isDone ?? this.isDone,
        urgentLevel: urgentLevel ?? this.urgentLevel,
      );

  factory CachedTodoModel.fromJson(Map<String, dynamic> json) => CachedTodoModel(
        id: json[CachedTodoFields.id] as int?,
        todoTitle: json[CachedTodoFields.todoTitle] as String,
        todoDescription: json[CachedTodoFields.todoDescription] as String,
        categoryId: json[CachedTodoFields.categoryId] as int,
        dateTime: json[CachedTodoFields.dateTime] as int,
        isDone: json[CachedTodoFields.isDone] as int,
        urgentLevel: json[CachedTodoFields.urgentLevel] as int,
      );

  Map<String, dynamic> toJson() => {
        CachedTodoFields.id: id,
        CachedTodoFields.todoTitle: todoTitle,
        CachedTodoFields.todoDescription: todoDescription,
        CachedTodoFields.categoryId: categoryId,
        CachedTodoFields.dateTime: dateTime,
        CachedTodoFields.isDone: isDone,
        CachedTodoFields.urgentLevel: urgentLevel
      };

  @override
  String toString() {
    return """
  id: $id,
  title: $todoTitle,
  description: $todoDescription""";
  }
}
