import 'package:flutter/material.dart';
import 'package:quizbox/theme/constant.dart';

ThemeData lightTheme() {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: appBarTheme(),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    centerTitle: true,
    color: Colors.transparent,
    elevation: 0.0,
  );
}
