import 'package:firebase_connection_project/core/theme/dark_mode.dart';
import 'package:firebase_connection_project/core/theme/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool ispressed = true;
  ThemeData _themeData = darkTheme;
  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
  }

  void toggleApperance() {
    if (_themeData == darkTheme) {
      _themeData = lightTheme;
      ispressed = false;
    } else {
      _themeData = darkTheme;
      ispressed = true;
    }
    notifyListeners();
  }
}
