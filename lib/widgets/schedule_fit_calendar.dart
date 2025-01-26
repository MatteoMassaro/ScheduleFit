import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/l10n/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';

import '../enums/schedule_fit_colors.dart';
import '../providers/exercise_info_provider.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';

class ScheduleFitCalendar extends StatefulWidget {
  final void Function(DateTime selectedDay)? onDaySelected;

  const ScheduleFitCalendar({super.key, this.onDaySelected});

  @override
  State<ScheduleFitCalendar> createState() => _ScheduleFitCalendarState();
}

class _ScheduleFitCalendarState extends State<ScheduleFitCalendar> {
  bool _changeCalendarFormat = false;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
  }

  void _goToPreviousMonth() {
    setState(() {
      _focusedDay =
          DateTime(_focusedDay.year, _focusedDay.month - 1, _focusedDay.day);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _focusedDay =
          DateTime(_focusedDay.year, _focusedDay.month + 1, _focusedDay.day);
    });
  }

  void _goToPreviousYear() {
    setState(() {
      _focusedDay =
          DateTime(_focusedDay.year - 1, _focusedDay.month, _focusedDay.day);
    });
  }

  void _goToNextYear() {
    setState(() {
      _focusedDay =
          DateTime(_focusedDay.year + 1, _focusedDay.month, _focusedDay.day);
    });
  }

  void _toggleCalendarFormat() {
    setState(() {
      _changeCalendarFormat = !_changeCalendarFormat;
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(1900),
      lastDay: DateTime.utc(2999),
      locale: locale.languageCode,
      headerStyle: const HeaderStyle(
        leftChevronVisible: false,
        rightChevronVisible: false,
        formatButtonVisible: false,
        formatButtonShowsNext: false,
      ),
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: ThemeProvider.getColor(AppColors.calendarSelectedDayColor),
          shape: BoxShape.circle,
        ),
        outsideDaysVisible: false,
        defaultTextStyle: TextStyle(
            color: ThemeProvider.getColor(AppColors.calendarDaysOfWeekColor)),
        weekendTextStyle: TextStyle(
            color: ThemeProvider.getColor(AppColors.calendarDaysOfWeekendColor)),
        markerMargin: const EdgeInsets.only(top: 5),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
            color: ThemeProvider.getColor(AppColors.calendarDaysOfWeekColor),
            fontWeight: FontWeight.bold),
        weekendStyle: TextStyle(
            color: ThemeProvider.getColor(AppColors.calendarDaysOfWeekendColor),
            fontWeight: FontWeight.bold),
      ),
      calendarFormat: CalendarFormat.month,
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        if (widget.onDaySelected != null) {
          widget.onDaySelected!(selectedDay);
        }
      },
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, date) {
          final monthName = DateFormat.MMMM(locale.languageCode).format(date);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                color: ThemeProvider.getColor(AppColors.calendarDaysOfWeekColor),
                onPressed: _changeCalendarFormat
                    ? _goToPreviousYear
                    : _goToPreviousMonth,
              ),
              Text(
                '${monthName[0].toUpperCase()}${monthName.substring(1)} ${date.year}',
                style: TextStyle(
                    color: ThemeProvider.getColor(
                        AppColors.calendarDaysOfWeekColor),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: _toggleCalendarFormat,
                style: TextButton.styleFrom(
                    backgroundColor:
                        ThemeProvider.getColor(AppColors.secondaryColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(
                            color: ThemeProvider.getColor(
                                    AppColors.calendarDaysOfWeekColor) ??
                                Colors.white,
                            width: 2))),
                child: Text(
                  _changeCalendarFormat
                      ? AppLocalizations.of(context)!.anno
                      : AppLocalizations.of(context)!.mese,
                  style: TextStyle(
                      color: ThemeProvider.getColor(
                          AppColors.calendarDaysOfWeekColor)),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.chevron_right,
                  color:
                      ThemeProvider.getColor(AppColors.calendarDaysOfWeekColor),
                ),
                onPressed:
                    _changeCalendarFormat ? _goToNextYear : _goToNextMonth,
              ),
            ],
          );
        },
        todayBuilder: (context, day, focusedDay) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isSameDay(_selectedDay, DateTime.now())
                  ? ThemeProvider.getColor(AppColors.calendarSelectedDayColor)
                  : ThemeProvider.getColor(AppColors.secondaryColor),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${day.day}',
              style: TextStyle(
                color: ThemeProvider.getColor(AppColors.calendarDaysOfWeekColor),
              ),
            ),
          );
        },
        markerBuilder: (context, day, events) {
          final periodicExercises = context
              .read<ExerciseInfoProvider>()
              .getPeriodicExercises(day.weekday);
          final exercisesForDay =
              context.read<ExerciseInfoProvider>().getExercisesForDate(day);
          final periodicMarkers = periodicExercises.take(3).toList();
          final markersForDay = periodicMarkers.length < 3
              ? exercisesForDay.take(3 - periodicMarkers.length).toList()
              : [];

          return Positioned(
            top: 45,
            child: Row(
              children: [
                ...periodicMarkers.map((event) {
                  return Container(
                    width: 5,
                    height: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: ThemeProvider.getColor(AppColors.secondaryColor),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
                ...markersForDay.map((event) {
                  return Container(
                    width: 5,
                    height: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: ThemeProvider.getColor(AppColors.secondaryColor),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
                if (periodicExercises.length + exercisesForDay.length > 3)
                  Container(
                    margin: const EdgeInsets.only(top: 1, left: 2),
                    child: Text(
                      "+${(periodicExercises.length + exercisesForDay.length) - 3}",
                      style: TextStyle(
                        color: ThemeProvider.getColor(
                            AppColors.calendarDaysOfWeekColor),
                        fontSize: 7,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
        defaultBuilder: (context, day, focusedDay) {
          if (_selectedDay != null && isSameDay(day, _selectedDay)) {
            return Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color:
                    ThemeProvider.getColor(AppColors.calendarSelectedDayColor),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '${day.day}',
                style: TextStyle(
                    color: ThemeProvider.getColor(
                        AppColors.calendarDaysOfWeekColor)),
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
