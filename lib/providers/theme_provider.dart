import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  bool get isDark => currentTheme == ThemeMode.dark;
  void updateAppTheme(ThemeMode newTheme) {
    currentTheme = newTheme;
    notifyListeners();
  }


}
