import 'dart:async';

import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/repository/channel_repository.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/utils/extensions.dart';
import 'package:rxdart/subjects.dart';

class ChannelBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final IChannelRepository _iChannelRepository;
  final SharedPreferencesManager _prefs;

  ChannelBloC(this._iChannelRepository, this._prefs);

  @override
  void dispose() {
    _channelsController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  BehaviorSubject<List<ChannelModel>> _channelsController =
      new BehaviorSubject();

  Stream<List<ChannelModel>> get channelsResult => _channelsController.stream;

  String currentTeamId = "";

  StreamSubscription? ss;
  void loadChannels() async {
    isLoading = true;
    currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final res = await _iChannelRepository.getChannels(currentTeamId, type: RemoteConstants.channel);
    ss = channelsLoadedFromApi?.listen((value) {
      if(value.length > 1)
        value.sort((c1, c2) => c1.titleFixed.toLowerCase().compareTo(c2.titleFixed.toLowerCase()));
      _channelsController.sinkAddSafe(value);
      ss?.cancel();
    });
    if (res is ResultSuccess<List<ChannelModel>>) {
      if(res.value.length > 1)
      res.value.sort((c1, c2) => c1.titleFixed.toLowerCase().compareTo(c2.titleFixed.toLowerCase()));
      _channelsController.sinkAddSafe(res.value);
    }
    isLoading = false;
  }

}
