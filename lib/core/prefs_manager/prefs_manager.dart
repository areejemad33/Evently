import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static late SharedPreferences prefs;
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static bool checkFirstTime() {
    return prefs.getBool("seenOnboarding") ?? false;
  }

  static void setSeenOnboarding() {
    prefs.setBool("seenOnboarding", true);
  }

  static void saveTheme(ThemeMode theme) {
    String cachedTheme = theme == ThemeMode.light ? "light" : "dark";
    prefs.setString("themeKey", cachedTheme);
  }

  static ThemeMode? getSavedTheme() {
    String? cachedTheme = prefs.getString("themeKey");
    if (cachedTheme == null) {
      return null;
    } else {
      if (cachedTheme == "light") {
        return ThemeMode.light;
      } else {
        return ThemeMode.dark;
      }
    }
  }

  static void saveLanguage(String lang) {
    prefs.setString("langKey", lang);
  }

   static String ? getLanguage() {
    return prefs.getString("langKey");
  }
}
