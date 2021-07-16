import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'routes.dart';
import 'pages/home/view/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          button: GoogleFonts.lato(fontSize: 17),
          bodyText1: GoogleFonts.lato(fontSize: 17, color: Colors.blueAccent),
          headline1: GoogleFonts.lato(color: Colors.white, fontSize: 22),
        ),
      ),
      home: HomePage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
