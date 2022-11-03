import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _localTheme;
  ThemeNotifier(this._localTheme);

  ThemeData getLocalTheme() => _localTheme;

  void setLocalTheme(ThemeData localTheme) {
    this._localTheme = localTheme;
    notifyListeners();
  }
}
