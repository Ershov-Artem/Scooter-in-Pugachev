class PayResponse {
  String error;
  int statuscode;

  PayResponse(this.statuscode);

  PayResponse.withError(this.error, this.statuscode);
}
