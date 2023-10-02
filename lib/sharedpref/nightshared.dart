import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DarkThemePreference extends ChangeNotifier {
  DarkThemePreference() {
    updateThemeBasedOnTime();
    startTimerToUpdateTheme();
  }
  bool light = false;
  Timer? timer;
  void startTimerToUpdateTheme() {
    const duration = Duration(seconds: 1);
    timer = Timer.periodic(duration, (Timer timer) {
      updateThemeBasedOnTime();
      notifyListeners();
    });
  }

  void updateThemeBasedOnTime() {
    String mydate = DateFormat('hh:mm a').format(DateTime.now());
    String amPM = DateFormat('a').format(DateTime.now());
    DateTime parsedTime = DateFormat('hh:mm').parse(mydate);

    int hours = parsedTime.hour;
    int minutes = parsedTime.minute;

    if ((light == false || hours >= 6 && minutes >= 35 && amPM == 'PM')) {
      theme(false);
    }
    if ((light == true  || hours >= 6 && minutes >= 30 && amPM == 'AM')) {
      theme(true);
    }

    notifyListeners();
  }

  void theme(bool value) {
    light = value;
    notifyListeners();
  }
}
