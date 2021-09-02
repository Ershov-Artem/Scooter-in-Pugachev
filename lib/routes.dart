import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'pages/pay/pay.dart';
import 'pages/qrScaner/view/qrScanPage.dart';
import 'pages/reg&confirm/register/view/registerPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case '/QRScan':
        return MaterialPageRoute(builder: (context) => QRScanPage());
      case '/reg':
        return MaterialPageRoute(builder: (context) => RegPage());
      case '/pay':
        return MaterialPageRoute(builder: (context) => PayPage());
      default:
        debugPrint('Error in routing');
    }
  }
}
