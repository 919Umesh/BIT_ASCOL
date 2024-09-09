import 'package:flutter/material.dart';

class CustomLog {
  static log({String value = ""}) {
    debugPrint("\x1B[37m $value \x1B[0m");
  }

  static errorLog({required dynamic value}) {
    debugPrint("\x1B[31m $value \x1B[0m");
  }

  static warningLog({required dynamic value}) {
    debugPrint("\x1B[33m $value \x1B[0m");
  }

  static successLog({required dynamic value}) {
    debugPrint("\x1B[32m $value \x1B[0m");
  }

  static actionLog({required dynamic value}) {
    debugPrint("\x1B[36m $value \x1B[0m");
  }
}
