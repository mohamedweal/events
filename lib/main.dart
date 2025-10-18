import 'package:events/UI/Common/AppSharedPrefrences.dart';
import 'package:events/UI/Provider/LanguageProvider.dart';
import 'package:events/UI/Provider/ThemeProvider.dart';
import 'package:events/UI/Screens/Home/HomeScreen.dart';
import 'package:events/UI/Screens/Login/Login.dart';
import 'package:events/UI/Screens/OnBoarding/Onboarding.dart';
import 'package:events/UI/design/design.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:events/UI/Provider/AppAuthProvider.dart';
import 'package:events/UI/Screens/Register/RegisterScreen.dart';
import 'package:events/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    AppAuthProvider authProvider = Provider.of<AppAuthProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: provider.getSelectedThemeMode(),
      initialRoute:
      authProvider.isLoggedInBefore()? AppRoutes.HomeScreen.name : AppRoutes.LoginScreen.name,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: languageProvider.getSelectedLocale(),
      routes: {
        AppRoutes.OnBoardingScreen.name: (context) => const OnBoardingScreen(),
        AppRoutes.RegisterScreen.name : (context) => RegisterScreen(),
        AppRoutes.LoginScreen.name : (context) => LoginScreen(),
        AppRoutes.HomeScreen.name : (context) => HomeScreen(),
      },
    );
  }
}
