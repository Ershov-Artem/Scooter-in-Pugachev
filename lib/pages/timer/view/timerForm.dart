import 'dart:async';

import 'package:flutter/material.dart';

class TimerForm extends StatefulWidget {
  @override
  _TimerFormState createState() => _TimerFormState();
}

class _TimerFormState extends State<TimerForm> {
  Timer _timer;
  int _start = 0;
  bool _isStoped = false;

  void startTimer() {
    _timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      if (_isStoped) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start++;
        });
      }
    });
  }

  String _startToTimeString(start) {
    int _seconds, _minutes;
    _seconds = start % 60;
    _minutes = (start - _seconds) / 60;
    String _sec = "$_seconds", _min = "$_minutes";
    if (_seconds < 10) {
      _sec = "0" + _sec;
    }
    if (_minutes < 10) {
      _min = "0" + _min;
    }
    return _min + " : " + _sec;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 275,
          padding: EdgeInsets.only(bottom: 60),
          child: Text(
            "Длительность Вашейпоездки",
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
            width: 275,
            child: Text(
              _startToTimeString(_start),
              style: Theme.of(context).textTheme.headline3,
            )),
      ],
    ));
  }
}
