import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/account/account_model.dart';

abstract class IAccountRepository {
  Future<Result<AuthorizeModel>> authorize();

  Future<Result<LoginResponse>> login(LoginModel model);

  Future<Result<bool>> forgotPassword(String email, String language);

  Future<Result<bool>> logout();

  Future<Result<int>> register(String email, String password);

  Future<Result<bool>> checkMailExists(String mail);
}
