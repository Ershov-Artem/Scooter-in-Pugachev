import 'package:flutter_bloc/flutter_bloc.dart';

import '../entities/entities.dart';
import '../repository/repository.dart';

import 'package:rxdart/rxdart.dart';

class PostUserBloc extends Cubit<UserStatus> {
  final UserRepository _repository = UserRepository();
  final BehaviorSubject<MyResponse> _subject = BehaviorSubject<MyResponse>();

  PostUserBloc(state) : super(state);

  regUser(_phone, _name) async {
    emit(UserStatus.loading);
    PostUserResponse response = await _repository.regUser(_phone, _name);
    if (response.statuscode == 200)
      emit(UserStatus.ok);
    else {
      print(response.body);
      emit(UserStatus.error);
    }
    _subject.sink.add(response);
  }

  confUser(_confirmCode) async {
    emit(UserStatus.loading);
    ConfirmCodeResponse response = await _repository.confUser(_confirmCode);
    if (response.statuscode == 200)
      emit(UserStatus.ok);
    else {
      print(response.body);
      emit(UserStatus.error);
    }
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }
}

enum UserStatus { loading, error, ok, initial }
