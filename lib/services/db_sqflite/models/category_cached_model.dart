const String categoryTable = "cached_category";

class CachedCategoryFields {
  static final List<String> values = [
    id, categoryName,categoryColor, iconPath,
  ];
  static const String id = "_id";
  static const String categoryName = "category_name";
  static const String categoryColor = "category_color";
  static const String iconPath = "icon_path";
}

class CachedCategoryModel {
  final int? id;
  final int categoryColor;
  final String categoryName;
  final int iconPath;

  CachedCategoryModel({
    this.id,
    required this.categoryName,
    required this.iconPath,
    required this.categoryColor,
  });

  CachedCategoryModel copyWith({
    int? id,
    int? categoryColor,
    String? categoryName,
    int? iconPath,
  }) =>
      CachedCategoryModel(
        id: id ?? this.id,
        categoryColor: categoryColor ?? this.categoryColor,
        categoryName: categoryName ?? this.categoryName,
        iconPath: iconPath ?? this.iconPath,
      );

  factory CachedCategoryModel.fromJson(Map<String, Object?> json) => CachedCategoryModel(
        id: json[CachedCategoryFields.id] as int?,
        categoryColor: json[CachedCategoryFields.categoryColor] as int,
        categoryName: json[CachedCategoryFields.categoryName] as String,
        iconPath: json[CachedCategoryFields.iconPath] as int,
      );

  Map<String, Object?> toJson() => {
        CachedCategoryFields.id: id,
        CachedCategoryFields.categoryColor: categoryColor,
        CachedCategoryFields.categoryName: categoryName,
        CachedCategoryFields.iconPath: iconPath,
      };

  @override
  String toString() => '''
        ID: $id 
        CATEGORY NAME $categoryName
        CATEGORY COLOR $categoryColor
        ICON PATH $iconPath
      ''';
}