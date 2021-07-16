import 'package:flutter/material.dart';
import 'package:scooter_pugachev/pages/register/view/registerForm.dart';
import 'package:scooter_pugachev/pages/register/view/registerPage.dart';

import 'homeForm.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (false) ? HomeForm() : RegPage(),
    );
  }
}
