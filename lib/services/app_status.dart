

import 'package:shared_preferences/shared_preferences.dart';

class AppStatus {
  static const String isFirstOpenKey = 'isFirstOpen';
  static const String isLoginKey = 'isLogin';

  static Future<bool> isFirstOpen() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(isFirstOpenKey) ?? true;
  }

  static Future<void> setFirstOpen({isFirstOpen = false}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(isFirstOpenKey, isFirstOpen);
  }

  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(isLoginKey) ?? false;
  }


  static Future<void> setLogin({isLogin = false}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(isLoginKey, isLogin);
  }
  
}
