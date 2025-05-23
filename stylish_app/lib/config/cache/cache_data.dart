import 'cache_helper.dart';
import 'cache_keys.dart';

class CacheData {
  static Future<void> setUserToken(String token) async {
    await CacheHelper.saveData(key: CacheKeys.userToken, value: token);
  }

  static String? getUserToken() {
    return CacheHelper.getData(key: CacheKeys.userToken);
  }

  static Future<void> clearUserToken() async {
    await CacheHelper.removeData(key: CacheKeys.userToken);
  }

  static Future<void> setLanguage(String language) async {
    await CacheHelper.saveData(key: CacheKeys.language, value: language);
  }

  static String? getLanguage() {
    return CacheHelper.getData(key: CacheKeys.language);
  }

  static Future<void> clearLanguage() async {
    await CacheHelper.removeData(key: CacheKeys.language);
  }
}
