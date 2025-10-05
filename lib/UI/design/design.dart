import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color lightPrimary = Color(0xFF5669FF);
  static const Color backgroundColor = Color(0xFFF2FEFF);
  static const Color darkBackgroundColor = Color(0xFF101127);
  static const Color gray = Color(0xFF7B7B7B);
}

class AppImages {
  // static const String ic_stats = "assets/images/ic_stats.svg";
  static const String appIcon = "assets/images/app_logo.png";
  static const String icAr = "assets/images/ic_ar.png";
  static const String icEn = "assets/images/ic_en.png";
  static const String icLight = "assets/images/ic_light.png";
  static const String icDark = "assets/images/ic_dark.png";

  static const String onBoarding1 = "assets/images/onboarding_1.png";
  static const String onBoarding2 = "assets/images/onboarding2.png";
  static const String onBoarding3 = "assets/images/onboarding3.png";
}

class AppThemes {
  static var lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: AppColors.lightPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.lightPrimary),
    ),
    colorScheme: ColorScheme.light(primary: AppColors.lightPrimary),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.jockeyOne(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.jockeyOne(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleMedium:  GoogleFonts.jockeyOne(
        color: AppColors.lightPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: GoogleFonts.jockeyOne(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),

      bodyMedium: GoogleFonts.jockeyOne(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: GoogleFonts.jockeyOne(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12),
            backgroundColor: AppColors.lightPrimary,
            textStyle: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500
            ),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            )
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightPrimary,
      selectedIconTheme: IconThemeData(color: Colors.white, size: 36),
      unselectedIconTheme: IconThemeData(color: Colors.black, size: 24),
      selectedLabelStyle: TextStyle(color: Colors.white),
      unselectedLabelStyle: TextStyle(color: Colors.black),
    ),
    // ERROR FIXED HERE: Changed BottomAppBarTheme to BottomAppBarThemeData
    bottomAppBarTheme: BottomAppBarThemeData(color: AppColors.lightPrimary),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
            color: AppColors.lightPrimary,
            width:1
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
            color: AppColors.gray,
            width:1
        ),
      ),// Example: Set a default outline border
      labelStyle: GoogleFonts.inter(color: AppColors.gray,
          fontSize:16,
          fontWeight: FontWeight.w500
      ),
      focusColor: AppColors.lightPrimary,
      // Example: Style for the label text
      hintStyle: GoogleFonts.inter(color: AppColors.gray,
          fontSize:16,
          fontWeight: FontWeight.w500
      ),  // Example: Style for the hint text
      contentPadding: EdgeInsets.all(16.0),
      // Example: Default content padding
      // Add other InputDecoration properties as needed
    ),
  );
  static var darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor:  AppColors.darkBackgroundColor,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: AppColors.lightPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.lightPrimary),
    ),
    colorScheme: ColorScheme.light(primary: AppColors.lightPrimary),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.jockeyOne(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.jockeyOne(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleMedium:  GoogleFonts.jockeyOne(
        color: AppColors.lightPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: GoogleFonts.jockeyOne(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),

      bodyMedium: GoogleFonts.jockeyOne(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: GoogleFonts.jockeyOne(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(

            padding: EdgeInsets.symmetric(vertical: 12),
            backgroundColor: AppColors.lightPrimary,
            textStyle: GoogleFonts.jockeyOne(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            )
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightPrimary,
      selectedIconTheme: IconThemeData(color: Colors.white, size: 36),
      unselectedIconTheme: IconThemeData(color: Colors.black, size: 24),
      selectedLabelStyle: TextStyle(color: Colors.white),
      unselectedLabelStyle: TextStyle(color: Colors.black),
    ),
    // ERROR FIXED HERE: Changed BottomAppBarTheme to BottomAppBarThemeData
    bottomAppBarTheme: BottomAppBarThemeData(color: AppColors.lightPrimary),
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
  );
}
