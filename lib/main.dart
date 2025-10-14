import 'package:events/UI/Common/AppSharedPrefrences.dart';
import 'package:events/UI/Provider/AppAuthProvider.dart';
import 'package:events/UI/Provider/LanguageProvider.dart';
import 'package:events/UI/Provider/ThemeProvider.dart';
import 'package:events/UI/Screens/Home/HomeScreen.dart';
import 'package:events/UI/Screens/Login/Login.dart';
import 'package:events/UI/Screens/OnBoarding/Onboarding.dart';
import 'package:events/UI/Screens/Register/RegisterScreen.dart';
import 'package:events/UI/design/design.dart';
import 'package:events/firebase_options.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:events/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Prevent duplicate Firebase initialization
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  await AppSharedPreferences.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AppAuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      title: 'Events App',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeProvider.getSelectedThemeMode(),
      initialRoute: AppRoutes.RegisterScreen.name,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: languageProvider.getSelectedLocale(),
      routes: {
        AppRoutes.OnBoardingScreen.name: (context) => const OnBoardingScreen(),
        AppRoutes.RegisterScreen.name: (context) => RegisterScreen(),
        AppRoutes.LoginScreen.name: (context) => LoginScreen(),
        AppRoutes.HomeScreen.name: (context) => HomeScreen(),
      },
    );
  }
}
