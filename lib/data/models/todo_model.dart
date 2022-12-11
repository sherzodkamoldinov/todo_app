class TodoModel {
  final int createdAt;
  final String id;
  final String title;
  final String subTitle;
  final int categoryId;
  final int priority;
  final bool isDone;

  TodoModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.categoryId,
    required this.priority,
    required this.isDone,
    required this.createdAt,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    String? subTitle,
    int? categoryId,
    int? priority,
    bool? isDone,
    int? createdAt,
  }) =>
      TodoModel(
        id: id ?? this.id,
        title: title ?? this.title,
        subTitle: subTitle ?? this.subTitle,
        categoryId: categoryId ?? this.categoryId,
        priority: priority ?? this.priority,
        isDone: isDone ?? this.isDone,
        createdAt: createdAt ?? this.createdAt,
      );
}
