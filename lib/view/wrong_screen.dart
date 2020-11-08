import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizbox/model/question.dart';
import 'package:quizbox/model/question_provider.dart';
import 'package:quizbox/model/score_provider.dart';
import 'package:quizbox/model/time_model.dart';
import 'package:quizbox/services/database_helper.dart';
import 'package:quizbox/theme/constant.dart';
import 'package:quizbox/theme/size_config.dart';
import 'package:quizbox/view/home.dart';
import 'package:quizbox/widget/custom_button.dart';
import 'package:provider/provider.dart';

class WrongScreen extends StatefulWidget {
  static String routeName = '/wrong_screen';

  @override
  _WrongScreenState createState() => _WrongScreenState();
}

class _WrongScreenState extends State<WrongScreen> {
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    dbHelper.getRandom().then((value) {
      setState(() {
        if (context.read<TimeModel>().countDown > 0) {
          updateTimer();
        }
        clearList();
        context.read<QuestionProvider>().resetQuestionNumber();
        value.forEach((element) {
          context.read<QuestionProvider>().addItem(Question.map(element));
        });
        context.read<ScoreProvider>().setRemainQuestion(
            context.read<QuestionProvider>().questionBank.length - 1);
      });
    });
  }

  void updateTimer() {
    context.read<TimeModel>().resetCountDown(15);
  }

  void clearList() {
    if (context.read<QuestionProvider>().questionBank.length > 0) {
      context.read<QuestionProvider>().deleteAllItem();
    }
  }

  void resetScore() {
    if (context.read<ScoreProvider>().score > 0) {
      context.read<ScoreProvider>().resetScore();
    }
  }

  void resetTrueNumber() {
    if (context.read<ScoreProvider>().trueQuestion > 0) {
      context.read<ScoreProvider>().resetTrueCount();
    }
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animation/wrong.json",
                repeat: false,
                width: getProportionateScreenWidth(256),
                height: getProportionateScreenHeight(256),
              ),
              Text('Oooops!', style: kOpsTextStyle),
              SizedBox(height: getProportionateScreenHeight(22)),
              Text(
                  '${context.watch<ScoreProvider>().trueQuestion} soruyu doğru cevapladın',
                  style: kResultInfoText),
              SizedBox(height: getProportionateScreenHeight(28)),
              Text('Skor', style: kScoreInfoTextStyle),
              Text('${context.watch<ScoreProvider>().score}',
                  style: kScoreTextStyle),
              SizedBox(height: getProportionateScreenHeight(48)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'Yeniden Oyna',
                    color: kSecondaryColor,
                    onPressed: () {
                      resetScore();
                      resetTrueNumber();
                      Navigator.of(context).popAndPushNamed('/question');
                    },
                  ),
                  SizedBox(width: getProportionateScreenWidth(20.0)),
                  CustomButton(
                    text: 'Kategori Seç',
                    color: kThirdColor,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Home(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
