import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scooter_pugachev/pages/reg&confirm/request/cubit/cubit.dart';
import 'confirmForm.dart';

class ConfirmPage extends StatefulWidget {
  final String phoneNumber;

  ConfirmPage(this.phoneNumber);

  //const ConfirmPage({ Key? key }) : super(key: key);

  @override
  _ConfirmPageState createState() => _ConfirmPageState(phoneNumber);
}

class _ConfirmPageState extends State<ConfirmPage> {
  final String phoneNumber;
  _ConfirmPageState(this.phoneNumber);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocProvider<PostUserBloc>(
      create: (BuildContext context) => PostUserBloc(UserStatus.initial),
      child: ConfirmForm(phoneNumber),
    ));
  }
}
