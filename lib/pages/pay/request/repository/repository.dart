import '../api/api.dart';
import '../entities/entities.dart';

class PayRepository {
  PayApiProvider _apiProvider = PayApiProvider();

  Future<PayResponse> postPayToken(String _payToken, int _scootID) {
    return _apiProvider.postPayToken(_payToken, _scootID);
  }
}
