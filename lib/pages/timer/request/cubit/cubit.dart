import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scooter_pugachev/pages/timer/request/entities/entities.dart';
import 'package:scooter_pugachev/pages/timer/request/repository/repository.dart';

class PhotoCubit extends Cubit<PhotoStatus> {
  final PhotoRepository _repository = PhotoRepository();

  PhotoCubit(state) : super(state);

  Future<PhotoResponse> postPhoto(String path) async {
    emit(PhotoStatus.loading);
    PhotoResponse response = await _repository.postPhoto(path);
    print(response.statuscode);
    if (response.statuscode == 200) {
      emit(PhotoStatus.ok);
    } else {
      emit(PhotoStatus.error);
    }
    return response;
  }
}

enum PhotoStatus { loading, ok, initial, error }
