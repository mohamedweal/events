// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get onboarding_screen_title => 'خصص تجربتك';

  @override
  String get onboarding_screen_subtitle =>
      'اختر المظهر واللغة التي تفضلها للبدء بتجربة مريحة ومخصصة تناسب أسلوبك.';

  @override
  String get language => 'اللغة';

  @override
  String get theme => 'المظهر';

  @override
  String get lets_start => 'لنبدأ';
}
