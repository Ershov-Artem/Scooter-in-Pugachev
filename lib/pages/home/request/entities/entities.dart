class CheckUserResponse {
  String error;
  int statuscode;

  CheckUserResponse(this.statuscode);

  CheckUserResponse.withError(this.error, this.statuscode);

  CheckUserResponse.unLogined() {
    error = "";
    statuscode = 401;
  }
}
