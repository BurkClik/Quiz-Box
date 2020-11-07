import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizbox/model/question.dart';
import 'package:quizbox/model/question_provider.dart';
import 'package:quizbox/model/score_provider.dart';
import 'package:quizbox/model/time_model.dart';
import 'package:quizbox/theme/constant.dart';
import 'package:quizbox/theme/size_config.dart';
import 'package:quizbox/view/wrong_screen.dart';
import 'package:quizbox/widget/timer.dart';
import 'package:provider/provider.dart';

class QuestionView extends StatefulWidget {
  static String routeName = '/question';
  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  int score;
  int questionNumber;
  int remainQuestion;
  String difficulty;
  String trueAnswer;
  String questionText;
  List<dynamic> deneme;

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

  List<dynamic> demo() {
    return shuffle([
      context.read<QuestionProvider>().questionBank[questionNumber].trueAnswer,
      context
          .read<QuestionProvider>()
          .questionBank[questionNumber]
          .wrongAnswer_1,
      context
          .read<QuestionProvider>()
          .questionBank[questionNumber]
          .wrongAnswer_2,
      context
          .read<QuestionProvider>()
          .questionBank[questionNumber]
          .wrongAnswer_3,
    ]);
  }

  int diffucltyPoint() {
    difficulty = context
        .read<QuestionProvider>()
        .questionBank[questionNumber]
        .difficulty;
    switch (difficulty) {
      case 'Easy':
        return 3;
        break;
      case 'Medium':
        return 5;
        break;
      case 'Hard':
        return 7;
        break;
      default:
        return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    questionNumber = context.read<QuestionProvider>().questionNumber;
    trueAnswer = context
        .read<QuestionProvider>()
        .questionBank[questionNumber]
        .trueAnswer;
    score = context.read<ScoreProvider>().score;
    deneme = demo();
/*     print(context.read<QuestionProvider>().questionBank.length);
    if (context.read<QuestionProvider>().questionBank.length == 15) {
      context.read<ScoreProvider>().setRemainQuestion(
          context.read<QuestionProvider>().questionBank.length);
    } */
  }

  @override
  Widget build(BuildContext context) {
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
                      Text(
                          "Kalan Soru: ${context.watch<ScoreProvider>().remainQuestion}",
                          style: kQuestionInfoText),
                      Text("Puan: $score", style: kQuestionInfoText),
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
                        '${context.watch<QuestionProvider>().questionBank[questionNumber].questionText}',
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
                    Countdown(),
                  ],
                ),
                SizedBox(height: 28),
                Expanded(
                  child: ListView.separated(
                    itemCount: deneme.length,
                    separatorBuilder: (context, index) => SizedBox(height: 36),
                    itemBuilder: (context, index) {
                      return ChoiceButton(
                        text: deneme[index],
                        onPressed: () {
                          if (trueAnswer == deneme[index]) {
                            setState(
                              () {
                                context.read<ScoreProvider>().newScore(
                                    diffucltyPoint() *
                                        context.read<TimeModel>().countDown);
                                context.read<ScoreProvider>().decrease();
                                Navigator.of(context)
                                    .popAndPushNamed('/true_screen');
                              },
                            );
                            context.read<TimeModel>().resetCountDown(15);
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    WrongScreen(),
                              ),
                            );
                          }
                        },
                      );
                    },
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

class ChoiceButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const ChoiceButton({Key key, this.text, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(360),
      height: getProportionateScreenHeight(48),
      decoration: kButtonBoxDeco,
      child: FlatButton(
        onPressed: () {
          onPressed();
        },
        child: Text(text, style: kQuestionTextStyle),
        color: kSecondaryColor,
        splashColor: kThirdColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
