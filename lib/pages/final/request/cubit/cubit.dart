import 'package:flutter_bloc/flutter_bloc.dart';
import '../entities/entities.dart';
import '../repository/repository.dart';

class FinalPayBloc extends Cubit<FinalPayStatus> {
  final FinalPayRepository _repository = FinalPayRepository();

  FinalPayBloc(state) : super(state);

  postFinalPayToken(String _payToken) async {
    print("kjkj");
    emit(FinalPayStatus.loading);
    FinalPayResponse response = await _repository.finalPay(_payToken);
    print("statuscode: ${response.statuscode}  error:  ${response.error}");
    if (response.statuscode == 200) {
      emit(FinalPayStatus.ok);
    } else {
      print(response.error);
      emit(FinalPayStatus.error);
    }
    return response;
  }
}

enum FinalPayStatus { loading, error, ok, initial }
