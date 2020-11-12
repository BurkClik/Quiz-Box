import 'package:flutter/cupertino.dart';

class TimeModel extends ChangeNotifier {
  int _countDown;
  int get countDown => _countDown;

  TimeModel(this._countDown);

  void resetCountDown(int reset) {
    _countDown = reset;
    //notifyListeners();
  }

  void minusOne() {
    _countDown--;
    notifyListeners();
  }
}
