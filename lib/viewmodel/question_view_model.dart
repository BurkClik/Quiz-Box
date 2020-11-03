import 'package:quizbox/model/question.dart';

class QuestionViewModel {
  Question _question;

  QuestionViewModel({Question question}) : _question = question;

  String get category {
    return _question.category;
  }

  String get questionText {
    return _question.questionText;
  }

  String get trueAnswer {
    return _question.trueAnswer;
  }

  String get wrongAnswer_1 {
    return _question.wrongAnswer_1;
  }

  String get wrongAnswer_2 {
    return _question.wrongAnswer_2;
  }

  String get wrongAnswer_3 {
    return _question.wrongAnswer_3;
  }
}
