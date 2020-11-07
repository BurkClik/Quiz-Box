import 'package:flutter/cupertino.dart';

class ScoreProvider extends ChangeNotifier {
  int _score;
  int get score => _score;

  int _remainQuestion;
  int get remainQuestion => _remainQuestion;

  int _trueQuestion;
  int get trueQuestion => _trueQuestion;

  ScoreProvider(this._score, this._remainQuestion, this._trueQuestion);

  void newScore(int questionScore) {
    _score += questionScore;
    notifyListeners();
  }

  void resetScore() {
    _score = 0;
    notifyListeners();
  }

  void increaseTrue() {
    _trueQuestion++;
    notifyListeners();
  }

  void decrease() {
    _remainQuestion--;
    notifyListeners();
  }

  void setRemainQuestion(int length) {
    _remainQuestion = length;
    notifyListeners();
  }
}
