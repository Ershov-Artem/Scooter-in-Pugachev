import 'package:rxdart/rxdart.dart';

class CheckUserResponse {
  String error;
  int statuscode;
  Timestamped startedAt;

  CheckUserResponse(this.statuscode, this.startedAt);

  CheckUserResponse.withError(this.error, this.statuscode);

  CheckUserResponse.unLogined() {
    error = "";
    statuscode = 401;
  }
}
