import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizbox/theme/constant.dart';
import 'package:quizbox/theme/size_config.dart';
import 'package:quizbox/view/cong_screen.dart';
import 'package:quizbox/view/home.dart';

class WrongScreen extends StatelessWidget {
  static String routeName = '/wrong_screen';
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
                "https://assets1.lottiefiles.com/packages/lf20_kyqRXF.json",
                width: getProportionateScreenWidth(256),
                height: getProportionateScreenHeight(256),
              ),
              Text('Oooops!', style: kOpsTextStyle),
              SizedBox(height: getProportionateScreenHeight(22)),
              Text('8 soruyu doğru cevapladınız', style: kResultInfoText),
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => CongScreen(),
                        ),
                      );
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

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function onPressed;

  CustomButton({this.color, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kButtonBoxDeco,
      child: FlatButton(
        onPressed: () {
          onPressed();
        },
        child: Text(text, style: kButtonTextStyle),
        color: color,
        splashColor: kThirdColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        height: getProportionateScreenHeight(48.0),
        minWidth: getProportionateScreenWidth(160.0),
      ),
    );
  }
}
