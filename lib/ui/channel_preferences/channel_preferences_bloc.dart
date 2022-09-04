import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class ChannelPreferencesBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC {
  final IChannelRepository _iChannelRepository;

  ChannelPreferencesBloC(this._iChannelRepository);

  @override
  void dispose() {
    _channelUpdatedController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  BehaviorSubject<ChannelModel> _channelUpdatedController =
      new BehaviorSubject();

  Stream<ChannelModel> get channelUpdatedResult =>
      _channelUpdatedController.stream;

  bool sounds = false;
  bool emails = false;
  bool pushesAlways = false;
  ChannelModel? channelModel;

  void initData(ChannelModel? channelModel) {
    this.channelModel = channelModel;
    sounds = channelModel!.notifications!.sounds!;
    emails = channelModel.notifications!.emails!;
    pushesAlways = channelModel.notifications!.alwaysPush!;
  }

  void setNotifications() async {
    isLoading = true;
    final notif = NotificationModel(sounds: sounds, emails: false, alwaysPush: pushesAlways);
    final res = await _iChannelRepository.putChannelMemberNotifications(notif);
    if (res is ResultSuccess<bool>) {
      channelModel?.notifications = notif;
      _channelUpdatedController.sinkAddSafe(channelModel!);
    }
    isLoading = false;
  }
}
