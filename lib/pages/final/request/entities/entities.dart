class FinalPayResponse {
  String error;
  int statuscode;

  FinalPayResponse(this.statuscode);

  FinalPayResponse.withError(this.error, this.statuscode);
}
