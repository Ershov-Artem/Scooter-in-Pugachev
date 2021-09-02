import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scooter_pugachev/pages/pay/request/cubit/cubit.dart';

import 'payForm.dart';

class PayPage extends StatefulWidget {
  //const PayPage({ Key? key }) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: BlocProvider<PayBloc>(
          create: (BuildContext context) => PayBloc(PayStatus.initial),
          child: PayForm(),
        )));
  }
}
