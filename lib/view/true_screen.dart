import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizbox/model/question_provider.dart';
import 'package:quizbox/model/score_provider.dart';
import 'package:quizbox/model/time_model.dart';
import 'package:quizbox/theme/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:quizbox/theme/constant.dart';
import 'package:quizbox/widget/custom_button.dart';
import 'package:provider/provider.dart';

class TrueScreen extends StatelessWidget {
  static String routeName = '/true_screen';
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
}
