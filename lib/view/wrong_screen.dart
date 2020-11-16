import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';

class WrongScreen extends StatefulWidget {
  static String routeName = '/wrong_screen';

  @override
  _WrongScreenState createState() => _WrongScreenState();
}

class _WrongScreenState extends State<WrongScreen> {
  String category;
  String reportQ;

  DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    category = context.read<QuestionProvider>().questionCategory;
    if (context.read<TimeModel>().countDown > 0) {
      updateTimer();
    }
    context.read<QuestionProvider>().resetQuestionNumber();
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
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Image.asset(
          "assets/images/Logo.png",
          width: getProportionateScreenWidth(135),
          height: getProportionateScreenHeight(50),
        ),
        leading: IconButton(
          splashColor: kSecondaryColor,
          splashRadius: 24.0,
          onPressed: () async {
            try {
              final result = await InternetAddress.lookup('google.com');
              if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                buildShowDialog(context);
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
          icon: SvgPicture.asset("assets/icons/exclamation.svg",
              width: getProportionateScreenWidth(32.0),
              height: getProportionateScreenHeight(36.0)),
        ),
        actions: [
          IconButton(
            splashColor: kThirdColor,
            splashRadius: 24.0,
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

  Future buildShowDialog(BuildContext context) {
    CollectionReference reportQuestion =
        FirebaseFirestore.instance.collection('reportQuestion');

    Future<void> report() {
      return reportQuestion.add({
        'ReportText': reportQ,
      }).then((value) {
        Fluttertoast.showToast(
          msg: "Hata iletildi",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }).catchError((_) {});
    }

    return showDialog(
      context: context,
      child: AlertDialog(
        backgroundColor: kSecondaryColor,
        title: Text(
          'HATALI SORU',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              TextFormField(
                maxLines: 3,
                style: TextStyle(color: Colors.white),
                cursorColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    reportQ = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.24),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Lütfen soru ile ilgili hatayı yazınız.',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(12.0)),
              Container(
                decoration: kButtonBoxDeco,
                child: FlatButton(
                  onPressed: () {
                    report();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Bildir',
                    style: kAlertButtonStyle,
                  ),
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
