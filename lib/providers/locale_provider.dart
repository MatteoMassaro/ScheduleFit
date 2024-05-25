import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';


class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale("it");

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!AppLocalizations.supportedLocales.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }
}