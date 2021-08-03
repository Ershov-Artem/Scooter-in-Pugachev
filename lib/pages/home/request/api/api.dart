import 'package:dio/dio.dart';
import 'package:scooter_pugachev/pages/home/request/entities/entities.dart';
import 'package:scooter_pugachev/widgets/shared_prefs/sharedPrefs.dart';

class CheckUserApiProvider {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://scoots.herokuapp.com/user",
    contentType: "application/json",
  ));
  Future<CheckUserResponse> checkUser() async {
    String url = "/me";
    Response response;
    String token = (await prefs).getString('Token');
    try {
      response = await _dio.get(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        return CheckUserResponse(response.statusCode);
      } else {
        return CheckUserResponse.withError(
            response.data.toString(), response.statusCode);
      }
    } catch (error, stackTrace) {
      print("Exception occurred: $error  stackTrace: $stackTrace");
      if (error.toString().contains("401")) {
        return CheckUserResponse.unLogined();
      }
      return CheckUserResponse.withError(error.toString(), response.statusCode);
    }
  }
}
