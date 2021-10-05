import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:scooter_pugachev/pages/pay/request/entities/entities.dart';
import 'package:scooter_pugachev/widgets/shared_prefs/sharedPrefs.dart';

class PayApiProvider {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://scoots.herokuapp.com",
    contentType: "application/json",
  ));

  Future<PayResponse> postPayToken(String _payToken, int _scootID) async {
    var params = {"token": _payToken, "id": _scootID};
    final String url = "/scoots/start";
    String _token = (await prefs).getString('Token');
    try {
      Response response = await _dio.post(
        url,
        data: json.encode(params),
        options: Options(headers: {
          "Authorization": "Bearer $_token",
          "Content-Type": "application/json",
          "Accept": "application/json"
        }),
      );
      print("pay statuscode: ${response.statusCode}");
      if (response.statusCode == 200) {
        return PayResponse(response.statusCode);
      } else {
        print("error with pay: ${response.data}");
        return PayResponse.withError(response.data, response.statusCode);
      }
    } catch (error) {
      print("error with pay: $error");
      return PayResponse.withError("$error", 0);
    }
  }
}
