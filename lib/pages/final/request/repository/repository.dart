import '../api/api.dart';
import '../entities/entities.dart';

class FinalRepository {
  FinalApiProvider _apiProvider = FinalApiProvider();

  Future<FinalResponse> finalPay(String _payToken) {
    return _apiProvider.finalPay(_payToken);
  }
}
