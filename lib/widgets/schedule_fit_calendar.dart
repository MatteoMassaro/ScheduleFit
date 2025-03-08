import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/l10n/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';

import '../database/schedule_fit_database.dart';
import '../enums/schedule_fit_colors.dart';
import '../providers/calendar_provider.dart';
import '../providers/exercise_info_provider.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';

class ScheduleFitCalendar extends StatelessWidget {
  final void Function(DateTime selectedDay)? onDaySelected;

  const ScheduleFitCalendar({super.key, this.onDaySelected});

  @override
  Widget build(BuildContext context) {
    Locale locale = Provider.of<LocaleProvider>(context, listen: false).locale;

    return Consumer<CalendarProvider>(
      builder: (context, calendarProvider, child) {
        return TableCalendar(
          focusedDay: calendarProvider.focusedDay,
          selectedDayPredicate: (day) =>
              isSameDay(day, calendarProvider.selectedDay),
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
            outsideDaysVisible: false,
            defaultTextStyle: TextStyle(
                color:
                    ThemeProvider.getColor(AppColors.calendarDaysOfWeekColor)),
            weekendTextStyle: TextStyle(
                color: ThemeProvider.getColor(
                    AppColors.calendarDaysOfWeekendColor)),
            markerMargin: const EdgeInsets.only(top: 5),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
                color:
                    ThemeProvider.getColor(AppColors.calendarDaysOfWeekColor),
                fontWeight: FontWeight.bold),
            weekendStyle: TextStyle(
                color: ThemeProvider.getColor(
                    AppColors.calendarDaysOfWeekendColor),
                fontWeight: FontWeight.bold),
          ),
          calendarFormat: CalendarFormat.month,
          onPageChanged: (focusedDay) {
            DateTime selectedDay = DateTime(focusedDay.year, focusedDay.month,
                calendarProvider.selectedDay?.day ?? DateTime.now().day);
            if (selectedDay.month != focusedDay.month) {
              selectedDay = DateTime(focusedDay.year, focusedDay.month, 1);
            }
            calendarProvider.setSelectedDay(selectedDay);
            onDaySelected!(selectedDay);
          },
          onDaySelected: (selectedDay, focusedDay) {
            calendarProvider.setSelectedDay(selectedDay);
            if (onDaySelected != null) {
              onDaySelected!(selectedDay);
            }
          },
          calendarBuilders: CalendarBuilders(
            headerTitleBuilder: (context, date) {
              final monthName =
                  DateFormat.MMMM(locale.languageCode).format(date);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    color: ThemeProvider.getColor(
                        AppColors.calendarDaysOfWeekColor),
                    onPressed: calendarProvider.changeCalendarFormat
                        ? calendarProvider.goToPreviousYear
                        : calendarProvider.goToPreviousMonth,
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
                    onPressed: calendarProvider.toggleCalendarFormat,
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
                      calendarProvider.changeCalendarFormat
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
                      color: ThemeProvider.getColor(
                          AppColors.calendarDaysOfWeekColor),
                    ),
                    onPressed: calendarProvider.changeCalendarFormat
                        ? calendarProvider.goToNextYear
                        : calendarProvider.goToNextMonth,
                  ),
                ],
              );
            },
            todayBuilder: (context, day, focusedDay) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: isSameDay(calendarProvider.selectedDay, DateTime.now())
                      ? ThemeProvider.getColor(
                          AppColors.calendarSelectedDayColor)
                      : ThemeProvider.getColor(AppColors.secondaryColor),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    color: ThemeProvider.getColor(
                        AppColors.calendarDaysOfWeekColor),
                  ),
                ),
              );
            },
            markerBuilder: (context, day, events) {
              final periodicExercises = context
                  .read<ExerciseInfoProvider>()
                  .getPeriodicExercises(day.weekday);
              final exercisesByDate =
                  context.read<ExerciseInfoProvider>().getTodayExercises(day);
              List<ExerciseInfoData> totalExercises = [
                ...{...periodicExercises, ...exercisesByDate}
              ];
              final markers = totalExercises.take(3);

              return Positioned(
                top: 45,
                child: Row(
                  children: [
                    ...markers.map((event) {
                      return Container(
                        width: 5,
                        height: 5,
                        margin: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 1),
                        decoration: BoxDecoration(
                          color:
                              ThemeProvider.getColor(AppColors.secondaryColor),
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                    if (totalExercises.length > 3)
                      Container(
                        margin: const EdgeInsets.only(top: 1, left: 2),
                        child: Text(
                          "+${(totalExercises.length) - 3}",
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
            selectedBuilder: (context, day, focusedDay) {
              if (calendarProvider.selectedDay != null &&
                  isSameDay(day, calendarProvider.selectedDay)) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: ThemeProvider.getColor(
                        AppColors.calendarSelectedDayColor),
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
      },
    );
  }
}
