import 'package:code/_di/injector.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/account/account_model.dart';
import 'package:code/domain/account/i_account_repository.dart';
import 'package:code/enums.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class SplashBloC extends BaseBloC with ErrorHandlerBloC {
  final IAccountRepository _iAccountRepository;
  final SharedPreferencesManager _prefs;

  SplashBloC(this._iAccountRepository, this._prefs);

  BehaviorSubject<int> _initController = new BehaviorSubject();

  Stream<int> get initResult => _initController.stream;

  BehaviorSubject<String> _appVersionController = new BehaviorSubject();

  Stream<String> get appVersionResult => _appVersionController.stream;

  void init() async {

    if (Injector.instance.env == Environment.DEV) {
      String currentUrl = await _prefs.getStringValue(_prefs.baseUrl);
      if(currentUrl != Endpoint.apiBaseUrlDev){
        await _prefs.init();
        await _prefs.setStringValue(_prefs.baseUrl, Endpoint.apiBaseUrlDev);
      }
    } else {
      String currentUrl = await _prefs.getStringValue(_prefs.baseUrl);
      if(currentUrl != Endpoint.apiBaseUrlProd){
        await _prefs.init();
        await _prefs.setStringValue(_prefs.baseUrl, Endpoint.apiBaseUrlProd);
      }
    }

    String currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final res = await _iAccountRepository.authorize();
    if (res is ResultSuccess<AuthorizeModel>) {
      if (res.value.teams.isEmpty) {
        _initController.sinkAddSafe(2);
      } else {
        if (currentTeamId.isEmpty) {
          await _prefs.setStringValue(
              _prefs.currentTeamId, res.value.teams[0].id);
        }
        _initController.sinkAddSafe(1);
      }
    } else {
      _initController.sinkAddSafe(0);
    }
  }

  void loadVersion()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
//    String appName = packageInfo.appName;
//    String packageName = packageInfo.packageName;
    String version = packageInfo.version;

    _appVersionController.sinkAddSafe("Noysi App $version");
  }

  @override
  void dispose() {
    _initController.close();
    disposeErrorHandlerBloC();
  }
}
