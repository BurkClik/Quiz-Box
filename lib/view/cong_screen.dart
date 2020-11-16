import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:share/share.dart';

class CongScreen extends StatefulWidget {
  static String routeName = '/cong_screen';

  @override
  _CongScreenState createState() => _CongScreenState();
}

class _CongScreenState extends State<CongScreen> {
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  String category;

  @override
  void initState() {
    super.initState();
    category = context.read<QuestionProvider>().questionCategory;
    updateTimer();
    context.read<QuestionProvider>().resetQuestionNumber();
  }

  void updateTimer() {
    context.read<TimeModel>().resetCountDown(15);
  }

  void clearList() {
    if (context.read<QuestionProvider>().questionBank.isNotEmpty) {
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
        actions: [
          IconButton(
            onPressed: () async {
              try {
                final result = await InternetAddress.lookup('google.com');
                if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                  Share.share(
                      "${context.read<QuestionProvider>().questionCategory} kategorisinde ${context.read<ScoreProvider>().score} puan aldım. Beni geçebilir misin?");
                }
              } on SocketException catch (_) {
                Fluttertoast.showToast(
                  msg: "Lütfen internet bağlantınızı kontrol edin",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP,
                  backgroundColor: Color(0xFFEC1C24),
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
            icon: SvgPicture.asset("assets/icons/forward.svg",
                width: getProportionateScreenWidth(32.0),
                height: getProportionateScreenHeight(32.0)),
          )
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animation/trophy.json",
                width: getProportionateScreenWidth(256),
                height: getProportionateScreenHeight(256),
              ),
              Text('Tebrikler!', style: kOpsTextStyle),
              SizedBox(height: getProportionateScreenHeight(22)),
              Text('Bütün soruları doğru cevapladınız', style: kResultInfoText),
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
                    onPressed: () async {
                      clearList();
                      resetScore();
                      resetTrueNumber();
                      List<String> difficult = ['Easy', 'Medium', 'Hard'];
                      if (category != 'Knowledge') {
                        for (int i = 0; i < 3; i++) {
                          await dbHelper
                              .getCategoryRandom(category, difficult[i])
                              .then((value) {
                            setState(() {
                              value.forEach((element) {
                                context
                                    .read<QuestionProvider>()
                                    .addItem(Question.map(element));
                              });
                              context.read<ScoreProvider>().setRemainQuestion(
                                  context
                                          .read<QuestionProvider>()
                                          .questionBank
                                          .length -
                                      1);
                            });
                          });
                        }
                      } else {
                        for (int i = 0; i < 3; i++) {
                          await dbHelper.getRandom(difficult[i]).then((value) {
                            setState(() {
                              value.forEach((element) {
                                context
                                    .read<QuestionProvider>()
                                    .addItem(Question.map(element));
                              });
                              context.read<ScoreProvider>().setRemainQuestion(
                                  context
                                          .read<QuestionProvider>()
                                          .questionBank
                                          .length -
                                      1);
                            });
                          });
                        }
                      }
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
