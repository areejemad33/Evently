import 'package:flutter/material.dart';

class CategoryModel{
  String id;
  String name;
  IconData icon;
  String image;
  CategoryModel({required this.id, required this.name, required this.icon, required this.image});


  static List<CategoryModel> categories = [
    CategoryModel(id: "1", name: "Sports", icon: Icons.sports_football, image: ''),
    CategoryModel(id: "2", name: "Birthday", icon: Icons.cake_outlined, image: ''),
    CategoryModel(id: "3", name: "Book Club", icon: Icons.bookmark_border_outlined, image: ''),
    CategoryModel(id: "4", name: "Exhibition", icon: Icons.water_drop_rounded, image: ''),
  ];
  static List<CategoryModel> categoriesWithAll = [
    CategoryModel(id: "0", name: "All", icon: Icons.all_inclusive, image: ''),
    CategoryModel(id: "1", name: "Sports", icon: Icons.sports_football, image: ''),
    CategoryModel(id: "2", name: "Birthday", icon: Icons.cake_outlined, image: ''),
    CategoryModel(id: "3", name: "Book Club", icon: Icons.bookmark_border_outlined, image: ''),
    CategoryModel(id: "4", name: "Exhibition", icon: Icons.water_drop_rounded, image: ''),
  ];
}