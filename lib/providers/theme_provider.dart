import 'package:flutter/material.dart';

import '../enums/schedule_fit_colors.dart';

class ThemeProvider with ChangeNotifier {
  static bool _isLightMode =
      WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.light;

  bool get isLightMode => _isLightMode;

  ThemeMode get themeMode => _isLightMode ? ThemeMode.light : ThemeMode.dark;

  void toggleTheme() {
    _isLightMode = !_isLightMode;
    notifyListeners();
  }

  static final Map<AppColors, Color> lightColors = {
    AppColors.primaryColor: const Color(0xFF556EAA),
    AppColors.secondaryColor: const Color(0xFFFBC24C),
    AppColors.pageBackgroundColor: const Color(0xFFECECEC),
    AppColors.slidingPanelColor: const Color(0xFF556EAA),
    AppColors.calendarSelectedDayColor: const Color(0xFFF8AB10),
    AppColors.calendarDaysOfWeekColor: const Color(0xFFFFFFFF),
    AppColors.calendarDaysOfWeekendColor: const Color(0xFFE2E2E2),
    AppColors.noExercisesColor: const Color(0xFFFFFFFF),
    AppColors.accordionTextHeaderColor: const Color(0xFFFFFFFF),
    AppColors.accordionBackgroundColor: const Color(0xFF4D6498),
    AppColors.exerciseCardColor: const Color(0xFFFFFFFF),
    AppColors.exerciseCardTextColor: const Color(0xFF556EAA),
    AppColors.dropdownButtonTextColor: const Color(0xFF556EAA),
    AppColors.dropdownDaysOfWeekColor: const Color(0xFF556EAA),
    AppColors.cancelColor: const Color(0xFFB00808),
    AppColors.checkColor: const Color(0xFF3A8A3D),
    AppColors.crossColor: const Color(0xFF850909),
  };

  static final Map<AppColors, Color> darkColors = {
    AppColors.primaryColor: const Color(0xFF556EAA),
    AppColors.secondaryColor: const Color(0xFFFBC24C),
    AppColors.pageBackgroundColor: const Color(0xFF25314C),
    AppColors.slidingPanelColor: const Color(0xFFFFFFFF),
    AppColors.calendarSelectedDayColor: const Color(0xFFF8AB10),
    AppColors.calendarDaysOfWeekColor: const Color(0xFF25314C),
    AppColors.calendarDaysOfWeekendColor: const Color(0xFF2F3E62),
    AppColors.noExercisesColor: const Color(0xFFFFFFFF),
    AppColors.accordionTextHeaderColor: const Color(0xFFFFFFFF),
    AppColors.accordionBackgroundColor: const Color(0xFF4D6498),
    AppColors.exerciseCardColor: const Color(0xFFFFFFFF),
    AppColors.exerciseCardTextColor: const Color(0xFF556EAA),
    AppColors.dropdownButtonTextColor: const Color(0xFFFFFFFF),
    AppColors.dropdownDaysOfWeekColor: const Color(0xFF556EAA),
    AppColors.cancelColor: const Color(0xFFB00808),
    AppColors.checkColor: const Color(0xFF3A8A3D),
    AppColors.crossColor: const Color(0xFF850909),
  };

  static Color? getColor(AppColors color) {
    return _isLightMode ? lightColors[color] : darkColors[color];
  }
}
