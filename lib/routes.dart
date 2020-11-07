import 'package:flutter/widgets.dart';
import 'package:quizbox/view/cong_screen.dart';
import 'package:quizbox/view/splash.dart';
import 'package:quizbox/view/home.dart';
import 'package:quizbox/view/question_view.dart';
import 'package:quizbox/view/true_screen.dart';
import 'package:quizbox/view/wrong_screen.dart';

final Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => Splash(),
  Home.routeName: (context) => Home(),
  QuestionView.routeName: (context) => QuestionView(),
  WrongScreen.routeName: (context) => WrongScreen(),
  CongScreen.routeName: (context) => CongScreen(),
  TrueScreen.routeName: (context) => TrueScreen(),
};
