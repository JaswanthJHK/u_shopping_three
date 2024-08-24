import 'package:flutter/material.dart';

enum Categories {
  vegetables,
  fruits,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other,
}

class CategoryModel {
  final String title;
  final Color color;

 const CategoryModel
 (this.title,  this.color);
}
