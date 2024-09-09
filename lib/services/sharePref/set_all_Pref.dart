import 'package:bit_ascol/services/sharePref/pref_text.dart';
import 'package:bit_ascol/services/sharePref/shared_Preference.dart';

class SetAllPref {
  static setUserId({required String value}) async {
    await SharedPref.setData(
      key: PrefText.userId,
      dValue: value,
      type: "String",
    );
  }


  static setIsAdmin({required bool value}) async {
    await SharedPref.setData(
      key: PrefText.isAdmin,
      dValue: value,
      type: "bool",
    );
  }

  static setIsLogin({required bool value}) async {
    await SharedPref.setData(
      key: PrefText.isLogin,
      dValue: value,
      type: "bool",
    );
  }

}
