import 'package:flutter/material.dart';

class CalendarProvider with ChangeNotifier {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _changeCalendarFormat = false;

  DateTime get focusedDay => _focusedDay;

  DateTime? get selectedDay => _selectedDay;

  bool get changeCalendarFormat => _changeCalendarFormat;

  void setFocusedDay(DateTime day) {
    _focusedDay = day;
    notifyListeners();
  }

  void setSelectedDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  void goToPreviousYear() {
    setFocusedDay(
        DateTime(_focusedDay.year - 1, _focusedDay.month, _focusedDay.day));
  }

  void goToNextYear() {
    setFocusedDay(
        DateTime(_focusedDay.year + 1, _focusedDay.month, _focusedDay.day));
  }

  void goToPreviousMonth() {
    setFocusedDay(
        DateTime(_focusedDay.year, _focusedDay.month - 1, _focusedDay.day));
  }

  void goToNextMonth() {
    setFocusedDay(
        DateTime(_focusedDay.year, _focusedDay.month + 1, _focusedDay.day));
  }

  void toggleCalendarFormat() {
    _changeCalendarFormat = !_changeCalendarFormat;
    notifyListeners();
  }
}
