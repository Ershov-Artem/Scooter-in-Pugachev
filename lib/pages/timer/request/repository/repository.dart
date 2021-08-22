import '../api/api.dart';
import 'package:scooter_pugachev/pages/timer/request/entities/entities.dart';

class PhotoRepository {
  PhotoApiProvider _apiProvider = PhotoApiProvider();
  Future<PhotoResponse> postPhoto(String path) {
    return _apiProvider.postPhoto(path);
  }
}
