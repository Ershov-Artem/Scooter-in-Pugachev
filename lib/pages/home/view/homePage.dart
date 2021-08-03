import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scooter_pugachev/pages/home/request/cubit/cubit.dart';
import 'package:scooter_pugachev/pages/reg&confirm/register/register.dart';
import 'package:scooter_pugachev/widgets/shared_prefs/sharedPrefs.dart';

import 'homeForm.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    bool _hasToken = false;

    void _getToken() async {
      String _token = (await prefs).getString('Token');
      if (_token != null) {
        print("Token: $_token");
        setState(() {
          _hasToken = true;
        });
      }
    }

    initState() {
      _getToken();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: (_hasToken)
          ? RegPage()
          : Center(
              child: BlocProvider<CheckUserCubit>(
              create: (BuildContext context) =>
                  CheckUserCubit(CheckStatus.loading),
              child: HomeForm(),
            )),
    );
  }
}
