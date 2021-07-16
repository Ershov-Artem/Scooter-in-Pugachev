import 'dart:convert';

import 'package:dio/dio.dart';

import '../entities/entities.dart';

class UserApiProvider {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://scoots.herokuapp.com/",
    contentType: "application/json",
  ));

  Future<PostUserResponse> regUser(String _phone, String _name) async {
    var params = {
      "phone": _phone,
      "name": _name,
    };
    final String url = "user/reg";
    try {
      Response response = await _dio.post(url,
          data: json.encode(params),
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          }));
      if (response.statusCode == 200)
        return PostUserResponse(response.statusCode);
      else
        return PostUserResponse.withError(response.data, response.statusCode);
    } catch (error, stackTrace) {
      return PostUserResponse.withError("$error", 0);
    }
  }
}
