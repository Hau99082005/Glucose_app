import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String _emailKey = 'user_email';
  
  static Future<void> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
  }
  
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }
} 