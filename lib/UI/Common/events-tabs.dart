
import 'package:events/UI/Common/tab_bar_item.dart';
import 'package:events/database/model/Category.dart';
import 'package:flutter/material.dart';

typedef OnTabSelected = Function(int index,Category category);
class EventsTabs extends StatelessWidget {
  List<Category> categories;
  OnTabSelected onTabSelected;
  int currentTabIndex ;
  EventsTabs(
      this.categories,
      this.currentTabIndex,this.onTabSelected,{
        this.reversed = false
      });
  bool reversed;
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: categories.length,
      child: TabBar(
          indicatorColor: Colors.transparent,
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          onTap: (index) {
            onTabSelected(index,categories[index]);
          },
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          tabs: categories.map((category) {
            return TabBarItem(
              reverseColors: reversed,
              icon: category.icon,
              currentIndex: currentTabIndex,
              title: category.title,
              index: categories.indexOf(category),
            );
          },).toList()
      ),
    );
  }
}