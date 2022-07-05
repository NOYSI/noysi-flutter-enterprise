import 'package:code/_res/R.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/account/account_model.dart';
import 'package:code/domain/account/i_account_repository.dart';
import 'package:code/domain/common_db/i_common_dao.dart';
import 'package:code/domain/team/i_team_repository.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class TeamCreateBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final ITeamRepository _iTeamRepository;
  final IAccountRepository _iAccountRepository;
  final SharedPreferencesManager _prefs;
  final ICommonDao _iCommonDao;
  final InMemoryData inMemoryData;

  TeamCreateBloC(this.inMemoryData, this._iTeamRepository, this._prefs, this._iAccountRepository, this._iCommonDao);

  BehaviorSubject<TeamCreateModel> _teamController = new BehaviorSubject();

  Stream<TeamCreateModel> get teamResult => _teamController.stream;

  BehaviorSubject<TeamModel?> _teamCreateController = new BehaviorSubject();

  Stream<TeamModel?> get teamCreateResult => _teamCreateController.stream;

  BehaviorSubject<int> _pageController = new BehaviorSubject();

  Stream<int> get pageResult => _pageController.stream;

  BehaviorSubject<bool> _checkController = new BehaviorSubject();

  Stream<bool> get checkResult => _checkController.stream;

  BehaviorSubject<List<InvitationsMailModel>> _invitationsController =
      new BehaviorSubject();

  Stream<List<InvitationsMailModel>> get invitationsResult =>
      _invitationsController.stream;

  String userEmail = "";
  int currentPage = 0;
  TeamCreateModel model = TeamCreateModel();
  bool initialState = true;
  TeamModel? teamCreated;
  bool isFromLogin = false;

  void initData({int initPage = 0, fromLogin = false}) async {
    currentPage = initPage;
    isFromLogin = fromLogin;
    isLoading = true;
    model = TeamCreateModel(invitations: []);
    userEmail = await _prefs.getStringValue(_prefs.email);
    model.language = await _prefs.getStringValue(_prefs.language);
    _teamController.sinkAddSafe(model);
    isLoading = false;
  }

  void changePage(int index) {
    currentPage = index;
    _pageController.sinkAddSafe(index);
  }

  void changeCheck(value) {
    model.newsletters = value;
    _checkController.sinkAddSafe(value);
  }

  void removePeople(InvitationsMailModel invitationsModel) {
    model.invitations
        .removeWhere((element) => element.email == invitationsModel.email);
    _invitationsController.sinkAddSafe(model.invitations);
  }

  void addPeople(String email) {
    if (initialState) {
      initialState = false;
    } else {
      final exist = model.invitations.firstWhereOrNull(
          (element) =>
              element.email.trim().toLowerCase() == email.trim().toLowerCase());
      if (exist == null)
        model.invitations.add(
            InvitationsMailModel(email: email, user: email.split("@").first));
    }
    _teamController.sinkAddSafe(model);
  }

  void register(String email, String password) async {
    isLoading = true;
    final res = await _iAccountRepository.register(email, password);
    if (res is ResultSuccess<int>) {
      inMemoryData.cleanData();
      final resAuth = await _iAccountRepository.authorize();
      if(resAuth is ResultSuccess<AuthorizeModel>) {
        await _prefs.setStringValue(_prefs.email, email);
        await _prefs.setBoolValue(_prefs.firstUse, false);
        changePage(currentPage + 1);
      } else {
        showErrorMessage(resAuth);
      }
    } else {
      showErrorMessageFromString(R.string.userInUse);
    }
    isLoading = false;
  }

  void checkTeamName() async {
    isLoading = true;
    final res = await _iTeamRepository.checkTeamNameInUse(Uri.encodeFull(model.name));
    if((res is ResultSuccess<bool> && res.value) || (res is ResultError &&
        (res as ResultError).code == RemoteConstants.code_not_found)) {
      changePage(currentPage + 1);
    } else if (res is ResultError &&
        (res as ResultError).code == RemoteConstants.code_conflict) {
      showErrorMessageFromString(R.string.thisNameAlreadyExist);
    } else {
      showErrorMessage(res);
    }
    isLoading = false;
  }

  void createTeam() async {
    if(model.username.toLowerCase().trim() == RemoteConstants.noysiUsername){
      showErrorMessageFromString(R.string.thisNameAlreadyExist);
    }else{
      isLoading = true;
      final res = await _iTeamRepository.createTeam(model);
      if (res is ResultSuccess<TeamModel>) {
        await _prefs.setStringValue(_prefs.currentTeamId, res.value.id);
        await _prefs.setStringValue(_prefs.currentTeamName, res.value.name);
        await _prefs.setStringValue(_prefs.currentChatId, "");
        teamCreated = res.value;
        _teamCreateController.sinkAddSafe(res.value);
      } else {
        if (res is ResultError &&
            (res as ResultError).code == RemoteConstants.code_conflict) {
          showErrorMessageFromString(R.string.thisNameAlreadyExist);
        } else if (isFromLogin && res is ResultError && (res as ResultError).code == RemoteConstants.code_un_authorized) {
          logout();
          _teamCreateController.sinkAddSafe(null);
        } else
          showErrorMessage(res);
      }
      isLoading = false;
    }
  }

  void logout({bool callApi = false}) async {
    isLoading = true;
    if(callApi) _iAccountRepository.logout();
    await _prefs.logout();
    await _iCommonDao.cleanDB();
    isLoading = false;
  }


  @override
  void dispose() {
    _teamController.close();
    _teamCreateController.close();
    _invitationsController.close();
    _checkController.close();
    _pageController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }
}
