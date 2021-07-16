import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scooter_pugachev/pages/register/view/registerPage.dart';
import 'pages/qrScaner/view/qrScanPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case '/QRScan':
        return MaterialPageRoute(builder: (context) => QRScanPage());
      case '/reg':
        return MaterialPageRoute(builder: (context) => RegPage());
      default:
        debugPrint('Error in routing');
    }
  }
}
