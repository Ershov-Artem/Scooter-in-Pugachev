import '../api/api.dart';
import '../entities/entities.dart';

class FinalPayRepository {
  FinalPayApiProvider _apiProvider = FinalPayApiProvider();

  Future<FinalPayResponse> finalPay(String _payToken) {
    return _apiProvider.postFinalPayToken(_payToken);
  }
}
