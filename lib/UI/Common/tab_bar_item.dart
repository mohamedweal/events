
import 'package:events/extensions/context-extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class TabBarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final int index;
  final int currentIndex;
  bool reverseColors = false;
  TabBarItem({
    super.key,
    required this.icon,
    required this.currentIndex,
    required this.title,
    required this.index,
    this.reverseColors = false,
  });

  @override
  Widget build(BuildContext context) {
    var backgroundColor = reverseColors ? Colors.white   :  context.appColors.primary;
    var contentColor = reverseColors ? context.appColors.primary : Colors.white  ;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: currentIndex == index ?contentColor  : backgroundColor,
        border: Border.all(color: contentColor, width: 1),
        borderRadius: BorderRadius.circular(46),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: currentIndex == index
                ?  backgroundColor: contentColor,
            size: 16,
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              color: currentIndex == index
                  ? backgroundColor
                  : contentColor,
            ),
          ),
        ],
      ),
    );
  }
}