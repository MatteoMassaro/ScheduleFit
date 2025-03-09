import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchProvider extends ChangeNotifier {
  Timer? _timer;
  int _milliseconds = 0;
  bool _isRunning = false;

  int get milliseconds => _milliseconds;

  int get seconds => _milliseconds ~/ 1000;

  bool get isRunning => _isRunning;

  ///Start
  void start() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        _milliseconds += 10;
        notifyListeners();
      });
    }
  }

  ///Stop
  void stop() {
    if (_isRunning) {
      _isRunning = false;
      _timer?.cancel();
      notifyListeners();
    }
  }

  ///Reset
  void reset() {
    _timer?.cancel() ;
    _milliseconds = 0;
    _isRunning = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
