import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {

  static Future<bool> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("seenOnboarding") ?? false;
  }

  static Future<void> setSeenOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("seenOnboarding", true);
  }
}