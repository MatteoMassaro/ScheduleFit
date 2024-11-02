import 'package:flutter/foundation.dart';

class ExerciseInfoProvider extends ChangeNotifier {
  int _serieCompletate = 0;

  ExerciseInfoProvider(this._serieCompletate);

  int get serieCompletate => _serieCompletate;

  void increaseCompletedSeries() {
    _serieCompletate++;
    notifyListeners();
  }

  void decreaseCompletedSeries() {
    _serieCompletate--;
    notifyListeners();
  }
}
