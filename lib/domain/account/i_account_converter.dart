import 'package:code/domain/account/account_model.dart';

abstract class IAccountConverter {
  AuthorizeModel fromJsonAuthorize(Map<String, dynamic> json);

  LoginResponse fromJsonLogin(Map<String, dynamic> json);

  AuthorizeUserModel fromJsonAuthorizeUser(Map<String, dynamic> json);
}
