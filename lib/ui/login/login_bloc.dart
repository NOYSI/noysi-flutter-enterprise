import 'package:code/_res/R.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/account/account_model.dart';
import 'package:code/domain/account/i_account_repository.dart';
import 'package:code/domain/common_db/i_common_dao.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final IAccountRepository _iAccountRepository;
  final SharedPreferencesManager _prefs;
  final InMemoryData inMemoryData;
  final ICommonDao _iCommonDao;

  LoginBloC(this._iAccountRepository, this._prefs, this.inMemoryData, this._iCommonDao);

  BehaviorSubject<int> _loginController = new BehaviorSubject();

  Stream<int> get loginResult => _loginController.stream;

  BehaviorSubject<LoginModel?> _initLoginController = new BehaviorSubject();

  Stream<LoginModel?> get initLoginResult => _initLoginController.stream;

  BehaviorSubject<int> _navController = new BehaviorSubject();

  Stream<int> get navResult => _navController.stream;

  @override
  void dispose() {
    _initLoginController.close();
    _loginController.close();
    _navController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  void init({bool isTokenExpired = false}) async {
    if (isTokenExpired) _iCommonDao.cleanDB();
    final email = await _prefs.getStringValue(_prefs.email);
    googleSignIn = GoogleSignIn(
        scopes: [
          "openid",
          "profile",
          "email"
        ]);
    _initLoginController.sinkAddSafe(LoginModel(email: email, password: ""));
  }

  void loginWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
        isLoading = true;
        final res = await _iAccountRepository.login(LoginModel(
            oauth: LoginOAuthModel(
                platform: OAuthPlatform.apple,
                accessToken: credential.authorizationCode,
                tokenId: credential.identityToken!)));
        if (res is ResultSuccess<LoginResponse>) {
          ///Cleaning in-memory data
          inMemoryData.cleanData();
          await _registerTeam();
        } else {
          if (res is ResultError &&
              (res as ResultError).code == RemoteConstants.code_not_found) {
            showErrorMessageFromString(R.string.wrongUsernamePassword);
          } else {
            showErrorMessage(res);
          }
        }
        isLoading = false;
    } catch (ex) {
      print(ex.toString());
    }
  }

  GoogleSignIn? googleSignIn;

  void loginWithGoogle() async {
    final googleSignedIn = await googleSignIn?.signIn();
    final googleSignedInAuth = await googleSignedIn?.authentication;
    if (googleSignedInAuth != null) {
      isLoading = true;
      final res = await _iAccountRepository.login(LoginModel(
          oauth: LoginOAuthModel(
              platform: OAuthPlatform.google,
              accessToken: googleSignedInAuth.accessToken!,
              tokenId: googleSignedInAuth.idToken!)));
      if (res is ResultSuccess<LoginResponse>) {
        ///Cleaning in-memory data
        inMemoryData.cleanData();
        await _registerTeam();
      } else {
        if (res is ResultError &&
            (res as ResultError).code == RemoteConstants.code_not_found) {
          showErrorMessageFromString(R.string.wrongUsernamePassword);
        } else {
          showErrorMessage(res);
        }
      }
      googleSignIn!.signOut();
      isLoading = false;
    }
  }

  void login(String email, String password) async {
    isLoading = true;
    // final resToken = await _ifcmFeature.refreshToken();
    final res = await _iAccountRepository
        .login(LoginModel(email: email, password: password));
    if (res is ResultSuccess<LoginResponse>) {
      ///Cleaning in-memory data
      inMemoryData.cleanData();
      await _registerTeam();
    } else {
      if (res is ResultError &&
          (res as ResultError).code == RemoteConstants.code_not_found) {
        showErrorMessageFromString(R.string.wrongUsernamePassword);
      } else {
        showErrorMessage(res);
      }
    }
    isLoading = false;
  }

  Future<void> _registerTeam() async {
    final res = await _iAccountRepository.authorize();
    if (res is ResultSuccess<AuthorizeModel>) {
      await _prefs.setBoolValue(_prefs.firstUse, false);

      if (res.value.teams.isNotEmpty) {
        await _prefs.setStringValue(
            _prefs.currentTeamId, res.value.teams[0].id);
        await _prefs.setStringValue(
            _prefs.currentTeamName, res.value.teams[0].name);

        ///Navigate to home
        _navController.sinkAddSafe(0);
      } else {
        ///Navigate to Create Team
        _navController.sinkAddSafe(1);
      }
    } else {
      showErrorMessage(res);
    }
  }
}
