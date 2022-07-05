import 'package:code/domain/account/account_model.dart';

abstract class IAccountApi {

  Future<AuthorizeModel> authorize();

  Future<LoginResponse> login(LoginModel model);

  Future<bool> forgotPassword(String email, String language);

  Future<bool> logout();

  Future<int> register(String email, String password);

  Future<bool> checkMailExists(String mail);
}
