import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scooter_pugachev/pages/final/request/cubit/cubit.dart';

import 'finalForm.dart';

class FinalPage extends StatefulWidget {
  int minutes;
  FinalPage(this.minutes);
  @override
  _FinalPageState createState() => _FinalPageState(minutes);
}

class _FinalPageState extends State<FinalPage> {
  int minutes;
  _FinalPageState(this.minutes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: BlocProvider<FinalPayBloc>(
          create: (BuildContext context) =>
              FinalPayBloc(FinalPayStatus.initial),
          child: FinalForm(minutes),
        )));
  }
}
