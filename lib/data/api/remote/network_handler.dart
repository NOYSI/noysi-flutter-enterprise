import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:code/app.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/account/account_model.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/ui/login/login_page.dart';
import 'package:code/utils/file_manager.dart';
import 'package:code/utils/logger.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:media_scanner_scan_file/media_scanner_scan_file.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../domain/common_db/i_common_dao.dart';

typedef void OnDownloadProgressCallback(int receivedBytes, int totalBytes);
typedef void OnUploadProgressCallback(int sentBytes, int totalBytes);

class NetworkHandler {
  final Logger _logger;
  final ICommonDao _iCommonDao;
  final SharedPreferencesManager _prefs;
  late Dio dio;

  NetworkHandler(this._prefs, this._logger, this._iCommonDao) {
    dio = Dio();
    dio.interceptors.add(QueuedInterceptorsWrapper(onError: (dioError, handler) async {
      if (dioError.response?.statusCode ==
          RemoteConstants.code_un_authorized) {
        final res = await _on401();
        if (res) {
          final retry = _retry(dioError.requestOptions);
          handler.resolve(await retry);
          return;
        }
        onTokenExpired();
        return;
      }
      handler.next(dioError);
    }));
  }

  Future<void> onTokenExpired() async {
    await _prefs.logout();
    await _iCommonDao.cleanDB();
    NoysiApp.navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => LoginPage(
                  tokenExpired: true,
                )),
        (route) => false);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      responseType: ResponseType.json,
    );
    options.headers!['Authorization'] =
        "Bearer ${await _prefs.getStringValue(_prefs.accessToken)}";
    Dio retryDio = new Dio();
    return retryDio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  ///Returns the common headers with authentication values
  // Future<Map<String, String>> _commonHeaders() async {
  //   return {
  //     'Authorization': '${await _prefs.getStringValue(_prefs.accessToken)}',
  //     'Content-Type': 'application/json',
  //   };
  // }

//  Future<http.Response> get({
//    required String path,
//  }) async {
//    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
//    final url =
//        path.startsWith(baseUrl) ? path : "$baseUrl${Endpoint.apiVersion}$path";
//    final tokenHeader = {
//      'Authorization':
//          "Bearer ${await _prefs.getStringValue(_prefs.accessToken)}",
//      "Content-Type": "application/json",
//      "Accept-Encoding": "utf8"
//    };
//    try {
//      _logger.log("-> GET: $url");
//      _logger.log("-> HEADERS: $tokenHeader");
//      final res = await http.get(url, headers: tokenHeader);
//      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
//      _logger.log("<- RESPONSE BODY: ${res.body}");
//      return res;
//    } catch (ex) {
//      _logger.log("<- EXCEPTION: $ex");
//      throw ex;
//    }
//  }

  Future<Response<dynamic>> get(
      {required String path,
      ValueChanged<CancelToken>? onCancelToken,
      bool useApiVersion = true}) async {
    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
    final url = path.startsWith(baseUrl)
        ? path
        : "$baseUrl${useApiVersion ? Endpoint.apiVersion : ""}$path";
    final tokenHeader = {
      'Authorization':
          "Bearer ${await _prefs.getStringValue(_prefs.accessToken)}",
      //"Content-Type": "application/json",
      //"charset": "utf-8"
    };
    try {
      _logger.log("-> GET: $url");
      _logger.log("-> HEADERS: $tokenHeader");

      CancelToken cancelToken = CancelToken();
      if (onCancelToken != null) onCancelToken(cancelToken);
      final res = await dio.get(url,
          cancelToken: cancelToken,
          options: Options(
            responseType: ResponseType.json,
            headers: tokenHeader,
            responseDecoder: (responseBytes, options, data) {
              return utf8
                  .decode(responseBytes, allowMalformed: true)
                  .replaceAll('�', '');
            },
          ));

      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
      _logger.log("<- RESPONSE BODY: ${res.data}");
      return res;
    } catch (ex) {
      _logger.log("<- EXCEPTION: $ex");
      throw ex;
    }
  }

//  Future<http.Response> post({
//    required String path,
//    String body = "",
//  }) async {
//    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
//    final url = "$baseUrl${Endpoint.apiVersion}$path";
//    final tokenHeader = {
//      'Authorization':
//          "Bearer ${await _prefs.getStringValue(_prefs.accessToken)}",
////      "Content-Type": "application/json; charset=utf-8"
//    };
//    try {
//      _logger.log("-> POST: $url");
//      _logger.log("-> HEADERS: $tokenHeader");
//      _logger.log("-> BODY: $body");
//      final res = await http.post(url, headers: tokenHeader, body: body);
//      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
//      _logger.log("<- RESPONSE BODY: ${res.body}");
//      return res;
//    } catch (ex) {
//      _logger.log("<- EXCEPTION: $ex");
//      throw ex;
//    }
//  }

  Future<Response<dynamic>> head(
      {required String path, useVersionInUrl = false}) async {
    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
    final url = useVersionInUrl
        ? "$baseUrl${Endpoint.apiVersion}$path"
        : "$baseUrl$path";
    // Map<String, dynamic> _headers = {};
    // _headers.addAll({
    //   'Authorization':
    //       "Bearer ${await _prefs.getStringValue(_prefs.accessToken)}",
    // });

    try {
      _logger.log("-> HEAD: $url");
      // _logger.log("-> HEADERS: $_headers");
      Dio dioHead = new Dio();
      final res = await dioHead.head(url,
          options: Options(
            responseType: ResponseType.json,
            // headers: _headers,
          ));
      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
      _logger.log("<- RESPONSE BODY: ${res.data}");
      return res;
    } catch (ex) {
      _logger.log("<- EXCEPTION: $ex");
      throw ex;
    }
  }

  Future<Response<dynamic>> post(
      {required String path,
      String body = "",
        CancelToken? cancelToken,
      Map<String, dynamic>? additionHeaders,
      bool useApiVersion = true}) async {
    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
    final url = "$baseUrl${useApiVersion ? Endpoint.apiVersion : ""}$path";
    Map<String, dynamic> _headers = {};
    _headers.addAll({
      'Authorization':
          "Bearer ${await _prefs.getStringValue(_prefs.accessToken)}",
    });
    if (additionHeaders != null) _headers.addAll(additionHeaders);

    try {
      _logger.log("-> POST: $url");
      _logger.log("-> HEADERS: $_headers");
      _logger.log("-> BODY: $body");

      final res = await dio.post(url,
          data: body,
          cancelToken: cancelToken,
          options: Options(
            responseType: ResponseType.json,
            headers: _headers,
          ));
      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
      _logger.log("<- RESPONSE BODY: ${res.data}");
      return res;
    } catch (ex) {
      _logger.log("<- EXCEPTION: $ex");
      throw ex;
    }
  }

//  Future<http.Response> put({
//    required String path,
//    String body,
//  }) async {
//    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
//    final url = "$baseUrl${Endpoint.apiVersion}$path";
//    final tokenHeader = {
//      'Authorization':
//          "Bearer ${await _prefs.getStringValue(_prefs.accessToken)}",
////      "Content-Type": "application/json; charset=utf-8"
//    };
//    try {
//      _logger.log("-> PUT: $url");
//      _logger.log("-> HEADERS: $tokenHeader");
//      _logger.log("-> BODY: $body");
//      final res = await http.put(url, headers: tokenHeader, body: body);
//      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
//      _logger.log("<- RESPONSE BODY: ${res.body}");
//      return res;
//    } catch (ex) {
//      _logger.log("<- EXCEPTION: $ex");
//      throw ex;
//    }
//  }

  Future<Response<dynamic>> put({
    required String path,
    String body = "",
    CancelToken? cancelToken,
  }) async {
    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
    final url = "$baseUrl${Endpoint.apiVersion}$path";
    final tokenHeader = {
      'Authorization':
          "Bearer ${await _prefs.getStringValue(_prefs.accessToken)}",
    };
    try {
      _logger.log("-> PUT: $url");
      _logger.log("-> HEADERS: $tokenHeader");
      _logger.log("-> BODY: $body");
      final res = await dio.put(url,
          cancelToken: cancelToken,
          data: body,
          options: Options(
            responseType: ResponseType.json,
            headers: tokenHeader,
          ));
      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
      _logger.log("<- RESPONSE BODY: ${res.data}");
      return res;
    } catch (ex) {
      _logger.log("<- EXCEPTION: $ex");
      throw ex;
    }
  }

  Future<Response<dynamic>> patch({
    required String path,
    String body = "",
  }) async {
    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
    final url = "$baseUrl${Endpoint.apiVersion}$path";
    final tokenHeader = {
      'Authorization':
      "Bearer ${await _prefs.getStringValue(_prefs.accessToken)}",
    };
    try {
      _logger.log("-> PATCH: $url");
      _logger.log("-> HEADERS: $tokenHeader");
      _logger.log("-> BODY: $body");
      final res = await dio.patch(url,
          data: body,
          options: Options(
            responseType: ResponseType.json,
            headers: tokenHeader,
          ));
      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
      _logger.log("<- RESPONSE BODY: ${res.data}");
      return res;
    } catch (ex) {
      _logger.log("<- EXCEPTION: $ex");
      throw ex;
    }
  }

//  Future<http.Response> delete({
//    required String path,
//  }) async {
//    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
//    final url = "$baseUrl${Endpoint.apiVersion}$path";
//    final tokenHeader = {
//      'Authorization':
//      "Bearer ${await _prefs.getStringValue(_prefs.accessToken)}",
////      "Content-Type": "application/json; charset=utf-8"
//    };
//    try {
//      _logger.log("-> DELETE: $url");
//      _logger.log("-> HEADERS: $tokenHeader");
//      final res = await http.delete(url, headers: tokenHeader);
//      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
//      _logger.log("<- RESPONSE BODY: ${res.body}");
//      return res;
//    } catch (ex) {
//      _logger.log("<- EXCEPTION: $ex");
//      throw ex;
//    }
//  }

  Future<Response<dynamic>> delete(
      {required String path, String body = ""}) async {
    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
    final url = "$baseUrl${Endpoint.apiVersion}$path";
    final tokenHeader = {
      'Authorization':
          "Bearer ${await _prefs.getStringValue(_prefs.accessToken)}",
//      "Content-Type": "application/json; charset=utf-8"
    };
    try {
      _logger.log("-> DELETE: $url");
      _logger.log("-> HEADERS: $tokenHeader");
      _logger.log("-> BODY: $body");

      final res = await dio.delete(url,
          data: body,
          options: Options(
            responseType: ResponseType.json,
            headers: tokenHeader,
          ));
      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
      _logger.log("<- RESPONSE BODY: ${res.data}");
      return res;
    } catch (ex) {
      _logger.log("<- EXCEPTION: $ex");
      throw ex;
    }
  }

  Future<bool> _on401() async {
    try {
      final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
      final url = "$baseUrl/identity/refresh/token";
      final refreshToken = await _prefs.getStringValue(_prefs.refreshToken);
      _logger.log("-> POST: $url");
      _logger.log("-> BODY: {refreshToken: $refreshToken}");
      var res = await http.post(Uri.parse(url),
          body: jsonEncode({"refreshToken": refreshToken}));
      _logger.log("<- RESPONSE CODE (Refresh Token): ${res.statusCode}");
      _logger.log("<- RESPONSE BODY (Refresh Token): ${res.body}");
      if (res.statusCode == RemoteConstants.code_success) {
        final accessToken = res.headers["x-subject-token"];
        await _prefs.setStringValue(_prefs.accessToken, accessToken!);
        // var resAuth = await authorize();
        // if (resAuth.statusCode == RemoteConstants.code_success) {
        //   Map<String, dynamic> jsonAuth = jsonDecode(resAuth.body);
        //   await _prefs.setStringValue(_prefs.wss, jsonAuth["url"]);
        //   return true;
        // }
        return true;
      }
      return false;
    } catch (ex) {
      return false;
    }
  }

  Future<http.Response> authorize() async {
    try {
      final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
      final url = "$baseUrl${Endpoint.apiVersion}${Endpoint.authorize}";
      final token = await _prefs.getStringValue(_prefs.accessToken);
      final header = {"Authorization": "Bearer $token"};
      _logger.log("-> PUT: $url");
      _logger.log("-> HEADERS: $header");
      var res = await http.put(Uri.parse(url), headers: header);
      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
      _logger.log("<- RESPONSE BODY: ${res.body}");
      return res;
    } catch (ex) {
      throw ex;
    }
  }

  Future<http.Response> login(LoginModel model) async {
    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
    final url = model.oauth != null
        ? "$baseUrl${model.oauth!.platform == OAuthPlatform.google ? Endpoint.googleSignIn : Endpoint.appleSignIn}"
        : "$baseUrl${Endpoint.login}";
    try {
      PackageInfo pkgInfo = await PackageInfo.fromPlatform();
      AndroidDeviceInfo? androidInfo;
      IosDeviceInfo? iosInfo;
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid)
        androidInfo = await deviceInfo.androidInfo;
      else
        iosInfo = await deviceInfo.iosInfo;

      final appVersion = pkgInfo.version;
      final os = Platform.isIOS ? (iosInfo!.systemName ?? "iOS") : "Android";
      final deviceId =
          Platform.isIOS ? iosInfo!.identifierForVendor : androidInfo?.androidId;
      final systemVersion =
          Platform.isIOS ? iosInfo!.systemVersion : androidInfo?.version.baseOS;
      final mobileModel =
          Platform.isIOS ? iosInfo!.utsname.machine : androidInfo?.model;
      final manufacturer = Platform.isIOS ? "Apple" : androidInfo?.manufacturer;
      final type = Platform.isIOS ? "ios" : "android";

      Map<String, String> headers = {
        "x-deviceid": deviceId ?? "",
        "x-os": os,
        "x-appversion": appVersion,
        "x-version": systemVersion ?? "",
        "x-model": mobileModel ?? "",
        "x-name": manufacturer ?? "",
        "x-type": type,
        "x-app-project": ""
      };
      final body = model.oauth != null
          ? jsonEncode({
              "${model.oauth!.platform == OAuthPlatform.google ? "verify" : "idToken"}":
                  model.oauth!.tokenId
              //"access": model.oauth.accessToken
            })
          : jsonEncode({"email": model.email, "password": model.password});
      _logger.log("-> POST: $url");
      _logger.log("-> HEADERS: $headers");
      _logger.log("-> BODY: $body");
      var res = await http.post(Uri.parse(url), body: body, headers: headers);
      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
      _logger.log("<- RESPONSE BODY: ${res.body}");

      if (res.statusCode == RemoteConstants.code_success) {
        final accessToken = res.headers["x-subject-token"];
        Map<String, dynamic> jsonResponse = jsonDecode(res.body);
        final refreshToken = jsonResponse.containsKey(_prefs.refreshToken)
            ? jsonResponse[_prefs.refreshToken]
            : "";
        await _prefs.setStringValue(_prefs.refreshToken, refreshToken);
        await _prefs.setStringValue(_prefs.accessToken, accessToken!);
      }

      return res;
    } catch (ex) {
      throw ex;
    }
  }

  Future<http.Response> logout() async {
    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
    final url = "$baseUrl${Endpoint.logout}";
    final token = await _prefs.getStringValue(_prefs.accessToken);
    final header = {"Authorization": "Bearer $token"};
    try {
      _logger.log("-> POST: $url");
      _logger.log("-> HEADERS: $header");
      var res = await http.post(Uri.parse(url), headers: header);
      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
      _logger.log("<- RESPONSE BODY: ${res.body}");

      return res;
    } catch (ex) {
      throw ex;
    }
  }

  Future<http.Response> forgotPassword(String email, String language) async {
    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
    final url = "$baseUrl${Endpoint.recoverPassword}";
    try {
      final body = jsonEncode({"email": email, "language": language});
      _logger.log("-> POST: $url");
      _logger.log("-> BODY: $body");
      var res = await http.post(Uri.parse(url), body: body);
      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
      _logger.log("<- RESPONSE BODY: ${res.body}");

      return res;
    } catch (ex) {
      throw ex;
    }
  }

  Future<http.Response> register(String email, String password) async {
    final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
    final url = "$baseUrl${Endpoint.register}";
    final language = await _prefs.getStringValue(_prefs.language);
    // final termsAccepted =
    //     await _prefs.getBoolValue(_prefs.termsAccepted, defValue: true);
    try {
      PackageInfo pkgInfo = await PackageInfo.fromPlatform();
      AndroidDeviceInfo? androidInfo;
      IosDeviceInfo? iosInfo;
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid)
        androidInfo = await deviceInfo.androidInfo;
      else
        iosInfo = await deviceInfo.iosInfo;

      final appVersion = pkgInfo.version;
      final os = Platform.isIOS ? (iosInfo!.systemName ?? "iOS") : "Android";
      final deviceId =
          Platform.isIOS ? iosInfo!.identifierForVendor : androidInfo?.androidId;
      final systemVersion =
          Platform.isIOS ? iosInfo!.systemVersion : androidInfo!.version.baseOS;
      final mobileModel =
          Platform.isIOS ? iosInfo!.utsname.machine : androidInfo?.model;
      final manufacturer = Platform.isIOS ? "Apple" : androidInfo?.manufacturer;
      final type = Platform.isIOS ? "ios" : "android";

      Map<String, String> headers = {
        "x-deviceid": deviceId ?? "",
        "x-os": os,
        "x-appversion": appVersion,
        "x-version": systemVersion ?? "",
        "x-model": mobileModel ?? "",
        "x-name": manufacturer ?? "",
        "x-type": type,
        "x-app-project": ""
      };

      final body = jsonEncode({
        "email": email,
        "password": password,
        "language": language,
        "terms_accepted": true
      });
      _logger.log("-> POST: $url");
      _logger.log("-> HEADERS: $headers");
      _logger.log("-> BODY: $body");
      var res = await http.post(Uri.parse(url), body: body, headers: headers);
      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
      _logger.log("<- RESPONSE BODY: ${res.body}");

      final accessToken = res.headers["x-subject-token"];
      Map<String, dynamic> jsonResponse = jsonDecode(res.body);
      final refreshToken = jsonResponse.containsKey(_prefs.refreshToken)
          ? jsonResponse[_prefs.refreshToken]
          : "";
      await _prefs.setStringValue(_prefs.refreshToken, refreshToken);
      await _prefs.setStringValue(_prefs.accessToken, accessToken!);

      return res;
    } catch (ex) {
      throw ex;
    }
  }

  Future<Response<dynamic>> postFile(
      {required String path,
      required File file,
      required FileCreateModel fileCreateModel,
      ProgressCallback? onReceiveProgress,
      ProgressCallback? onSendProgress,
      CancelToken? cancelToken,
      String method = 'put',
      bool useTokenAuthorization = false}) async {
    final _headers = {
      "Content-Type": "${fileCreateModel.mime}",
      "Content-Length": fileCreateModel.size,
    };
    if (useTokenAuthorization)
      _headers.addAll({
        'Authorization':
            "Bearer ${await _prefs.getStringValue(_prefs.accessToken)}",
      });
    // else
    //   _headers.addAll({"Authorization": "Bearer"});

    try {
      _logger.log("-> HEADERS: $_headers");
      _logger.log("-> PATH: ${method.toUpperCase()}: $path");

//      FormData formData = FormData.fromMap({
//        "file": await MultipartFile.fromFile(file.path,
//            filename: file.path.split("/").last)
//      });
      final fileStr = file.openRead();
      Dio dioPostFile = new Dio();
      if (useTokenAuthorization) {
        dioPostFile.interceptors
            .add(QueuedInterceptorsWrapper(onError: (dioError, handler) async {
          if (dioError.response?.statusCode ==
              RemoteConstants.code_un_authorized) {
            final res = await _on401();
            if (res) {
              final retry = _retry(dioError.requestOptions);
              handler.resolve(await retry);
              return;
            }
            onTokenExpired();
            return;
          }
          handler.next(dioError);
        }));
      }
      if (method == 'put') {
        final res = await dioPostFile.put(path,
            cancelToken: cancelToken,
            data: fileStr,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
            options: Options(
              responseType: ResponseType.json,
              headers: _headers,
            ));
        _logger.log("<- RESPONSE CODE: ${res.statusCode}");
        _logger.log("<- RESPONSE BODY: ${res.toString()}");
        return res;
      } else {
        final res = await dioPostFile.post(path,
            cancelToken: cancelToken,
            data: fileStr,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
            options: Options(
              responseType: ResponseType.json,
              headers: _headers,
            ));

        _logger.log("<- RESPONSE CODE: ${res.statusCode}");
        _logger.log("<- RESPONSE BODY: ${res.toString()}");
        return res;
      }
    } catch (ex) {
      _logger.log("<- EXCEPTION: $ex");
      throw ex;
    }
  }

  Future<File?> downloadFile(
      String url, String fileName, String mimeType) async {
    try {
      fileName.replaceAll('/', '-');
      final isAndroid = Platform.isAndroid;
      String rootFile = await FileManager.getDownloadPath() ?? await FileManager.getRootFilesDirPath();

      if (mimeType.startsWith('image') && isAndroid) {
        rootFile = await FileManager.getImageDirAndroid() ?? await FileManager.getRootFilesDirPath();
      } else if (mimeType.startsWith('video') && isAndroid) {
        rootFile = await FileManager.getVideoDirAndroid() ?? await FileManager.getRootFilesDirPath();
      }

      final f = File("$rootFile/$fileName");
      if (f.existsSync()) {
        return f;
      }
      Dio dioDownload = new Dio();
      final res = await dioDownload.download(url, f.path);

      _logger.log("<- RESPONSE CODE: ${res.statusCode}");
      _logger.log("<- RESPONSE BODY: ${res.toString()}");

      if (res.statusCode == RemoteConstants.code_success) {
        if (isAndroid) {
          MediaScannerScanFile.scanFile(f.path);
        } else if (mimeType.startsWith('image')) {
          await ImageGallerySaver.saveImage(f.readAsBytesSync(), quality: 100);
        } else if (mimeType.startsWith('video')) {
          await ImageGallerySaver.saveFile(f.path);
        }
        return f;
      }
      return null;
    } catch (ex) {
      _logger.log("<- EXCEPTION: $ex");
      throw ex;
    }
  }

  // Future<Response<dynamic>> attachFile({
  //   required String path,
  //   String body,
  //   required File file,
  //   String method,
  //   ProgressCallback onSendProgress,
  //   ProgressCallback onReceiveProgress,
  // }) async {
  //   try {
  //     final baseUrl = await _prefs.getStringValue(_prefs.baseUrl);
  //     final url = "$baseUrl${Endpoint.apiVersion}$path";
  //     final tokenHeader = {
  //       'Authorization':
  //           "Bearer ${await _prefs.getStringValue(_prefs.accessToken)}",
  //     };
  //
  //     _logger.log("-> HEADERS: $tokenHeader");
  //
  //     FormData formData = FormData.fromMap({
  //       "file": await MultipartFile.fromFile(file.path,
  //           filename: file.path.split("/").last)
  //     });
  //     Dio dio = new Dio();
  //
  //     final res = method == "put"
  //         ? await dio.put(url,
  //             data: formData,
  //             onReceiveProgress: onReceiveProgress,
  //             onSendProgress: onSendProgress,
  //             options: Options(
  //               responseType: ResponseType.json,
  //               headers: tokenHeader,
  //             ))
  //         : await dio.post(url,
  //             data: formData,
  //             onReceiveProgress: onReceiveProgress,
  //             onSendProgress: onSendProgress,
  //             options: Options(
  //               responseType: ResponseType.json,
  //               headers: tokenHeader,
  //             ));
  //
  //     _logger.log("<- RESPONSE CODE: ${res.statusCode}");
  //     _logger.log("<- RESPONSE BODY: ${res.toString()}");
  //     return res;
  //   } catch (ex) {
  //     _logger.log("<- EXCEPTION: $ex");
  //     throw ex;
  //   }
  // }
}
