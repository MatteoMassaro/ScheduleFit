import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/schedule_fit_colors.dart';
import '../providers/stopwatch_provider.dart';
import '../providers/theme_provider.dart';

class ScheduleFitStopwatch extends StatelessWidget {
  const ScheduleFitStopwatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StopwatchProvider>(
      builder: (context, stopwatch, child) {
        final hours =
        (stopwatch.milliseconds ~/ 3600000).toString().padLeft(2, '0');
        final minutes =
            (stopwatch.milliseconds ~/ 60000).toString().padLeft(2, '0');
        final seconds =
            ((stopwatch.milliseconds ~/ 1000) % 60).toString().padLeft(2, '0');
        final milliseconds =
            ((stopwatch.milliseconds % 1000) ~/ 10).toString().padLeft(2, '0');

        final timeString = hours != '00'
            ? '$hours:$minutes:$seconds.$milliseconds'
            : '$minutes:$seconds.$milliseconds';

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              timeString,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: ThemeProvider.getColor(AppColors.stopwatchColor)),
            ),
          ],
        );
      },
    );
  }
}
