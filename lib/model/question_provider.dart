import 'package:flutter/cupertino.dart';
import 'package:quizbox/model/question.dart';

class QuestionProvider extends ChangeNotifier {
  List<Question> _questionBank;
  List<Question> get questionBank => _questionBank;

  int _questionNumber;
  int get questionNumber => _questionNumber;

  String _questionCategory;
  String get questionCategory => _questionCategory;

  QuestionProvider(
      this._questionBank, this._questionNumber, this._questionCategory);

  void getQuestionBank(List<Question> databaseQuestion) {
    _questionBank = databaseQuestion;
    notifyListeners();
  }

  void addItem(dynamic item) {
    _questionBank.add(item);
    notifyListeners();
  }

  void deleteAllItem() {
    _questionBank.clear();
    //notifyListeners();
  }

  void increaseQuestionNumber() {
    _questionNumber++;
    notifyListeners();
  }

  void resetQuestionNumber() {
    _questionNumber = 0;
    //notifyListeners();
  }

  void updateCategory(String newCategory) {
    _questionCategory = newCategory;
    notifyListeners();
  }
}
