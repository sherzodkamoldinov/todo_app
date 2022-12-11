import 'package:flutter/material.dart';
import 'package:todo_app/data/repository/storage_repository.dart';
import 'package:todo_app/services/db_sqflite/models/category_cached_model.dart';
import 'package:todo_app/services/db_sqflite/sqlflite_service.dart';
import 'package:todo_app/utils/const.dart';

class CategoryRepository {
  static final CategoryRepository _instance = CategoryRepository._();

  factory CategoryRepository() => _instance;

  CategoryRepository._();

  // INSERT INIT CATEGORIES
  static Future insertInitCategories() async {
    await StorageRepository.putBool(CustomFields.isInitial, true);
    await insetCachedCategory(category: CachedCategoryModel(categoryName: 'Work', iconPath: Icons.work_outline.codePoint, categoryColor: 0xFFA31D00));
    await insetCachedCategory(category: CachedCategoryModel(categoryName: 'School', iconPath: Icons.school_outlined.codePoint, categoryColor: 0xFF0055A3));
    await insetCachedCategory(category: CachedCategoryModel(categoryName: 'Cook', iconPath: Icons.cookie_outlined.codePoint, categoryColor: 0xFF21A300));
    await insetCachedCategory(category: CachedCategoryModel(categoryName: 'Home', iconPath: Icons.home_rounded.codePoint, categoryColor: 0xFFA30000));
    await insetCachedCategory(category: CachedCategoryModel(categoryName: 'Game', iconPath: Icons.sports_esports_outlined.codePoint, categoryColor: 0xFF00A372));
    await insetCachedCategory(category: CachedCategoryModel(categoryName: 'Gym', iconPath: Icons.self_improvement_rounded.codePoint, categoryColor: 0xFF00A3A3));
  }

  static Future<CachedCategoryModel> insetCachedCategory({required CachedCategoryModel category}) async => await LocalDatabase.insetCachedCategory(category);

  static Future<List<CachedCategoryModel>> getAllCachedCategories() async => await LocalDatabase.getAllCachedCategories();

  static Future<CachedCategoryModel> getSingleCachedCategory({required int id}) async => await LocalDatabase.getSingleCachedCategory(id);

  static Future<int> deleteCachedCategoryById({required int id}) async => await LocalDatabase.deleteCachedCategoryById(id);
}
