import 'package:flutter/material.dart';

import 'payForm.dart';

class PayPage extends StatefulWidget {
  //const PayPage({ Key? key }) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: PayForm());
  }
}
