import 'package:code/_res/R.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/account/i_account_repository.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/utils/extensions.dart';
import 'package:rxdart/subjects.dart';

class RegisterBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final IAccountRepository _iAccountRepository;
  final SharedPreferencesManager _prefs;

  RegisterBloC(this._iAccountRepository, this._prefs);

  BehaviorSubject<bool> _registerController = new BehaviorSubject();

  Stream<bool> get registerResult => _registerController.stream;

  String? registeredMail = '';

  // void register(String email, String password) async {
  //   isLoading = true;
  //   final res = await _iAccountRepository.register(email, password);
  //   if (res is ResultSuccess<int>) {
  //     await _prefs.setStringValue(_prefs.email, email);
  //     registerSuccess = true;
  //     _registerController.sinkAddSafe(true);
  //   } else {
  //     showErrorMessageFromString(R.string.userInUse);
  //   }
  //   isLoading = false;
  // }

  void checkMail(String mail) async {
    isLoading = true;
    final res = await _iAccountRepository.checkMailExists(mail);
    if((res is ResultSuccess<bool> && res.value) || (res is ResultError &&
        (res as ResultError).code == RemoteConstants.code_not_found)) {
      await _prefs.setStringValue(_prefs.email, mail);
      registeredMail = mail;
      _registerController.sinkAddSafe(true);
    } else if (res is ResultError &&
        (res as ResultError).code == RemoteConstants.code_conflict) {
      showErrorMessageFromString(R.string.userInUse);
    } else {
      showErrorMessage(res);
    }
    isLoading = false;
  }

  @override
  void dispose() {
    _registerController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }
}
