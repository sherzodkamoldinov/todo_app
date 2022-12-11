import 'package:flutter/material.dart';
import 'package:todo_app/data/models/category_model.dart';

List<CategoryModel> categories = [
  CategoryModel(id: 1, title: 'School', icon: Icons.school, color: const Color(0xFFFF9680)),
  CategoryModel(id: 2, title: 'Woek', icon: Icons.work, color: const Color(0xFFCCFF80)),
  CategoryModel(id: 3, title: 'Cook', icon: Icons.cookie, color:const Color(0xFF80FFFF)),
  CategoryModel(id: 4, title: 'Health', icon: Icons.health_and_safety, color:const Color(0xFFFFCC80)),
  CategoryModel(id: 5, title: 'Home', icon: Icons.home, color: const Color(0xFFFC80FF)),
];
