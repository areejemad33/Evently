import 'package:evently_app/core/prefs_manager/prefs_manager.dart';
import 'package:flutter/material.dart';

class LangProvider extends ChangeNotifier {
    String currentLang = PrefsManager.getLanguage() ?? 'en';

    bool get isEn => currentLang == 'en';

    void updateAppLang(String newLang) {
    if (currentLang == newLang) return;

    currentLang = newLang;
    PrefsManager.saveLanguage(currentLang);
    notifyListeners();
  }
}