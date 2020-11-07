import 'package:flutter/material.dart';
import 'package:quizbox/model/time_model.dart';
import 'package:quizbox/theme/size_config.dart';
import 'package:provider/provider.dart';
import 'package:quizbox/theme/constant.dart';

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

          context.read<TimeModel>().resetCountDown(15);
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
