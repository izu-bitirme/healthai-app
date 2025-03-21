

import 'package:shared_preferences/shared_preferences.dart';

class AppStatus {
  static const String isFirstOpenKey = 'isFirstOpen';

  static Future<bool> isFirstOpen() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(isFirstOpenKey) ?? true;
  }

  static Future<void> setFirstOpen({isFirstOpen = false}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(isFirstOpenKey, isFirstOpen);
  }
  
}
