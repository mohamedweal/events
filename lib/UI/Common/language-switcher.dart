import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:events/UI/design/design.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:events/UI/Provider/LanguageProvider.dart';

class LanguageSwitcher extends StatefulWidget {

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    return AnimatedToggleSwitch<Locale>.
    rolling(current: languageProvider.getSelectedLocale(),
      values: languageProvider.getSupportedLocales(),
      onChanged: (item) {
        setState(() {
          languageProvider.changeLocale(item);
        });
      },
      iconBuilder: (value, foreground) {
        if(value == Locale('en')){
          return Flag(Flags.united_states_of_america,
            size: 24,);
        }else{
          return Flag(Flags.egypt,size: 24,);
        }
      },
      style: ToggleStyle(
        indicatorColor: Theme.of(context).colorScheme.primary ,
        backgroundColor: Colors.transparent ,
        borderColor:Theme.of(context).colorScheme.primary ,
      ),
    );
  }
}
