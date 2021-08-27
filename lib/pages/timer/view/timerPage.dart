import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'timerForm.dart';

class TimerPage extends StatefulWidget {
  final Timestamped startedAt;

  TimerPage(this.startedAt);
  @override
  _TimerPageState createState() => _TimerPageState(startedAt);
}

class _TimerPageState extends State<TimerPage> {
  final Timestamped startedAt;

  _TimerPageState(this.startedAt);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TimerForm(startedAt));
  }
}
