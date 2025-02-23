import 'dart:async';

import 'package:flutter/widgets.dart';

class CountdownManager {
  final AnimationController countdownController;
  final AnimationController opacityController;
  int countdownTime;
  bool isTrainingStarted = false;
  final Function(int) onCountdownUpdate;
  final VoidCallback onTrainingStart;
  final VoidCallback onCountdownFinished;

  CountdownManager({
    required this.countdownController,
    required this.opacityController,
    required this.onCountdownUpdate,
    required this.onTrainingStart,
    required this.onCountdownFinished,
    this.countdownTime = 3,
  });

  void startCountdown() {
    countdownTime = 3;
    countdownController.reset();
    countdownController.forward();
    onTrainingStart();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownTime > 0) {
        countdownTime--;
        onCountdownUpdate(countdownTime);
        countdownController.forward(from: 0);
      } else {
        onCountdownFinished();
        timer.cancel();
        opacityController.forward();
      }
    });
  }
}
