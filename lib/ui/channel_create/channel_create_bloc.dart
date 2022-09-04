import 'package:code/_res/R.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
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

class ChannelCreateBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final IChannelRepository _iChannelRepository;
  final SharedPreferencesManager _prefs;

  ChannelCreateBloC(this._iChannelRepository, this._prefs);

  @override
  void dispose() {
    _channelController.close();
    disposeErrorHandlerBloC();
    disposeLoadingBloC();
  }

  BehaviorSubject<ChannelModel?> _channelController = new BehaviorSubject();

  Stream<ChannelModel?> get channelResult => _channelController.stream;
  bool isReadOnly = false;

  void createChannel(String name) async {
    isLoading = true;
    final teamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final channel = ChannelModelCreate(
        type: RemoteConstants.channel,
        readOnly: isReadOnly,
        users: [],
        name: name);
    final res = await _iChannelRepository.createChannel(teamId, channel);
    if (res is ResultSuccess<ChannelModel>) {
      _channelController.sinkAddSafe(res.value);
      changeChannelAutoController
          .sinkAddSafe(ChannelCreatedUI(members: [], channelModel: res.value, newCreated: true));
    } else {
      if (res is ResultError &&
          (res as ResultError).code == RemoteConstants.code_conflict) {
        Fluttertoast.showToast(
            msg: R.string.thisNameAlreadyExist,
            textColor: R.color.whiteColor,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.redAccent);
      } else
        showErrorMessage(res);
    }
    isLoading = false;
  }
}
