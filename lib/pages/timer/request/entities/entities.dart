class PhotoResponse {
  int statuscode;
  String error;

  PhotoResponse(this.statuscode);

  PhotoResponse.withError(this.error, this.statuscode);
}
