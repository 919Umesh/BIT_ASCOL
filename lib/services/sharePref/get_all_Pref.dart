//
//
// import 'package:bit_ascol/services/sharePref/pref_text.dart';
// import 'package:bit_ascol/services/sharePref/shared_Preference.dart';
//
// class GetAllPref {
//   static getUserId() async {
//     return await SharedPref.getData(
//       key: PrefText.userId,
//       dValue: "-",
//       type: "String",
//     );
//   }
//
//   static getIsAdmin() async {
//     return await SharedPref.getData(
//       key: PrefText.isAdmin,
//       dValue: false,
//       type: "bool",
//     );
//   }
//
//   static getIsLogin() async {
//     return await SharedPref.getData(
//       key: PrefText.isLogin,
//       dValue: false,
//       type: "bool",
//     );
//   }
//
// }

import 'package:bit_ascol/services/sharePref/pref_text.dart';
import 'package:bit_ascol/services/sharePref/shared_Preference.dart';

class GetAllPref {
  static Future<String> getUserId() async {
    return await SharedPref.getData(
      key: PrefText.userId,
      dValue: "-",
      type: "String",
    );
  }

  static Future<bool> getIsAdmin() async {
    return await SharedPref.getData(
      key: PrefText.isAdmin,
      dValue: false,
      type: "bool",
    );
  }

  static Future<bool> getIsLogin() async {
    return await SharedPref.getData(
      key: PrefText.isLogin,
      dValue: false,
      type: "bool",
    );
  }
}
