import 'package:code/_res/R.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class PrivateGroupCreateBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final IChannelRepository _iChannelRepository;
  final SharedPreferencesManager _prefs;

  PrivateGroupCreateBloC(this._iChannelRepository, this._prefs);

  @override
  void dispose() {
    disposeErrorHandlerBloC();
    disposeLoadingBloC();
    _privateGroupController.close();
    _membersController.close();
  }

  BehaviorSubject<ChannelModel> _privateGroupController = new BehaviorSubject();

  Stream<ChannelModel> get privateGroupResult => _privateGroupController.stream;

  BehaviorSubject<List<MemberModel>?> _membersController = new BehaviorSubject();

  Stream<List<MemberModel>?> get membersResult => _membersController.stream;

  List<MemberModel> get members => _membersController.valueOrNull ?? [];

  void createPrivateGroup(String name) async {
    isLoading = true;
    final teamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final List<MemberModel> members = _membersController.valueOrNull ?? [];
    final channel = ChannelModelCreate(
        type: RemoteConstants.group,
        users: members.map((e) => e.id).toList(),
        name: name,
        readOnly: false);
    final res = await _iChannelRepository.createChannel(teamId, channel);
    if (res is ResultSuccess<ChannelModel>) {
      _privateGroupController.sinkAddSafe(res.value);
      changeChannelAutoController
          .sinkAddSafe(ChannelCreatedUI(members: [], channelModel: res.value));
    } else {
      if ((res as ResultError).code == RemoteConstants.code_conflict)
        Fluttertoast.showToast(
            msg: R.string.thisNameAlreadyExist,
            textColor: R.color.whiteColor,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.redAccent);
      else
        showErrorMessage(res);
    }
    isLoading = false;
  }

  void addMember(MemberModel memberModel) {
    final List<MemberModel> members = _membersController.valueOrNull ?? [];
    members.add(memberModel);
    _membersController.sinkAddSafe(members);
  }

  void removeMember(MemberModel memberModel) {
    final List<MemberModel> members = _membersController.valueOrNull ?? [];
    members.removeWhere((element) => element.id == memberModel.id);
    _membersController.sinkAddSafe(members);
  }
}
