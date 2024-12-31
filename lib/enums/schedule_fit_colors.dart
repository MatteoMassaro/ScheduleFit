import 'dart:ui';

enum AppColors {
  primaryColor,
  secondaryColor,
  selectedDayCalendarColor,
}

Map<AppColors, Color> colors = {
  AppColors.primaryColor: const Color(0xFF556EAA),
  AppColors.secondaryColor: const Color(0xFFFBC24C),
  AppColors.selectedDayCalendarColor: const Color(0xFFF8AB10)
};

Color? getAppColors(AppColors color) {
  return colors[color];
}
