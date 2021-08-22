import 'dart:io';
import 'package:mime/mime.dart';

import 'package:dio/dio.dart';
import '../entities/entities.dart';
import 'package:scooter_pugachev/widgets/shared_prefs/sharedPrefs.dart';

class PhotoApiProvider {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: "https://scoots.herokuapp.com",
      contentType: "application/json",
      headers: {"Host": "scoots.herokuapp.com"}));

  Future<PhotoResponse> postPhoto(String path) async {
    String url = "/scoots/add-photo";
    Response response;

    String token = (await prefs).getString('Token');

    try {
      final demoBytes = File(path).readAsBytesSync();
      response = await _dio.post(url,
          options: Options(headers: {
            "Authorization": "Bearer $token",
            "Content-Type": lookupMimeType(path),
            "Connection": "keep-alive",
            "Content-Length": demoBytes.length,
          }),
          data: Stream.fromIterable(demoBytes.map((e) => [e])));

      if (response.statusCode == 200) {
        return PhotoResponse(response.statusCode);
      } else {
        return PhotoResponse.withError(
            response.data.toString(), response.statusCode);
      }
    } catch (e) {
      print(e);
      return PhotoResponse.withError(e.toString(), 0);
    }
  }
}
