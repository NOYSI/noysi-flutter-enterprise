import 'package:code/data/_shared_prefs.dart';
import 'package:code/domain/account/i_account_repository.dart';
import 'package:code/domain/common_db/i_common_dao.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:rxdart/rxdart.dart';
import 'package:code/utils/extensions.dart';

class OnboardingWelcomeBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC {
  final SharedPreferencesManager _prefs;
  final ICommonDao _iCommonDao;
  final IAccountRepository _iAccountRepository;

  OnboardingWelcomeBloC(this._prefs,
      this._iCommonDao, this._iAccountRepository);

  BehaviorSubject<bool> _logoutController = new BehaviorSubject();

  Stream<bool> get logoutResult => _logoutController.stream;

  BehaviorSubject<String> _userEmailController = new BehaviorSubject();

  Stream<String> get userEmailResult => _userEmailController.stream;

  @override
  void dispose() {
    _userEmailController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  void init() async {
    _userEmailController.sinkAddSafe(await _prefs.getStringValue(_prefs.email));
  }

  void logout() async {
    isLoading = true;
    try {
      _iAccountRepository.logout();
      await _prefs.logout(cleanMail: true);
      await _iCommonDao.cleanDB();
      _logoutController.sinkAddSafe(true);
    } catch (ex) {
      _logoutController.sinkAddSafe(true);
    }
    isLoading = false;
  }
}
