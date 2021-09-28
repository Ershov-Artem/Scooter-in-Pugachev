import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scooter_pugachev/pages/pay/request/entities/entities.dart';
import '../repository/repository.dart';

class PayBloc extends Cubit<PayStatus> {
  final PayRepository _repository = PayRepository();

  PayBloc(state) : super(state);

  postPayToken(_payToken, _scootID) async {
    print("kjkj");
    emit(PayStatus.loading);
    PayResponse response = await _repository.postPayToken(_payToken, _scootID);
    print("statuscode: ${response.statuscode}  error:  ${response.error}");
    if (response.statuscode == 200) {
      emit(PayStatus.ok);
    } else {
      print(response.error);
      emit(PayStatus.error);
    }
    return response;
  }
}

enum PayStatus { loading, error, ok, initial }
