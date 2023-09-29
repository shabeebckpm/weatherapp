import 'package:flutter/material.dart';

class DarkThemePreference extends ChangeNotifier {

  bool light = false;
  void mytheme(bool color) {
    light = color;
    notifyListeners();
  }
}
