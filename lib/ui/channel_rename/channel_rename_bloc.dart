import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

class ChannelRenameBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final IChannelRepository _iChannelRepository;

  ChannelRenameBloC(this._iChannelRepository);

  @override
  void dispose() {
    _channelUpdatedController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  BehaviorSubject<ChannelModel?> _channelUpdatedController =
      new BehaviorSubject();

  Stream<ChannelModel?> get channelUpdatedResult =>
      _channelUpdatedController.stream;

  ChannelModel? channelModel;

  void renameChannel(String name) async {
    isLoading = true;
    final res = await _iChannelRepository.renameChannel(
        channelModel!.tid!, channelModel!.id, name);
    if (res is ResultSuccess<ChannelModel>) {
      channelModel = res.value;
      _channelUpdatedController.sinkAddSafe(channelModel);
    }
    isLoading = false;
  }
}
