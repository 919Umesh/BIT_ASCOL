import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static getData(
      {required String key, dynamic dValue, required String type}) async {
    late dynamic temp;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (type) {
      case "String":
        temp = prefs.getString(key) ?? dValue;
        break;
      case "int":
        temp = prefs.getInt(key) ?? dValue;
        break;
      case "bool":
        temp = prefs.getBool(key) ?? dValue;
        break;
    }
    return temp;
  }

  static setData({
    required String key,
    dynamic dValue,
    required String type,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (type) {
      case "String":
        prefs.setString(key, dValue);
        break;
      case "int":
        prefs.setInt(key, dValue);
        break;
      case "bool":
        prefs.setBool(key, dValue);
        break;
    }
  }

  static removeData({required String key, required String type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (type) {
      case "String":
        prefs.remove(key);
        break;
      case "int":
        prefs.remove(key);
        break;
      case "bool":
        prefs.remove(key);
        break;
    }
  }

  static removeAllData(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Navigator.of(context).pushNamedAndRemoveUntil(loginPath, (route) => false);
  }
}
