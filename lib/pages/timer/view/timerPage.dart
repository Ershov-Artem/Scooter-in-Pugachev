import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scooter_pugachev/pages/timer/request/cubit/cubit.dart';

import 'timerForm.dart';

class TimerPage extends StatefulWidget {
  final String startedAt;

  TimerPage(this.startedAt);
  @override
  _TimerPageState createState() => _TimerPageState(startedAt);
}

class _TimerPageState extends State<TimerPage> {
  final String startedAt;

  _TimerPageState(this.startedAt);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: BlocProvider<PhotoCubit>(
        create: (BuildContext context) => PhotoCubit(PhotoStatus.loading),
        child: TimerForm(startedAt),
      ),
    ));
  }
}
