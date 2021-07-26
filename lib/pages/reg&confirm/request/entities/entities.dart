class PostUserResponse extends MyResponse {
  String error;
  int statuscode;

  PostUserResponse(this.statuscode) {
    error = "";
  }

  PostUserResponse.withError(this.error, this.statuscode);
}

class ConfirmCodeResponse extends MyResponse {
  String error;
  int statuscode;
  final String token;

  ConfirmCodeResponse(this.token, this.statuscode);

  ConfirmCodeResponse.withError(this.error, this.statuscode) : token = "";
}

class MyResponse {
  dynamic body;
  String error;
  int statuscode;

  MyResponse();

  MyResponse.withError(String errorValue);
}
