import 'package:flutter/cupertino.dart';

class CategoryModel {
  final int id;
  final String title;
  final IconData icon;
  final Color color;

  CategoryModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.color
  });
}
