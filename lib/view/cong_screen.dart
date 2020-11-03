import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizbox/theme/constant.dart';
import 'package:quizbox/theme/size_config.dart';
import 'package:quizbox/view/home.dart';
import 'package:quizbox/view/wrong_screen.dart';

class CongScreen extends StatelessWidget {
  static String routeName = '/cong_screen';
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
              Lottie.network(
                "https://assets5.lottiefiles.com/datafiles/1QPWH9xjWBflXo1QBqsL0XszJILLRF2dMiZ7PBt3/Trophy-animation/trophy.json",
                width: getProportionateScreenWidth(256),
                height: getProportionateScreenHeight(256),
              ),
              Text('Tebrikler!', style: kOpsTextStyle),
              SizedBox(height: getProportionateScreenHeight(22)),
              Text('Bütün soruları doğru cevapladınız', style: kResultInfoText),
              SizedBox(height: getProportionateScreenHeight(28)),
              Text('Yeni Yüksek Skor', style: kScoreInfoTextStyle),
              Text('860', style: kScoreTextStyle),
              SizedBox(height: getProportionateScreenHeight(48)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'Yeniden Oyna',
                    color: kSecondaryColor,
                    onPressed: () {
                      print('s');
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
