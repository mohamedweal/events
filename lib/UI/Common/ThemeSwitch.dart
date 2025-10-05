import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:events/UI/Provider/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatefulWidget {
  ThemeSwitcher() {}

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    return AnimatedToggleSwitch<ThemeMode>.rolling(
      current: provider.getSelectedThemeMode(),
      values: provider.getModes(),
      onChanged: (newThemeMode) {
        setState(() {
          provider.changeTheme(newThemeMode);
        });
      },
      iconBuilder: (value, foreground) {
        if (value == ThemeMode.light) {
          return Icon(EvaIcons.sun, size: 24);
        } else {
          return Icon(EvaIcons.moon, size: 24);
        }
      },
      style: ToggleStyle(
        indicatorColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        borderColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}