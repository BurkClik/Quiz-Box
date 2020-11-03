import 'package:flutter/material.dart';
import 'package:quizbox/routes.dart';
import 'package:quizbox/view/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Box',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: Splash(),
      initialRoute: Splash.routeName,
      routes: routes,
    );
  }
}
