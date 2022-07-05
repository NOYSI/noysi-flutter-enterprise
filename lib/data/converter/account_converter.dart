import 'package:code/domain/account/account_model.dart';
import 'package:code/domain/account/i_account_converter.dart';
import 'package:code/domain/team/i_team_converter.dart';

class AccountConverter implements IAccountConverter {
  final ITeamConverter _iTeamConverter;

  AccountConverter(this._iTeamConverter);

  @override
  AuthorizeModel fromJsonAuthorize(Map<String, dynamic> json) {
    final AuthorizeModel model = AuthorizeModel(
        url: json["url"],
        user: fromJsonAuthorizeUser(json["user"]),
        teams: (json["teams"] as List<dynamic>)
            .map((e) => _iTeamConverter.fromJson(e))
            .toList());
    return model;
  }

  @override
  AuthorizeUserModel fromJsonAuthorizeUser(Map<String, dynamic> json) {
    final AuthorizeUserModel model =
        AuthorizeUserModel(id: json["id"], email: json["email"]);
    return model;
  }

  @override
  LoginResponse fromJsonLogin(Map<String, dynamic> json) {
    final LoginResponse model = LoginResponse(
      id: json["id"],
      email: json["email"]
    );
    return model;
  }
}
