import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchProvider extends ChangeNotifier {
  Timer? _timer;
  int _milliseconds = 0;
  bool _isRunning = false;

  int get milliseconds => _milliseconds;

  bool get isRunning => _isRunning;

  void start() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        _milliseconds += 10;
        notifyListeners();
      });
    }
  }

  void stop() {
    if (_isRunning) {
      _isRunning = false;
      _timer?.cancel();
      notifyListeners();
    }
  }

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
