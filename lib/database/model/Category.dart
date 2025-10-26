import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Category{
  int id;
  String title;
  IconData icon;

  Category({required this.id,
    required this.title,
    required this.icon});


  static List<Category> getCategories({
    bool includeAll = true
  }){
    List<Category> list =[];
    if(includeAll){
      list.add(Category(
        id: 0,
        title: "All",
        icon: FontAwesome.compass,
      ),);
    }
    list.addAll( [

      Category(
        icon: FontAwesome.bicycle_solid,
        title: "Sport",
        id: 1,
      ),
      Category(
        icon: FontAwesome.playstation_brand,
        title: "Gaming",
        id: 2,
      ),
      Category(
        icon: Icons.work_outline_rounded,
        title: "Workshop",
        id: 3,
      ),
      Category(
        icon: Icons.calendar_today,
        title: "Birthday",
        id: 4,
      ),
    ]);
    return list;
  }
  static String getCategoryImage(int categoryId) {
    switch (categoryId) {
      case 1:
        return 'assets/images/Sport.png';
      case 2:
        return 'assets/images/Gaming.png';
      case 3:
        return 'assets/images/Workshop.png';
      case 4:
        return 'assets/images/Birthday.png';
    }
    return '';
  }
}