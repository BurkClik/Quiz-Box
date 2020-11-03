import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizbox/model/question.dart';
import 'package:quizbox/theme/constant.dart';
import 'package:quizbox/theme/size_config.dart';
import 'package:quizbox/view/wrong_screen.dart';

//TODO: Close ikonunu daha kalın bir ikon ile değiştir.

class QuestionView extends StatefulWidget {
  static String routeName = '/question';
  final List<Question> question;

  const QuestionView({Key key, this.question}) : super(key: key);
  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  int questionNumber = 0;
  String trueAnswer;
  String questionText;

  List shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    questionText = widget.question[questionNumber].questionText;
    trueAnswer = widget.question[questionNumber].trueAnswer;
    List<String> questionAnswers = [
      widget.question[questionNumber].trueAnswer,
      widget.question[questionNumber].wrongAnswer_1,
      widget.question[questionNumber].wrongAnswer_2,
      widget.question[questionNumber].wrongAnswer_3,
    ];
    List<String> shuffledQuestionsA = shuffle(questionAnswers);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Image.asset(
          "assets/images/Logo.png",
          width: getProportionateScreenWidth(135),
          height: getProportionateScreenHeight(50),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/home');
              },
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/light_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: getProportionateScreenHeight(36.0),
              left: getProportionateScreenWidth(20.0),
              right: getProportionateScreenWidth(20.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: getProportionateScreenHeight(8.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kalan Soru:15", style: kQuestionInfoText),
                      Text("Puan: 150", style: kQuestionInfoText),
                    ],
                  ),
                ),
                Container(
                  width: getProportionateScreenWidth(360),
                  height: getProportionateScreenHeight(200),
                  decoration: kCategoryBoxDeco,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenHeight(28.0)),
                      child: Text(
                        '$questionText',
                        style: kQuestionTextStyle,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/watch.svg",
                      height: 32,
                      width: 15,
                    ),
                    SizedBox(width: 4),
                    Text("15", style: kQuestionTimeText),
                  ],
                ),
                SizedBox(height: 28),
                InkWell(
                  onTap: () {
                    if (trueAnswer == shuffledQuestionsA[0]) {
                      setState(() {
                        questionNumber++;
                        questionText =
                            widget.question[questionNumber].questionText;
                      });
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => WrongScreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: getProportionateScreenWidth(360),
                    height: getProportionateScreenHeight(48),
                    decoration: kAnswerBoxStyle,
                    child: Center(
                      child: Text('${shuffledQuestionsA[0]}',
                          style: kQuestionTextStyle),
                    ),
                  ),
                ),
                SizedBox(height: 36),
                InkWell(
                  onTap: () {
                    if (trueAnswer == shuffledQuestionsA[1]) {
                      setState(() {
                        questionNumber++;
                        questionText =
                            widget.question[questionNumber].questionText;
                      });
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => WrongScreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: getProportionateScreenWidth(360),
                    height: getProportionateScreenHeight(48),
                    decoration: kAnswerBoxStyle,
                    child: Center(
                      child: Text('${shuffledQuestionsA[1]}',
                          style: kQuestionTextStyle),
                    ),
                  ),
                ),
                SizedBox(height: 36),
                InkWell(
                  onTap: () {
                    if (trueAnswer == shuffledQuestionsA[2]) {
                      setState(() {
                        questionNumber++;
                        questionText =
                            widget.question[questionNumber].questionText;
                      });
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => WrongScreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: getProportionateScreenWidth(360),
                    height: getProportionateScreenHeight(48),
                    decoration: kAnswerBoxStyle,
                    child: Center(
                      child: Text('${shuffledQuestionsA[2]}',
                          style: kQuestionTextStyle),
                    ),
                  ),
                ),
                SizedBox(height: 36),
                InkWell(
                  onTap: () {
                    if (trueAnswer == shuffledQuestionsA[3]) {
                      setState(() {
                        questionNumber++;
                        questionText =
                            widget.question[questionNumber].questionText;
                      });
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => WrongScreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: getProportionateScreenWidth(360),
                    height: getProportionateScreenHeight(48),
                    decoration: kAnswerBoxStyle,
                    child: Center(
                      child: Text('${shuffledQuestionsA[3]}',
                          style: kQuestionTextStyle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
