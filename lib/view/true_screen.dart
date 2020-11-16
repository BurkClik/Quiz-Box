import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quizbox/model/question_provider.dart';
import 'package:quizbox/model/score_provider.dart';
import 'package:quizbox/model/time_model.dart';
import 'package:quizbox/theme/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:quizbox/theme/constant.dart';
import 'package:quizbox/widget/custom_button.dart';
import 'package:provider/provider.dart';

class TrueScreen extends StatefulWidget {
  static String routeName = '/true_screen';

  @override
  _TrueScreenState createState() => _TrueScreenState();
}

class _TrueScreenState extends State<TrueScreen> {
  String reportQ;
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
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/home');
              },
              icon: SvgPicture.asset("assets/icons/close2.svg",
                  width: getProportionateScreenWidth(32.0),
                  height: getProportionateScreenHeight(32.0)),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animation/tick.json',
                repeat: false,
                width: getProportionateScreenWidth(256),
                height: getProportionateScreenHeight(256),
              ),
              Text('Doğru Cevap', style: kOpsTextStyle),
              SizedBox(height: getProportionateScreenHeight(22)),
              Text(
                  '${context.watch<ScoreProvider>().trueQuestion} soruyu doğru cevapladın',
                  style: kResultInfoText),
              SizedBox(height: getProportionateScreenHeight(28)),
              Text('Skor', style: kScoreInfoTextStyle),
              Text('${context.watch<ScoreProvider>().score}',
                  style: kScoreTextStyle),
              SizedBox(height: getProportionateScreenHeight(48)),
              CustomButton(
                color: kSecondaryColor,
                text: 'Sıradaki Soru',
                onPressed: () {
                  context.read<QuestionProvider>().increaseQuestionNumber();
                  context.read<ScoreProvider>().decrease();
                  context.read<TimeModel>().resetCountDown(15);
                  Navigator.of(context).popAndPushNamed('/question');
                },
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
