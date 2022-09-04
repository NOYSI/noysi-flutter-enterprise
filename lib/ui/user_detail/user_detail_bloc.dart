import 'dart:convert';
import 'package:code/_di/injector.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
import 'package:code/domain/single_selection_model.dart';
import 'package:code/domain/usage/usage_model.dart';
import 'package:code/domain/user/i_user_repository.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

import '../../enums.dart';

class UserDetailBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final IUserRepository _iUserRepository;
  final IChannelRepository _iChannelRepository;
  final SharedPreferencesManager _prefs;

  UserDetailBloC(this._iUserRepository, this._iChannelRepository, this._prefs);

  @override
  void dispose() {
    _createChatController.close();
    _countryController.close();
    _userStatusController.close();
    _userRoleController.close();
    _userUsageController.close();
    pageIndexController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  BehaviorSubject<bool> _createChatController = new BehaviorSubject();

  Stream<bool> get createChatResult => _createChatController.stream;

  BehaviorSubject<String> _countryController = BehaviorSubject();

  Stream<String> get countryResult => _countryController.stream;

  BehaviorSubject<bool> _userStatusController = BehaviorSubject();

  Stream<bool> get userStatusResult => _userStatusController.stream;

  BehaviorSubject<UserRol> _userRoleController = BehaviorSubject();

  Stream<UserRol> get userRoleResult => _userRoleController.stream;

  BehaviorSubject<UsageModel> _userUsageController = BehaviorSubject();

  Stream<UsageModel> get userUsageResult => _userUsageController.stream;

  BehaviorSubject<int> pageIndexController = BehaviorSubject.seeded(0);

  String currentUserId = Injector.instance.inMemoryData.currentMember?.id ?? "";
  String teamId = '';

  void changePageIndex() => pageIndexController.sinkAddSafe(pageIndexController.value == 0 ? 1 : 0);

  void init(MemberModel member) async {
    //userId = await _prefs.getStringValue(_prefs.userId);
    teamId = await _prefs.getStringValue(_prefs.currentTeamId);
    if (Injector.instance.inMemoryData.currentMember?.userRol == UserRol.Admin)
      _loadUserUsageData(member);
    _userStatusController.sinkAddSafe(member.active);
    _userRoleController.sinkAddSafe(member.userRol);
    _loadCountry(member);
  }

  Future<void> _loadCountry(MemberModel member) async {
    String data = await rootBundle.loadString(
        member.profile?.language?.trim().toLowerCase() == 'es'
            ? 'lib/_res/assets/paises.json'
            : 'lib/_res/assets/countries.json');
    final Iterable countriesJsonIterable = jsonDecode(data);
    int index = 0;
    final list = countriesJsonIterable
        .map((json) => SingleSelectionModel(
            index: index++,
            displayName: json["printable_name"],
            id: json["iso"],
            isSelected: json["iso"].toLowerCase() ==
                member.profile?.country?.toLowerCase()))
        .toList();
    _countryController.sinkAddSafe(list
            .firstWhereOrNull((element) => element.isSelected)
            ?.displayName ??
        member.profile?.country ?? "");
  }

  void create1x1Message(MemberModel memberModel) async {
    isLoading = true;
    final res = await _iChannelRepository.create1x1Channel(memberModel);
    if (res is ResultSuccess<ChannelModel>) {
      _createChatController.sinkAddSafe(true);
      changeChannelAutoController.sinkAddSafe(
          ChannelCreatedUI(members: [memberModel], channelModel: res.value));
    } else
      showErrorMessage(res);
    isLoading = false;
  }

  void deactivateActivateUser(MemberModel memberModel) {
    memberModel.active
        ? _iUserRepository.deactivateUserTeam(teamId, memberModel.id)
        : _iUserRepository.activateUserTeam(teamId, memberModel.id);
    memberModel.active = !memberModel.active;
    _userStatusController.sinkAddSafe(memberModel.active);
  }

  void changeUserRole(MemberModel memberModel, String selectedRole) {
    _iUserRepository.putTeamMemberRole(teamId, memberModel.id, selectedRole);
    memberModel.role = selectedRole;
    _userRoleController.sinkAddSafe(memberModel.userRol);
  }

  void _loadUserUsageData(MemberModel memberModel) async {
    final res =
        await _iUserRepository.getTeamMemberUsage(teamId, memberModel.id);
    if (res is ResultSuccess<UsageModel>) {
      _userUsageController.sinkAddSafe(res.value);
    }
  }
}
