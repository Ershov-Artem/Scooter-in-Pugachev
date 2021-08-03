import 'package:scooter_pugachev/pages/home/request/api/api.dart';
import 'package:scooter_pugachev/pages/home/request/entities/entities.dart';

class CheckUserRepository {
  CheckUserApiProvider _apiProvider = CheckUserApiProvider();

  Future<CheckUserResponse> checkUser() {
    return _apiProvider.checkUser();
  }
}
