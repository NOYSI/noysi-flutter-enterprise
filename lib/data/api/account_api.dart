import 'dart:convert';

import 'package:code/data/api/_base_api.dart';
import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/network_handler.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/account/account_model.dart';
import 'package:code/domain/account/i_account_api.dart';
import 'package:code/domain/account/i_account_converter.dart';

class AccountApi extends BaseApi implements IAccountApi {
  final NetworkHandler _networkHandler;
  final IAccountConverter _accountConverter;

  AccountApi(this._networkHandler, this._accountConverter);

  @override
  Future<LoginResponse> login(LoginModel model) async {
    final res = await _networkHandler.login(model);
    if (res.statusCode == RemoteConstants.code_success) {
      LoginResponse model =
          _accountConverter.fromJsonLogin(jsonDecode(res.body));
      return model;
    } else
      throw serverException(res);
  }

  @override
  Future<int> register(String email, String password) async {
    final res = await _networkHandler.register(email, password);
    if (res.statusCode == RemoteConstants.code_success)
      return res.statusCode;
    else
      throw serverException(res);
  }

  @override
  Future<AuthorizeModel> authorize() async {
    final res = await _networkHandler.authorize();
    if (res.statusCode == RemoteConstants.code_success) {
      AuthorizeModel model =
          _accountConverter.fromJsonAuthorize(jsonDecode(res.body));
      return model;
    }
    throw serverException(res);
  }

  @override
  Future<bool> logout() async {
    final res = await _networkHandler.logout();
    if (res.statusCode == RemoteConstants.code_success) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> forgotPassword(String email, String language) async {
    final res = await _networkHandler.forgotPassword(email, language);
    if (res.statusCode == RemoteConstants.code_success_no_content) {
      return true;
    }
    throw serverException(res);
  }

  @override
  Future<bool> checkMailExists(String mail) async {
    final res = await _networkHandler.head(path: "${Endpoint.mailCheck}/$mail");
    if (res.statusCode == RemoteConstants.code_not_found) {
      return true;
    }
    throw serverException(res);
  }
}
