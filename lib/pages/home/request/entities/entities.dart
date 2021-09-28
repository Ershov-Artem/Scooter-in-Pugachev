class CheckUserResponse {
  String error;
  int statuscode;
  String startedAt;

  CheckUserResponse(this.statuscode, this.startedAt);

  CheckUserResponse.withError(this.error, this.statuscode);

  CheckUserResponse.unLogined() {
    error = "";
    statuscode = 401;
  }
}
