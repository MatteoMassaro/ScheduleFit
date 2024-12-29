import 'package:flutter/material.dart';
import 'package:schedule_fit/enums/schedule_fit_app_info.dart';

import '../l10n/app_localizations.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale(getAppInfo(AppInfo.defaultLanguage));

  Locale get locale => _locale;

  ///Set Locale
  void setLocale(Locale locale) {
    if (!AppLocalizations.supportedLocales.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }
}
