import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:scooter_pugachev/widgets/shared_prefs/sharedPrefs.dart';
import '../entities/entities.dart';

class FinalPayApiProvider {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://scoots.herokuapp.com",
    contentType: "application/json",
  ));

  Future<FinalPayResponse> postFinalPayToken(String _payToken) async {
    var params = {"token": _payToken};
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
        return FinalPayResponse(response.statusCode);
      } else {
        print("error with pay: ${response.data}");
        return FinalPayResponse.withError(response.data, response.statusCode);
      }
    } catch (error) {
      print("error with pay: $error");
      return FinalPayResponse.withError("$error", 0);
    }
  }
}
