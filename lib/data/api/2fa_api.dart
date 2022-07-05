import 'dart:convert';

import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/network_handler.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/2fa/i_2fa_api.dart';
import 'package:code/domain/2fa/i_2fa_converter.dart';
import '../../domain/2fa/authenticated_entity_model.dart';
import '../../enums.dart';
import '_base_api.dart';

class TwoFaApi extends BaseApi implements I2faApi {
  final NetworkHandler _networkHandler;
  final I2faConverter _i2faConverter;

  TwoFaApi(this._networkHandler, this._i2faConverter);

  @override
  Future<bool> deleteAllApps() async {
    final res = await _networkHandler.delete(path: Endpoint.two_fa);
    if (res.statusCode == RemoteConstants.code_success_no_content) return true;
    throw serverException(res);
  }

  @override
  Future<bool> deleteApp(String appId) async {
    final res = await _networkHandler.delete(path: "${Endpoint.two_fa}/$appId");
    if (res.statusCode == RemoteConstants.code_success_no_content) return true;
    throw serverException(res);
  }

  @override
  Future<AuthenticatedEntity> getApp(String appId) async {
    final res = await _networkHandler.get(path: "${Endpoint.two_fa}/$appId");
    if (res.statusCode == RemoteConstants.code_success)
      return _i2faConverter.fromJson(res.data);
    throw serverException(res);
  }

  @override
  Future<List<AuthenticatedEntity>> getApps() async {
    final res = await _networkHandler.get(path: "${Endpoint.two_fa}");
    if (res.statusCode == RemoteConstants.code_success) {
      try {
        return (res.data["list"] as List<dynamic>)
            .map((e) => _i2faConverter.fromJson(e))
            .toList();
      } catch (ex) {
        print(ex);
      }
    }
    throw serverException(res);
  }

  @override
  Future<bool> updateApp(AuthenticatedEntity model) async {
    final res = await _networkHandler.put(
        path: "${Endpoint.two_fa}/${model.id}",
        body: json.encode(_i2faConverter.toJson(model)));
    if (res.statusCode == RemoteConstants.code_success) return true;
    throw serverException(res);
  }

  @override
  Future<AuthenticatedEntity> createApp(
      String issuer, String label, String secret, OTPType type) async {
    final res = await _networkHandler.post(
        path: "${Endpoint.two_fa}",
        body: json.encode({
          "type": type.name,
          "issuer": issuer,
          "label": label,
          "secret": secret
        }));
    if (res.statusCode == RemoteConstants.code_success_created)
      return _i2faConverter.fromJson(res.data);
    throw serverException(res);
  }
}
