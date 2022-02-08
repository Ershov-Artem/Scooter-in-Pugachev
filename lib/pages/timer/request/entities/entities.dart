class PhotoResponse {
  int statuscode;
  String error;
  dynamic data;

  PhotoResponse(this.statuscode, this.data);

  PhotoResponse.withError(this.error, this.statuscode);
}
