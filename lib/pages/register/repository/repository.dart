import '../api/regApi.dart';
import '../entities/entities.dart';

class UserRepository {
  UserApiProvider _apiProvider = UserApiProvider();

  Future<PostUserResponse> regUser(_phone, _name) {
    return _apiProvider.regUser(_phone, _name);
  }
}
