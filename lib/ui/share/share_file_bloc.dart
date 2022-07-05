import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/file/i_file_repository.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/utils/toast_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';
import 'package:collection/collection.dart';

import '../../enums.dart';

class ShareFileBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final IFileRepository _iFileRepository;
  final InMemoryData _inMemoryData;

  ShareFileBloC(this._iFileRepository, this._inMemoryData);

  @override
  void dispose() {
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
    _channelsController.close();
    _channelController.close();
    _sharedController.close();
  }

  BehaviorSubject<List<DrawerChatModel>> _channelsController =
      new BehaviorSubject();

  Stream<List<DrawerChatModel>> get channelsResult =>
      _channelsController.stream;

  BehaviorSubject<DrawerChatModel?> _channelController = new BehaviorSubject();

  Stream<DrawerChatModel?> get channelResult => _channelController.stream;

  BehaviorSubject<bool> _sharedController = new BehaviorSubject();

  Stream<bool> get sharedResult => _sharedController.stream;

  DrawerChatModel? selectedChannel;
  FileModel? file;

  void pickChannel(DrawerChatModel model) {
    selectedChannel = model;
    _channelController.sinkAddSafe(selectedChannel);
  }

  void shareFile(String comment) async {
    isLoading = true;
    final res = await _iFileRepository.shareFile(_inMemoryData.currentTeam!.id,
        file!.cid ?? "", selectedChannel?.channelModel?.id ?? "", file!.id ?? "", comment);
    if (res is ResultSuccess<bool>) {
      _sharedController.sinkAddSafe(res.value);
    } else {
      selectedChannel = null;
      if (res is ResultError &&
          (res as ResultError).code == RemoteConstants.code_conflict) {
        ToastUtil.showToast(R.string.fileAlreadyShared,
            toastLength: Toast.LENGTH_LONG);
      } else
        showErrorMessage(res);
    }
    isLoading = false;
  }

  void loadChannels(
      {List<ChannelModel?>? channels,
      List<ChannelModel?>? groups,
      List<ChannelModel?>? ims,
      List<MemberModel?>? members}) {
    List<DrawerChatModel> list = [];

    final favoritesM1x1 =
        ims?.where((element) => element?.isFavorite == true).toList();

    final favoritesOpenChannels =
        channels?.where((element) => element?.isFavorite == true).toList();

    final favoritesPrivateGroup =
        groups?.where((element) => element?.isFavorite == true).toList();

    favoritesOpenChannels?.sort((c1, c2) => c1!.titleFixed
        .toLowerCase()
        .trim()
        .compareTo(c2!.titleFixed.toLowerCase().trim()));

    favoritesPrivateGroup?.sort((c1, c2) => c1!.titleFixed
        .toLowerCase()
        .trim()
        .compareTo(c2!.titleFixed.toLowerCase().trim()));

    List<DrawerChatModel> tempFavIms = [];
    favoritesM1x1?.forEach((element) {
      final member = members?.firstWhereOrNull(
          (member) => element!.other == member!.id && (member.active));
      if (member != null)
        tempFavIms.add(
          DrawerChatModel(
              drawerHeaderChatType: DrawerHeaderChatType.Message1x1,
              isChild: true,
              channelModel: element,
              title: element!.titleFixed,
              memberModel: member),
        );
    });
    tempFavIms.sort((c1, c2) => c1.memberModel!.profile!.name
        .toLowerCase()
        .trim()
        .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim()));

    ///Adding favorites header
    list.add(DrawerChatModel(
      drawerHeaderChatType: DrawerHeaderChatType.Favorite,
      isChild: false,
      title: R.string.favorites.toUpperCase(),
      childrenCount: favoritesPrivateGroup!.length +
          favoritesOpenChannels!.length +
          favoritesM1x1!.length,
    ));

    ///AddingFavorites
    list.addAll(tempFavIms);

    favoritesOpenChannels.forEach((element) {
      list.add(
        DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.Channel,
          isChild: true,
          channelModel: element,
          title: element?.titleFixed ?? '',
        ),
      );
    });

    favoritesPrivateGroup.forEach((element) {
      list.add(DrawerChatModel(
        drawerHeaderChatType: DrawerHeaderChatType.PrivateGroup,
        isChild: true,
        channelModel: element,
        title: element?.titleFixed ?? '',
      ));
    });

    ///Adding channels header
    list.add(DrawerChatModel(
      drawerHeaderChatType: DrawerHeaderChatType.Channel,
      isChild: false,
      title: R.string.openChannels.toUpperCase(),
      childrenCount: channels!.length,
    ));

    ///Adding channels
    channels.sort((c1, c2) => c1!.titleFixed
        .toLowerCase()
        .trim()
        .compareTo(c2!.titleFixed.toLowerCase().trim()));
    channels.forEach((element) {
      if (!(element?.isFavorite == true)) {
        list.add(DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.Channel,
          isChild: true,
          channelModel: element,
          title: element?.titleFixed ?? '',
        ));
      }
    });

    ///Adding messages 1x1 header
    list.add(DrawerChatModel(
      drawerHeaderChatType: DrawerHeaderChatType.Message1x1,
      isChild: false,
      title: R.string.message1x1.toUpperCase(),
      childrenCount: ims?.length ?? members!.length,
    ));

    ///Adding messages 1x1
    List<DrawerChatModel> tempIms = [];
    ims?.forEach((element) {
      if (!(element?.isFavorite == true)) {
        final member = members?.firstWhereOrNull(
            (member) => element!.other == member!.id && (member.active));
        if (member != null)
          tempIms.add(DrawerChatModel(
              drawerHeaderChatType: DrawerHeaderChatType.Message1x1,
              isChild: true,
              channelModel: element,
              title: element?.titleFixed ?? '',
              memberModel: member));
      }
    });
    tempIms.sort((c1, c2) => c1.memberModel!.profile!.name
        .toLowerCase()
        .trim()
        .compareTo(c2.memberModel!.profile!.name.toLowerCase().trim()));
    list.addAll(tempIms);

    ///Adding private groups header
    list.add(
      DrawerChatModel(
        drawerHeaderChatType: DrawerHeaderChatType.PrivateGroup,
        isChild: false,
        title: R.string.privateGroups.toUpperCase(),
        childrenCount: groups!.length,
      ),
    );

    ///Adding private groups
    groups.sort((c1, c2) => c1!.titleFixed
        .toLowerCase()
        .trim()
        .compareTo(c2!.titleFixed.toLowerCase().trim()));
    groups.forEach((element) {
      if (!(element?.isFavorite == true)) {
        list.add(DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.PrivateGroup,
          isChild: true,
          channelModel: element,
          title: element?.titleFixed ?? '',
        ));
      }
    });

    _channelsController.sinkAddSafe(list);
  }
}
