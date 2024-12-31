import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_fit/l10n/app_localizations.dart';
import 'package:schedule_fit/providers/calendar_provider.dart';
import 'package:schedule_fit/widgets/schedule_fit_calendar.dart';

import '../enums/schedule_fit_colors.dart';
import '../widgets/schedule_fit_drawer.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.calendario ?? ''),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: ScheduleFitDrawer(
        onSave: () {},
      ),
      body: Consumer<CalendarProvider>(
          builder: (context, calendarProvider, child) {
        return Column(
          children: [
            ///Calendar
            Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: getAppColors(AppColors.primaryColor),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: const ScheduleFitCalendar())
          ],
        );
      }),
    );
  }
}
