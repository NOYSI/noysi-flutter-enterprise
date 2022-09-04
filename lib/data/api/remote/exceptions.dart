class ServerException implements Exception {
  late String message;
  late int statusCode;

  ServerException({required this.message, required this.statusCode});

  ServerException.fromJson(Map<String, dynamic> json) {
    this.statusCode = json["statusCode"];
    this.message = json["message"];
  }
}
