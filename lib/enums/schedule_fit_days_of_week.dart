import 'package:flutter/cupertino.dart';
import 'package:schedule_fit/l10n/app_localizations.dart';

enum DaysOfWeek {
  lunedi,
  martedi,
  mercoledi,
  giovedi,
  venerdi,
  sabato,
  domenica
}

Map<DaysOfWeek, int> dayOfWeekName = {
  DaysOfWeek.lunedi: 1,
  DaysOfWeek.martedi: 2,
  DaysOfWeek.mercoledi: 3,
  DaysOfWeek.giovedi: 4,
  DaysOfWeek.venerdi: 5,
  DaysOfWeek.sabato: 6,
  DaysOfWeek.domenica: 7,
};

List<int> getDaysOfWeek() {
  return DaysOfWeek.values.map((day) => dayOfWeekName[day] ?? -1).toList();
}

List<String> getDaysOfWeekTranslated(BuildContext context) {
  return DaysOfWeek.values.map((day) {
    switch (day) {
      case DaysOfWeek.lunedi:
        return '${AppLocalizations.of(context)!.ogni} ${AppLocalizations.of(context)!.lunedi}';
      case DaysOfWeek.martedi:
        return '${AppLocalizations.of(context)!.ogni} ${AppLocalizations.of(context)!.martedi}';
      case DaysOfWeek.mercoledi:
        return '${AppLocalizations.of(context)!.ogni} ${AppLocalizations.of(context)!.mercoledi}';
      case DaysOfWeek.giovedi:
        return '${AppLocalizations.of(context)!.ogni} ${AppLocalizations.of(context)!.giovedi}';
      case DaysOfWeek.venerdi:
        return '${AppLocalizations.of(context)!.ogni} ${AppLocalizations.of(context)!.venerdi}';
      case DaysOfWeek.sabato:
        return '${AppLocalizations.of(context)!.ogni} ${AppLocalizations.of(context)!.sabato}';
      case DaysOfWeek.domenica:
        return '${AppLocalizations.of(context)!.ogni} ${AppLocalizations.of(context)!.domenica}';
      default:
        return '';
    }
  }).toList();
}

String getDayOfWeekTranslated(BuildContext context, int day) {
  switch (day) {
    case 1:
      return '${AppLocalizations.of(context)!.ogni} ${AppLocalizations.of(context)!.lunedi}';
    case 2:
      return '${AppLocalizations.of(context)!.ogni} ${AppLocalizations.of(context)!.martedi}';
    case 3:
      return '${AppLocalizations.of(context)!.ogni} ${AppLocalizations.of(context)!.mercoledi}';
    case 4:
      return '${AppLocalizations.of(context)!.ogni} ${AppLocalizations.of(context)!.giovedi}';
    case 5:
      return '${AppLocalizations.of(context)!.ogni} ${AppLocalizations.of(context)!.venerdi}';
    case 6:
      return '${AppLocalizations.of(context)!.ogni} ${AppLocalizations.of(context)!.sabato}';
    case 7:
      return '${AppLocalizations.of(context)!.ogni} ${AppLocalizations.of(context)!.domenica}';
    default:
      return '';
  }
}

int getDayOfWeekTranslatedFromString(BuildContext context, String day) {
  for (var dayOfWeek in DaysOfWeek.values) {
    if (day.toLowerCase().contains(
        AppLocalizations.of(context)!.translateEnum(dayOfWeek).toLowerCase())) {
      return dayOfWeekName[dayOfWeek] ?? -1;
    }
  }
  return -1;
}

extension DaysOfWeekTranslation on AppLocalizations {
  String translateEnum(DaysOfWeek day) {
    switch (day) {
      case DaysOfWeek.lunedi:
        return lunedi;
      case DaysOfWeek.martedi:
        return martedi;
      case DaysOfWeek.mercoledi:
        return mercoledi;
      case DaysOfWeek.giovedi:
        return giovedi;
      case DaysOfWeek.venerdi:
        return venerdi;
      case DaysOfWeek.sabato:
        return sabato;
      case DaysOfWeek.domenica:
        return domenica;
    }
  }
}
