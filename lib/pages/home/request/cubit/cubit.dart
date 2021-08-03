import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scooter_pugachev/pages/home/request/entities/entities.dart';
import 'package:scooter_pugachev/pages/home/request/repository/repository.dart';

class CheckUserCubit extends Cubit<CheckStatus> {
  final CheckUserRepository _repository = CheckUserRepository();

  CheckUserCubit(state) : super(state);

  Future<CheckUserResponse> checkUser() async {
    emit(CheckStatus.loading);
    CheckUserResponse response = await _repository.checkUser();
    if (response.statuscode == 200) {
      emit(CheckStatus.ok);
    } else if (response.statuscode == 401) {
      emit(CheckStatus.need_login);
    } else {
      emit(CheckStatus.error);
    }
    return response;
  }
}

enum CheckStatus { loading, error, ok, need_login }
