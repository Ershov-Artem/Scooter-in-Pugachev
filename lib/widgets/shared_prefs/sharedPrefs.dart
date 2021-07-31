import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> get prefs async =>
    await SharedPreferences.getInstance();
