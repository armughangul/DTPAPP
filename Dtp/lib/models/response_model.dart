class ViewResponse {
  bool status;
  String message;
  String? statusCode;
  dynamic data;

  ViewResponse({
    this.status = false,
    this.message = "",
    this.data,
    this.statusCode = "400",
  });

  ViewResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'] ?? "",
        message = json['message'] ?? "",
        data = json['data'] ?? null;
}
