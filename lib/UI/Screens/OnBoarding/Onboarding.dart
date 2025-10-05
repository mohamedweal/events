import 'package:events/UI/Common/language-switcher.dart';
import 'package:events/UI/Common/AppNameText.dart';
import 'package:events/UI/Common/ThemeSwitch.dart';
import 'package:events/UI/design/design.dart';
import 'package:flutter/material.dart';
import 'package:events/l10n/app_localizations.dart';
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.appIcon,

            ),
            SizedBox(width: 12,),
            AppNameText(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(AppImages.onBoarding1),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(AppLocalizations.of(context)!.onboarding_screen_title,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
                Text(AppLocalizations.of(context)!.onboarding_screen_subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.language,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.start,
                    ),
                    LanguageSwitcher(),
                  ],
                ),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.theme,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.start,
                    ),
                    ThemeSwitcher(),
                  ],
                ),
                SizedBox(height: 24),
                ElevatedButton(onPressed: (){}, child: Text(AppLocalizations.of(context)!.lets_start,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                  ),))

              ],
            )
            )
          ],
        ),
      ),
    );
  }
}