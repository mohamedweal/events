import 'package:events/UI/Screens/OnBoarding/Onboarding.dart';
import 'package:events/UI/design/design.dart';
import 'package:events/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.OnBoarding.name,
      routes: {
        AppRoutes.OnBoarding.name: (context) => OnBoarding(),
      }
      ,

    );
  }
}

