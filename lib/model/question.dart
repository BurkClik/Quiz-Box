class Question {
  String category;
  String questionText;
  String trueAnswer;
  String wrongAnswer_1;
  String wrongAnswer_2;
  String wrongAnswer_3;
  String difficulty;

  Question();

  Question.map(dynamic obj) {
    this.category = obj['Category'];
    this.questionText = obj['QuestionText'];
    this.trueAnswer = obj['TrueAnswer'];
    this.wrongAnswer_1 = obj['WrongAnswer_1'];
    this.wrongAnswer_2 = obj['WrongAnswer_2'];
    this.wrongAnswer_3 = obj['WrongAnswer_3'];
    this.difficulty = obj['Difficulty'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['Category'] = category;
    map['QuestionText'] = questionText;
    map['TrueAnswer'] = trueAnswer;
    map['WrongAnswer_1'] = wrongAnswer_1;
    map['WrongAnswer_2'] = wrongAnswer_2;
    map['WrongAnswer_3'] = wrongAnswer_3;
    map['Difficulty'] = difficulty;
    return map;
  }
}
