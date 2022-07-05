import 'package:code/data/api/remote/exceptions.dart';
import 'package:http/http.dart';

class BaseApi {
  ServerException serverException(dynamic res) {
    if (res is Response) {
      return ServerException(
          message: res.body.toString(),
          statusCode: res.statusCode);
    } else
      return ServerException(message: "error", statusCode: -1);
  }
}
