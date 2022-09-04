import 'package:code/data/api/remote/result.dart';
import 'package:code/data/repository/_base_repository.dart';
import 'package:code/domain/2fa/authenticated_entity_model.dart';
import 'package:code/domain/2fa/i_2fa_api.dart';
import 'package:code/domain/2fa/i_2fa_repository.dart';

import '../../enums.dart';

class TwoFaRepository extends BaseRepository implements I2faRepository {
  final I2faApi _i2faApi;

  TwoFaRepository(this._i2faApi);

  @override
  Future<Result<bool>> deleteAllApps() async {
    try {
      final res = await _i2faApi.deleteAllApps();
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> deleteApp(String appId) async {
    try {
      final res = await _i2faApi.deleteApp(appId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<AuthenticatedEntity>> getApp(String appId) async {
    try {
      final res = await _i2faApi.getApp(appId);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<List<AuthenticatedEntity>>> getApps() async {
    try {
      final res = await _i2faApi.getApps();
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> updateApp(AuthenticatedEntity model) async {
    try {
      final res = await _i2faApi.updateApp(model);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<AuthenticatedEntity>> createApp(
      String issuer, String label, String secret, OTPType type) async {
    try {
      final res = await _i2faApi.createApp(issuer, label, secret, type);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }
}
