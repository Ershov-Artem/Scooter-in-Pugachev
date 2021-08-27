import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'pages/pay/pay.dart';

import 'pages/timer/view/timerPage.dart';
import 'routes.dart';
import 'pages/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          button: GoogleFonts.redHatText(
              fontSize: 17,
              color: Color(0xffffffff),
              fontWeight: FontWeight.w400),
          bodyText1: GoogleFonts.lato(fontSize: 17, color: Color(0xff424754)),
          bodyText2: GoogleFonts.lato(fontSize: 14, color: Color(0xff424754)),
          headline1: GoogleFonts.lato(color: Colors.white, fontSize: 22),
          headline2: GoogleFonts.lato(color: Color(0xff424754), fontSize: 25),
          headline3: GoogleFonts.lato(color: Color(0xff424754), fontSize: 55),
        ),
      ),
      //home: HomePage(),
      home: TimerPage(null),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
