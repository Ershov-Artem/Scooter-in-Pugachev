class User {
  final String phone;
  final String name;

  User(this.name, this.phone);
}

class PostUserResponse extends MyResponse {
  String error;
  int statuscode;

  PostUserResponse(this.statuscode) {
    error = "";
  }

  PostUserResponse.withError(this.error, this.statuscode);
}

class MyResponse {
  dynamic body;
  String error;
  int statuscode;

  MyResponse();

  MyResponse.withError(String errorValue);
}
