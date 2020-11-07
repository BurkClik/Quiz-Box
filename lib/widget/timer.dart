import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quizbox/model/time_model.dart';
import 'package:quizbox/theme/constant.dart';
import 'package:provider/provider.dart';

class Countdown extends StatefulWidget {
  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  Timer _timer;
  //int _time = 15;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (context.read<TimeModel>().countDown < 1) {
          _timer.cancel();
        } else {
          context.read<TimeModel>().minusOne();
        }
      });
    });
  }

  void restartTimer() {
    _timer.cancel();
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeModel = context.watch<TimeModel>();
    return Text("${timeModel.countDown}", style: kQuestionTimeText);
  }
}
