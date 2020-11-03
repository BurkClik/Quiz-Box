import 'package:flutter/material.dart';
import 'package:quizbox/services/database_helper.dart';
import 'package:quizbox/theme/size_config.dart';
import 'package:quizbox/view/home.dart';
import 'package:sqflite/sqflite.dart';

class Splash extends StatefulWidget {
  static String routeName = '/splash';
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  Future<Database> dbInit() async {
    Database db = await dbHelper.database;
    return db;
  }

  @override
  void initState() {
    super.initState();
    dbInit();
    Future.delayed(Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacement(_createRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/light_background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Image.asset("assets/images/Logo.png")
        ],
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Home(),
    transitionDuration: Duration(seconds: 2),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        ScaleTransition(
      scale: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.fastLinearToSlowEaseIn,
        ),
      ),
      child: child,
    ),
  );
}
