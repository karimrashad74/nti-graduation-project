import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await _prefs!.setString(key, value);
    if (value is int) return await _prefs!.setInt(key, value);
    if (value is bool) return await _prefs!.setBool(key, value);
    if (value is double) return await _prefs!.setDouble(key, value);
    if (value is List<String>) return await _prefs!.setStringList(key, value);
    throw Exception('Unsupported value type');
  }

  static dynamic getData({required String key}) {
    return _prefs!.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await _prefs!.remove(key);
  }

  static Future<bool> containsKey(String key) async {
    return _prefs!.containsKey(key);
  }

  static Future<bool> clearCache() async {
    return await _prefs!.clear();
  }
}
