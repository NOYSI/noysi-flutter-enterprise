import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/repository/_base_repository.dart';
import 'package:code/domain/account/account_model.dart';
import 'package:code/domain/account/i_account_api.dart';
import 'package:code/domain/account/i_account_repository.dart';
import 'package:code/fcm/i_fcm_controller.dart';

class AccountRepository extends BaseRepository implements IAccountRepository {
  final IAccountApi _accountApi;
  final SharedPreferencesManager _prefs;
  final IFCMController _fcmController;

  AccountRepository(this._accountApi, this._prefs, this._fcmController);

  @override
  Future<Result<LoginResponse>> login(LoginModel model) async {
    try {
      final res = await _accountApi.login(model);
      await _prefs.setStringValue(_prefs.email, res.email ?? "");
      await _prefs.setStringValue(_prefs.userId, res.id ?? "");
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<int>> register(String email, String password) async {
    try {
      final res = await _accountApi.register(email, password);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<AuthorizeModel>> authorize() async {
    try {
      final res = await _accountApi.authorize();
      await _prefs.setStringValue(_prefs.userId, res.user?.id ?? "");
      await _prefs.setStringValue(_prefs.email, res.user?.email ?? "");
      await _prefs.setStringValue(_prefs.wss, res.url);
      await _fcmController.refreshToken();
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> logout() async {
    try {
      final res = await _accountApi.logout();
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> forgotPassword(String email, String language) async {
    try {
      final res = await _accountApi.forgotPassword(email, language);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }

  @override
  Future<Result<bool>> checkMailExists(String mail) async {
    try {
      final res = await _accountApi.checkMailExists(mail);
      return ResultSuccess(value: res);
    } catch (ex) {
      return resultError(ex);
    }
  }
}
