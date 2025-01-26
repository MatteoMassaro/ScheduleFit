import 'package:flutter/material.dart';
import 'package:schedule_fit/l10n/app_localizations.dart';
import 'package:schedule_fit/widgets/schedule_fit_sliding_panel.dart';

import '../widgets/schedule_fit_drawer.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawerEnableOpenDragGesture: true,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.calendario),
        ),
        drawer: ScheduleFitDrawer(
          onSave: () {},
        ),
        body: const ScheduleFitSlidingPanel());
  }
}
