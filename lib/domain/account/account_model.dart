import 'package:code/domain/team/team_model.dart';

class AccountModel {}

class AuthorizeModel {
  AuthorizeUserModel? user;
  String url;
  List<TeamModel> teams;

  AuthorizeModel({this.user, required this.url, this.teams = const []});
}

class AuthorizeUserModel {
  String? id;
  String? email;

  AuthorizeUserModel({this.id, this.email});
}

class LoginModel {
  String email;
  String password;
  LoginOAuthModel? oauth;

  LoginModel({this.email = '', this.password = '', this.oauth});
}

enum OAuthPlatform { google, apple }

class LoginOAuthModel {
  String tokenId;
  String accessToken;
  OAuthPlatform? platform;

  LoginOAuthModel({required this.platform ,this.accessToken = '', this.tokenId = ''});
}

class LoginResponse {
  String? id;
  String? email;

  LoginResponse({this.id, this.email});
}
