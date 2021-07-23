import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scooter_pugachev/pages/register/cubit/cubit.dart';

import 'registerForm.dart';

class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
        child: BlocProvider<PostUserBloc>(
      create: (BuildContext context) => PostUserBloc(UserStatus.initial),
      child: RegForm(),
    ));
  }
}
