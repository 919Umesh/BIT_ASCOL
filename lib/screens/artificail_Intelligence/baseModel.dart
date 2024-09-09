import 'dart:developer';
import 'package:bit_ascol/screens/artificail_Intelligence/viewState.dart';
import 'package:flutter/foundation.dart';

class BaseModel with ChangeNotifier {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  set state(ViewState viewState) {
    log('State:$viewState');
    _state = viewState;
    notifyListeners();
  }

  set stateWithoutUpdate(ViewState viewState) {
    log('State:$viewState');
    _state = viewState;
  }

  void updateUI() {
    notifyListeners();
  }
}