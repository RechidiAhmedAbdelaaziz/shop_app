
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPerfrences;
  static init() async {
    sharedPerfrences = await SharedPreferences.getInstance();
  }

  static Future<bool?> putData({required String key, required bool value}) async {
    return await sharedPerfrences?.setBool(key, value);
  }

  static bool? getData({required String key})  {
    return  sharedPerfrences!.getBool(key);
  }
}
