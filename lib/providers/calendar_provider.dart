import 'package:flutter/material.dart';

class CalendarProvider with ChangeNotifier {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _changeCalendarFormat = false;

  DateTime get focusedDay => _focusedDay;

  DateTime? get selectedDay => _selectedDay;

  bool get changeCalendarFormat => _changeCalendarFormat;

  ///Set Focused Day
  void setFocusedDay(DateTime day) {
    _focusedDay = day;
    notifyListeners();
  }

  ///Set Selected Day
  void setSelectedDay(DateTime? day) {
    _selectedDay = day;
    notifyListeners();
  }

  ///Go To Previous Year
  void goToPreviousYear() {
    setFocusedDay(
        DateTime(_focusedDay.year - 1, _focusedDay.month, _focusedDay.day));
  }

  ///Go To Next Year
  void goToNextYear() {
    setFocusedDay(
        DateTime(_focusedDay.year + 1, _focusedDay.month, _focusedDay.day));
  }

  ///Go To Previous Month
  void goToPreviousMonth() {
    setFocusedDay(
        DateTime(_focusedDay.year, _focusedDay.month - 1, _focusedDay.day));
  }

  ///Go To Next Month
  void goToNextMonth() {
    setFocusedDay(
        DateTime(_focusedDay.year, _focusedDay.month + 1, _focusedDay.day));
  }

  ///Toggle Calendar Format
  void toggleCalendarFormat() {
    _changeCalendarFormat = !_changeCalendarFormat;
    notifyListeners();
  }
}
