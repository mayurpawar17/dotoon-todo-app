import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingServices {
  static const _username = 'username';
  static const String _keyOnboarded = "isOnboarded";

  Future<String?> loadName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_username);
  }

  Future<void> saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_username, name);
  }

  // Save that onboarding is completed
  static Future<void> setOnboarded() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboarded, true);
  }

  // Check if onboarding was done
  static Future<bool> isOnboarded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboarded) ?? false;
  }
}
