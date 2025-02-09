import 'package:flutter/material.dart';

import '../enums/schedule_fit_colors.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';

class ScheduleFitCountdownAnimation extends StatelessWidget {
  final int countdown;
  final AnimationController countdownController;
  final Animation<double> scaleAnimation;
  final Animation<double> opacityAnimation;
  final bool showCountdown;
  final Function onCountdownFinished;

  const ScheduleFitCountdownAnimation({
    super.key,
    required this.countdown,
    required this.countdownController,
    required this.scaleAnimation,
    required this.opacityAnimation,
    required this.showCountdown,
    required this.onCountdownFinished,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: countdownController,
      builder: (context, child) {
        return Visibility(
          visible: showCountdown,
          child: Center(
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Opacity(
                opacity: opacityAnimation.value,
                child: Text(
                  countdown > 0 ? "$countdown" : AppLocalizations.of(context)!.inizioAllenamento,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: ThemeProvider.getColor(AppColors.countdownColor),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
