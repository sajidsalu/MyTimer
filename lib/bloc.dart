import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class StopWatchBloc{

  static const _countDownDuration = Duration(minutes: 10);
  Duration _duration = const Duration();
  Timer? _timer;
  bool _countDown = true;
  StopWatchBloc(){}

  final minute = BehaviorSubject<int>.seeded(10);
  Stream<int> get _minute => minute.stream;
  get timerMinute => minute.value;

  final _isRunningAndActive = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get isRunningAndCompleted => _isRunningAndActive.stream;

  get countDownDuration => _countDownDuration;
  get duration => _duration;
  get timer => _timer;
  get countDown => _countDown;

  void setDuration(countDownDuration) {
    _duration = countDownDuration;
  }

  void setTimer(Timer timer) {
    _timer = timer;
  }

}
