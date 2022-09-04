

import '../../enums.dart';
import 'authenticated_entity_model.dart';

abstract class I2faApi {

  Future<AuthenticatedEntity> createApp(String issuer, String label, String secret, OTPType type);

  Future<List<AuthenticatedEntity>> getApps();

  Future<AuthenticatedEntity> getApp(String appId);

  Future<bool> updateApp(AuthenticatedEntity model);

  Future<bool> deleteApp(String appId);

  Future<bool> deleteAllApps();

}