import 'package:inbridge/test/Enums/time.dart';

class TimeNumber {
  Time _duration;
  int _number;

  // Named constructor with required parameters
  TimeNumber({required Time duration, required int number})
      : _duration = duration,
        _number = number;

  Time get duration => _duration;
  int get number => _number;
}
