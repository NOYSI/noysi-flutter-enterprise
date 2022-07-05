import 'dart:io';

import 'package:code/domain/user/user_model.dart';
import 'package:code/utils/file_manager.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart';
import 'package:code/_res/R.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/file/i_file_repository.dart';
import 'package:code/domain/team/i_team_repository.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/enums.dart';
import 'package:code/rtc/i_rtc_manager.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/utils/toast_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';

import 'home_ui_model.dart';

class ShareExternalBloC extends BaseBloC with ErrorHandlerBloC, LoadingBloC {
  final IFileRepository _iFileRepository;
  final SharedPreferencesManager _prefs;
  final IRTCManager _irtcManager;
  final ITeamRepository _iTeamRepository;

  ShareExternalBloC(this._prefs, this._iFileRepository,
      this._irtcManager, this._iTeamRepository);

  BehaviorSubject<bool> _showUploadingController = new BehaviorSubject();

  Stream<bool> get showUploadingResult => _showUploadingController.stream;

  BehaviorSubject<double> _uploadingController = new BehaviorSubject();

  Stream<double> get uploadingResult => _uploadingController.stream;

  BehaviorSubject<List<DrawerChatModel>> _channelsController =
      new BehaviorSubject();

  Stream<List<DrawerChatModel>> get channelsResult =>
      _channelsController.stream;

  BehaviorSubject<DrawerChatModel> _channelController = new BehaviorSubject();

  Stream<DrawerChatModel> get channelResult => _channelController.stream;

  BehaviorSubject<List<TeamModel>> _teamsController = new BehaviorSubject();

  Stream<List<TeamModel>> get teamsResult => _teamsController.stream;

  BehaviorSubject<TeamModel> _teamController = new BehaviorSubject();

  Stream<TeamModel> get teamResult => _teamController.stream;

  @override
  void dispose() {
    _showUploadingController.close();
    _uploadingController.close();
    _channelsController.close();
    _channelController.close();
    _teamsController.close();
    _teamController.close();
  }

  DrawerChatModel? selectedChannel;
  TeamModel? selectedTeam;

  CancelToken? cancelToken;

  bool get isUploading => _showUploadingController.valueOrNull ?? false;

  void cancelTokenPost() async {
    cancelToken?.cancel();
    _uploadingController.sinkAddSafe(0);
    Future.delayed(Duration(milliseconds: 100), () {
      _showUploadingController.sinkAddSafe(false);
    });
  }

  void shareText(String text, {String? channelId, String? teamId, required BuildContext bottomModalContext}) async {
    final currentTeamId =
        teamId ?? await _prefs.getStringValue(_prefs.currentTeamId);
    final currentChatId =
        channelId ?? await _prefs.getStringValue(_prefs.currentChatId);
    _irtcManager.sendMessage(text, channelId: currentChatId, teamId: currentTeamId);
    NavigationUtils.pop(bottomModalContext);
  }

  void uploadFile(File file,
      {String? channelId,
      String? teamId,
      required BuildContext bottomModalContext}) async {
    final currentTeamId =
        teamId ?? await _prefs.getStringValue(_prefs.currentTeamId);
    final currentChatId =
        channelId ?? await _prefs.getStringValue(_prefs.currentChatId);
    final fileName = basename(file.path);
    final mime = FileManager.lookupMime(file.path);
    int fileSize = file.lengthSync();
    FileCreateModel fileCreateModel = FileCreateModel(
        type: 'file', size: fileSize, path: "/$fileName", mime: mime);
    _showUploadingController.sinkAddSafe(true);
    final res = await _iFileRepository
        .uploadChannelFile(currentTeamId, currentChatId, file, fileCreateModel,
            onCancelToken: (cancelTok) {
      cancelToken = cancelTok;
    }, onProgress: (count, total) {
      print("onProgress --- $count --- $total --- ${count / total}");
      _uploadingController.sinkAddSafe(count / total);
    }, onFinish: (count, total) {
      print("onFinish --- $count --- $total");
      _showUploadingController.sinkAddSafe(false);
    });
    if (res is ResultSuccess<FileModel>) {
      _showUploadingController.sinkAddSafe(false);
      Future.delayed(Duration(milliseconds: 100), () {
        _uploadingController.sinkAddSafe(0);
      });
      NavigationUtils.pop(bottomModalContext);
    } else if (res is ResultError &&
        (res as ResultError).code == RemoteConstants.code_conflict) {
      ToastUtil.showToast(R.string.fileAlreadyShared,
          toastLength: Toast.LENGTH_LONG);
      _showUploadingController.sinkAddSafe(false);
      Future.delayed(Duration(milliseconds: 100), () {
        _uploadingController.sinkAddSafe(0);
      });
    } else {
      _showUploadingController.sinkAddSafe(false);
      Future.delayed(Duration(milliseconds: 100), () {
        _uploadingController.sinkAddSafe(0);
      });
      //showErrorMessage(res);
    }
  }

  void loadTeams() async {
    isLoading = true;
    String currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    final teamsRes = await _iTeamRepository.getTeams();
    if (teamsRes is ResultSuccess<List<TeamModel>>) {
      bool found = false;
      for (int i = 0; i < teamsRes.value.length && !found; i++) {
        if (teamsRes.value[i].id == currentTeamId) {
          pickTeam(teamsRes.value[i], initialLoad: true);
          found = true;
        }
      }
      _teamsController.sinkAddSafe(teamsRes.value);
    } else
      isLoading = false;
  }

  void pickChannel(DrawerChatModel model) {
    selectedChannel = model;
    _channelController.sinkAddSafe(selectedChannel!);
  }

  Map<String, List<DrawerChatModel>> _teamMap = {};
  
  void pickTeam(TeamModel model, {initialLoad = false}) async {
    selectedTeam = model;
    _teamController.sinkAddSafe(selectedTeam!);
    if(_teamMap[model.id] == null || _teamMap[model.id]?.isEmpty == true) {
      if (!initialLoad) isLoading = true;
      List<DrawerChatModel> drawerChatModelList = [];

      final res = await _iTeamRepository.joinTeam(model.name, teamId: model.id);
      if(res is ResultSuccess<TeamJoinedModel>){
        final joinedTeam = res.value;

        final favoritesM1x1 = joinedTeam.messages1x1
            .where((element) =>
        element.isFavorite == true)
            .toList();

        final favoritesOpenChannels = joinedTeam.channels
            .where((element) =>
        element.isFavorite == true)
            .toList();

        final favoritesPrivateGroup = joinedTeam.groups
            .where((element) =>
        element.isFavorite == true)
            .toList();

        favoritesOpenChannels
            .sort((c1, c2) => c1.titleFixed.toLowerCase().trim()
            .compareTo(c2.titleFixed.toLowerCase().trim()));

        favoritesPrivateGroup
            .sort((c1, c2) => c1.titleFixed.toLowerCase().trim()
            .compareTo(c2.titleFixed.toLowerCase().trim()));

        List<DrawerChatModel> tempFavIms = [];
        favoritesM1x1.forEach((element) {
          tempFavIms.add(DrawerChatModel(
              drawerHeaderChatType: DrawerHeaderChatType.Message1x1,
              isChild: true,
              channelModel: element,
              title: element.titleFixed,
              memberModel: joinedTeam.memberWrapperModel.list
                  .firstWhereOrNull((member) => element.other == member.id) ?? MemberModel()));
        });
        tempFavIms.sort((c1, c2) =>
            (c1.memberModel!.profile?.name.toLowerCase().trim() ?? "")
                .compareTo((c2.memberModel!.profile?.name.toLowerCase().trim() ?? "")));


        ///Adding favorites header
        drawerChatModelList.add(DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.Favorite,
          isChild: false,
          title: R.string.favorites.toUpperCase(),
          childrenCount: favoritesPrivateGroup.length + favoritesOpenChannels.length + favoritesM1x1.length,
        ));

        ///AddingFavorites
        drawerChatModelList.addAll(tempFavIms);

        favoritesOpenChannels.forEach((element) {
          drawerChatModelList.add(DrawerChatModel(
            drawerHeaderChatType: DrawerHeaderChatType.Channel,
            isChild: true,
            channelModel: element,
            title: element.titleFixed,
          ));
        });

        favoritesPrivateGroup.forEach((element) {
          drawerChatModelList.add(DrawerChatModel(
            drawerHeaderChatType: DrawerHeaderChatType.PrivateGroup,
            isChild: true,
            channelModel: element,
            title: element.titleFixed,
          ));
        });

        ///Adding channels header
        drawerChatModelList.add(DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.Channel,
          isChild: false,
          title: R.string.openChannels.toUpperCase(),
          childrenCount: joinedTeam.channels.length,
        ));

        ///Adding channels
        joinedTeam.channels
            .sort((c1, c2) => c1.titleFixed.toLowerCase().trim()
            .compareTo(c2.titleFixed.toLowerCase().trim()));
        joinedTeam.channels.forEach((element) {
          if(!(element.isFavorite == true)) {
            drawerChatModelList.add(DrawerChatModel(
              drawerHeaderChatType: DrawerHeaderChatType.Channel,
              isChild: true,
              channelModel: element,
              title: element.titleFixed,
            ));
          }
        });

        ///Adding messages 1x1 header
        drawerChatModelList.add(DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.Message1x1,
          isChild: false,
          title: R.string.message1x1.toUpperCase(),
          childrenCount: joinedTeam.memberWrapperModel.total ??
              joinedTeam.messages1x1.length,
        ));

        ///Adding messages 1x1
        List<DrawerChatModel> tempIms = [];
        joinedTeam.messages1x1.forEach((element) {
          if(!(element.isFavorite == true)) {
            tempIms.add(DrawerChatModel(
                drawerHeaderChatType: DrawerHeaderChatType.Message1x1,
                isChild: true,
                channelModel: element,
                title: element.titleFixed,
                memberModel: joinedTeam.memberWrapperModel.list
                    .firstWhereOrNull((member) => element.other == member.id) ?? MemberModel()));
          }
        });
        tempIms.sort((c1, c2) =>
            (c1.memberModel!.profile?.name.toLowerCase().trim() ?? "")
                .compareTo((c2.memberModel!.profile?.name.toLowerCase().trim() ?? "")));
        drawerChatModelList.addAll(tempIms);

        ///Adding private groups header
        drawerChatModelList.add(DrawerChatModel(
          drawerHeaderChatType: DrawerHeaderChatType.PrivateGroup,
          isChild: false,
          title: R.string.privateGroups.toUpperCase(),
          childrenCount: joinedTeam.groups.length,
        ));

        ///Adding private groups
        joinedTeam.groups
            .sort((c1, c2) => c1.titleFixed.toLowerCase().trim()
            .compareTo(c2.titleFixed.toLowerCase().trim()));
        joinedTeam.groups.forEach((element) {
          if(!(element.isFavorite == true)) {
            drawerChatModelList.add(DrawerChatModel(
              drawerHeaderChatType: DrawerHeaderChatType.PrivateGroup,
              isChild: true,
              channelModel: element,
              title: element.titleFixed,
            ));
          }
        });
        _teamMap[model.id] = drawerChatModelList;
      }
      _channelsController.sinkAddSafe(drawerChatModelList);
      isLoading = false;
    }else {
      _channelsController.sinkAddSafe(_teamMap[model.id]!);
    }
  }
}
