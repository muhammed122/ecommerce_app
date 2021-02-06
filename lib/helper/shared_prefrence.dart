import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static saveUserInfo(bool rememberMe, String userId) async {
    final shared = await SharedPreferences.getInstance();
    shared.setBool("rememberMe", rememberMe);
    shared.setString("userId", userId);

    print("remember $rememberMe");
  }

  static Future<bool> checkUserLogin() async {
    final shared = await SharedPreferences.getInstance();
    var v = shared.getBool("rememberMe");
    print("v $v");
    if (v == null) return false;
    return v;
  }

  static Future<String> getUserId() async {
    final shared = await SharedPreferences.getInstance();
    var id = shared.getString("userId");
    return id;
  }

  static saveCartCount(int count) async {
    final shared = await SharedPreferences.getInstance();
    shared.setInt("count", count);
  }
  static Future<int> getCartCount() async {
    final shared = await SharedPreferences.getInstance();
    int count = shared.getInt("count") ?? 0;
    return count;
  }

}
