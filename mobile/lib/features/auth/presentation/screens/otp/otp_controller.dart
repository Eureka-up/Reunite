import 'dart:async';

import 'package:flutter/material.dart';

class OtpController extends ChangeNotifier {
  static const totalSeconds = 60;

  OtpController() {
    startTimer();
  }

  Timer? _timer;
  int seconds = totalSeconds;
  final boxes = List.generate(6, (_) => TextEditingController());
  final focusNodes = List.generate(6, (_) => FocusNode());

  String get code => boxes.map((b) => b.text).join();

  void startTimer() {
    _timer?.cancel();
    seconds = totalSeconds;
    notifyListeners();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds > 0) {
        seconds--;
        notifyListeners();
      } else {
        t.cancel();
      }
    });
  }

  void onBoxChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in boxes) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }
}
