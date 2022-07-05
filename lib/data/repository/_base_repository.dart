
import 'dart:io';
import 'package:code/data/api/remote/exceptions.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:dio/dio.dart';

class BaseRepository {
  ResultError<T> resultError<T>(dynamic ex) {
    String message = ex.toString();
    int code = -1;
    if (ex is ServerException) {
      message = ex.message;
      code = ex.statusCode;
    } else if (ex is SocketException) {
      message = "SocketException";
    }else if(ex is DioError && ex.message.contains("404")){
      code = 404;
    }else if(ex is DioError && ex.message.contains("403")){
      code = 403;
    }else if(ex is DioError && ex.message.contains("409")){
      code = 409;
    }
    return Result.error(error: message, code: code);
  }
}
