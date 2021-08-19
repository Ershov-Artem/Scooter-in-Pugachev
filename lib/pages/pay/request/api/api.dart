import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:scooter_pugachev/pages/pay/request/entities/entities.dart';
import 'package:scooter_pugachev/widgets/shared_prefs/sharedPrefs.dart';

class PayApiProvider {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: "https//scoots.herokuapp.com",
      contentType: "application/json",
      headers: {"Host": "scoots.herokuapp.com"}));

  Future<PayResponse> postPayToken(String _payToken, int _scootID) async {
    var params = {
      "token": _payToken,
      "id": _scootID,
    };
    String url = "";
    Response response;
    String token = (await prefs).getString('Token');
    try {
      response = await _dio.post(url,
          options: Options(headers: {"Authorization": "Bearer $token"}),
          data: json.encode(params));
      if (response.statusCode == 200) {
        return PayResponse(response.statusCode);
      } else {
        return PayResponse.withError(response.data, response.statusCode);
      }
    } catch (error) {
      return PayResponse.withError("$error", 0);
    }
  }
}
