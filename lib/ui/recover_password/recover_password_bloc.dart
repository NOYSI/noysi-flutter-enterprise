import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/account/i_account_repository.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:rxdart/rxdart.dart';
import 'package:code/utils/extensions.dart';

class RecoverPasswordBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final IAccountRepository _accountRepository;
  final SharedPreferencesManager _prefs;

  RecoverPasswordBloC(this._accountRepository, this._prefs);

  BehaviorSubject<bool> _recoverController = new BehaviorSubject();

  Stream<bool> get recoverResult => _recoverController.stream;

  bool recovered = false;

  @override
  void dispose() {
    _recoverController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  void recoverPassword(String email) async {
    isLoading = true;
    final language = await _prefs.getStringValue(_prefs.language);
    final res = await _accountRepository.forgotPassword(email, language);
    if (res is ResultSuccess<bool>) {
      recovered = true;
      _recoverController.sinkAddSafe(true);
    } else
      showErrorMessage(res);
    isLoading = false;
  }
}
