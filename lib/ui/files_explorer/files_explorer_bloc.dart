import 'dart:io';

import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/endpoints.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/file/i_file_repository.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/single_selection_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/global_regexp.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/ui/files_explorer/file_model_ui.dart';
import 'package:code/utils/common_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:rxdart/subjects.dart';
import 'package:code/utils/extensions.dart';
import 'package:collection/collection.dart';

import '../../domain/channel/i_channel_repository.dart';
import '../../domain/user/i_user_repository.dart';
import '../../enums.dart';
import '../../utils/file_manager.dart';

class FilesExplorerBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final IFileRepository _iFileRepository;
  final SharedPreferencesManager _prefs;
  final IUserRepository _iUserRepository;
  final IChannelRepository _iChannelRepository;

  FilesExplorerBloC(this._iFileRepository, this._prefs, this._iUserRepository, this._iChannelRepository);

  BehaviorSubject<FileModelUI> _initController = new BehaviorSubject();

  Stream<FileModelUI> get initResult => _initController.stream;

  BehaviorSubject<List<FileModel>> _filesController = new BehaviorSubject();

  Stream<List<FileModel>> get filesResult => _filesController.stream;

  BehaviorSubject<FileViewMode?> _viewModeController = new BehaviorSubject();

  Stream<FileViewMode?> get viewModeStream => _viewModeController.stream;

  late String teamId;
  late String currentUserId;
  late FileModelUI fileModelUI;
  int crossAxis = 2;
  double aspectRatio = 3;

  //String currentContainerId = "";
  int max = 50;
  int offset = 0;
  String sort = "desc";
  bool isLoadingLinks = false;
  String? currentParentAdmin = '';
  List<MemberModel> memberList = [];
  Map<String, String?> channelsAdmin = Map();

  void initView(
      List<MemberModel> members,
      List<ChannelModel> channels,
      List<ChannelModel> groups,
      List<ChannelModel> messages1x1,
      ChannelModel? selectedChannel,
      FolderModel? selectedFolder,
      {Map<String, ParentContainerUI>? containerMap}) async {
    teamId = await _prefs.getStringValue(_prefs.currentTeamId);
    currentUserId = await _prefs.getStringValue(_prefs.userId);
    memberList = members;
    ChannelModel? noysi;
    members.forEach((member) {
      ChannelModel? ch =
          messages1x1.firstWhereOrNull((element) => element.other == member.id);
      if (ch != null) {
        ch.name = "@${CommonUtils.getMemberUsername(member)}";
        if(member.id == RemoteConstants.noysiRobot) {
          noysi = ch;
        }
      }
    });


    fileModelUI = FileModelUI(
      isRootView: true,
      breadCrumbList: [
        SingleSelectionModel(
            index: 0, id: "0", displayName: R.string.files, isSelected: true),
      ],
      channels: channels,
      groups: groups,
      messages1x1: messages1x1,
      noysiChannel: noysi,
      currentChannelId: "",
      sortMode: SortFileMode.newest,
      currentParentContainer: null,
    );

    fileModelUI.containerMap = containerMap ?? Map();

    channels.forEach((element) {
      channelsAdmin[element.id] = element.uid!;
      final container = fileModelUI.containerMap?[element.id];
      fileModelUI.containerMap?[element.id] = ParentContainerUI(
        id: element.id,
        name: element.titleFixed,
        folders: container != null ? container.folders : [],
        files: container != null ? container.files : [],
        path: "/",
        cid: element.id,
      );
    });

    groups.forEach((element) {
      channelsAdmin[element.id] = element.uid!;
      final container = fileModelUI.containerMap?[element.id];
      fileModelUI.containerMap?[element.id] = ParentContainerUI(
        id: element.id,
        name: element.titleFixed,
        folders: container != null ? container.folders : [],
        files: container != null ? container.files : [],
        path: "/",
        cid: element.id,
      );
    });

    messages1x1.forEach((element) {

      channelsAdmin[element.id] = element.uid ?? currentUserId;
      final container = fileModelUI.containerMap?[element.id];
      fileModelUI.containerMap?[element.id] = ParentContainerUI(
        id: element.id,
        name: element.titleFixed,
        folders: container != null ? container.folders : [],
        files: container != null ? container.files : [],
        path: "/",
        cid: element.id,
      );
    });

    if (noysi != null) {
      noysi!.uid = currentUserId;
      channelsAdmin[noysi!.id] = noysi!.uid;
      final container = fileModelUI.containerMap?[noysi!.id];
      fileModelUI.containerMap?[noysi!.id] = ParentContainerUI(
        id: noysi!.id,
        name: noysi!.titleFixed,
        folders: container != null ? container.folders : [],
        files: container != null ? container.files : [],
        path: "/",
        cid: noysi!.id,
      );
    } else {
      isLoading = true;
      final resNoysi = await _iUserRepository.getTeamMember(teamId, RemoteConstants.noysiRobot);
      if(resNoysi is ResultSuccess<MemberModel>) {
        final resNoysiChannel = await _iChannelRepository.create1x1Channel(resNoysi.value);
        if(resNoysiChannel is ResultSuccess<ChannelModel>) {
          resNoysiChannel.value.name = "@${CommonUtils.getMemberUsername(resNoysi.value)}";
          resNoysiChannel.value.uid = currentUserId;
          noysi = resNoysiChannel.value;
          memberList.add(resNoysi.value);
          channelsAdmin[noysi!.id] = noysi!.uid;
          final container = fileModelUI.containerMap?[noysi!.id];
          fileModelUI.containerMap?[noysi!.id] = ParentContainerUI(
            id: noysi!.id,
            name: noysi!.titleFixed,
            folders: container != null ? container.folders : [],
            files: container != null ? container.files : [],
            path: "/",
            cid: noysi!.id,
          );
          fileModelUI.messages1x1.add(noysi!);
          fileModelUI.noysiChannel = noysi!;
        }
      }
      isLoading = false;
    }

    ParentContainerUI? foundChannel;
    final selectedFolderFixedPath =
        selectedFolder != null ? _getFixedPath(selectedFolder.path) : '';
    if (selectedFolder != null) {
      fileModelUI.containerMap?.forEach((key, value) {
        if (key == selectedFolder.cid) {
          foundChannel = value;
        }
      });
    }

    // if (foundChannel != null) {
    //   fileModelUI.breadCrumbList.add(SingleSelectionModel(
    //     id: foundChannel.id,
    //     displayName: foundChannel.name,
    //     index: fileModelUI.breadCrumbList.length,
    //     isSelected: false,
    //   ));
    //   final container = fileModelUI.containerMap[selectedFolder.id];
    //   fileModelUI.containerMap[selectedFolder.id] = ParentContainerUI(
    //     id: selectedFolder.id,
    //     name: selectedFolderFixedPath.split('/').last,
    //     folders: container != null ? container.folders : [],
    //     files: container != null ? container.files : [],
    //     path: selectedFolderFixedPath,
    //   );
    //   List<String> toPopulateBreadCrumb = selectedFolderFixedPath.split('/');
    //   toPopulateBreadCrumb.removeAt(0);
    //   toPopulateBreadCrumb.removeLast();
    //   toPopulateBreadCrumb.forEach((element) {
    //     fileModelUI.breadCrumbList.add(SingleSelectionModel(
    //       id: "",
    //       displayName: element.trim(),
    //       index: fileModelUI.breadCrumbList.length,
    //       isSelected: false,
    //     ));
    //   });
    // }
    _initController.sinkAddSafe(fileModelUI);

    await Future.delayed(Duration(milliseconds: 100));

    if (selectedChannel != null) {
      fileModelUI.currentChannelId = selectedChannel.id;
      currentParentAdmin = channelsAdmin[selectedChannel.id];
      loadFiles(selectedChannel.titleFixed, selectedChannel.id);
    } else if (selectedFolder != null && foundChannel != null) {
      fileModelUI.breadCrumbList?.add(SingleSelectionModel(
        id: foundChannel?.id ?? '',
        displayName: foundChannel?.name ?? '',
        index: fileModelUI.breadCrumbList!.length,
        isSelected: false,
      ));
      final container = fileModelUI.containerMap?[selectedFolder.id];
      fileModelUI.containerMap?[selectedFolder.id] = ParentContainerUI(
        id: selectedFolder.id,
        name: selectedFolderFixedPath.split('/').last,
        folders: container != null ? container.folders : [],
        files: container != null ? container.files : [],
        path: selectedFolderFixedPath,
        cid: selectedFolder.cid,
      );
      List<String> toPopulateBreadCrumb = selectedFolderFixedPath.split('/');
      toPopulateBreadCrumb.removeAt(0);
      toPopulateBreadCrumb.removeLast();
      toPopulateBreadCrumb.forEach((element) {
        fileModelUI.breadCrumbList?.add(SingleSelectionModel(
          id: "",
          displayName: element.trim(),
          index: fileModelUI.breadCrumbList?.length ?? 0,
          isSelected: false,
        ));
      });

      fileModelUI.currentChannelId = selectedFolder.cid;
      currentParentAdmin = channelsAdmin[selectedFolder.cid]!;
      loadFiles(selectedFolderFixedPath.split('/').last, selectedFolder.id);
    } else if (selectedFolder != null && foundChannel == null) {
      showErrorMessageFromString(R.string.folderIsNotInAvailableChannel);
    }
  }

  bool isLoadingMore = false;

  Future<void> loadMoreFilesFolders() async {
    isLoadingMore = true;
    final container = fileModelUI.currentParentContainer;
    if (!fileModelUI.isRootView &&
        container != null &&
        container.offset < container.total) {
      final toLoad = container.total - container.offset >= max
          ? max
          : container.total - container.offset;
      final res = await _iFileRepository.getChannelFiles(
          teamId, fileModelUI.currentChannelId ?? "", container.path!,
          max: toLoad, offset: container.offset, sort: sort);
      if (res is ResultSuccess<FileWrapperModel>) {
        final folders =
            res.value.list.where((element) => element.folder!).toList();
        final files =
            res.value.list.where((element) => !element.folder!).toList();
        container.files?.addAll(files);
        container.folders?.addAll(folders);
        container.offset += toLoad;

        folders.forEach((element) {
          if(element.id?.isNotEmpty == true) {
            fileModelUI.containerMap?[element.id!] = ParentContainerUI(
                id: element.id,
                name: element.titleFixed,
                folders: [],
                files: [],
                cid: container.cid,
                path: element.path);
          }
        });
        _initController.sinkAddSafe(fileModelUI);
      }
    }
    isLoadingMore = false;
  }

  String _getFixedPath(String path) => path.trim().endsWith('/')
      ? path.trim().replaceRange(path.length - 1, path.length, '')
      : path.trim();

  String _getPathFromBreadCrumbIndex(int i) {
    final currentBreadCrumb = fileModelUI.breadCrumbList;
    if (currentBreadCrumb!.length < 3 || i < 2) return '/';
    final fixedPath = _getFixedPath(fileModelUI.currentParentContainer!.path!);
    List<String> list = fixedPath.split('/');
    list.removeAt(0);
    String path = '';
    bool found = false;
    for (int j = 0; j < list.length && !found; j++) {
      path += "/${list[j]}";
      if (list[j] == list[i - 2]) {
        found = true;
      }
    }
    return path;
  }

  Future<void> loadFiles(
    String name,
    String containerId, {
    bool forceReload = false,
    int? fromBreadCrumb,
  }) async {
    final container = fileModelUI.containerMap?[containerId];
    if (forceReload ||
        (container == null ||
            (container.files!.isEmpty && container.folders!.isEmpty))) {
      isLoading = true;
      final res = await _iFileRepository.getChannelFiles(
          teamId,
          fileModelUI.currentChannelId!,
          fromBreadCrumb != null && container == null
              ? _getPathFromBreadCrumbIndex(fromBreadCrumb)
              : container!.path!,
          max: max,
          offset: offset,
          sort: sort);
      if (res is ResultSuccess<FileWrapperModel>) {
        if (res.value.path == '/' || res.value.id != null) {
          final folders =
              res.value.list.where((element) => element.folder!).toList();
          final files =
              res.value.list.where((element) => !element.folder!).toList();

          if (fromBreadCrumb != null && container == null) {
            containerId = res.value.id!;
            fileModelUI.containerMap?[containerId] = ParentContainerUI(
              id: containerId,
              name: name,
              folders: folders,
              files: files,
              path: _getPathFromBreadCrumbIndex(fromBreadCrumb),
              cid: res.value.cid,
            );
            fileModelUI.breadCrumbList?[fromBreadCrumb].id = containerId;
          }

          fileModelUI.containerMap?[containerId]?.folders = folders;
          fileModelUI.containerMap?[containerId]?.files = files;
          fileModelUI.containerMap?[containerId]?.offset =
              folders.length + files.length;
          fileModelUI.containerMap?[containerId]?.total = res.value.total;

          folders.forEach((element) {
            if(element.id?.isEmpty == true) return;
            final container = fileModelUI.containerMap?[element.id];
            fileModelUI.containerMap?[element.id!] = ParentContainerUI(
                id: element.id,
                name: element.titleFixed,
                folders: container != null ? container.folders : [],
                files: container != null ? container.files : [],
                cid: res.value.cid,
                path: element.path);
          });

          fileModelUI.currentParentContainer =
              fileModelUI.containerMap?[containerId];
          fileModelUI.isRootView = false;

          loadBreadCrumb(
            SingleSelectionModel(
              index: fileModelUI.breadCrumbList?.length ?? 0,
              displayName: name,
              id: containerId,
              isSelected: true,
            ),
          );

          _initController.sinkAddSafe(fileModelUI);
        } else {
          showErrorMessageFromString(R.string.folderIsNotInAvailableChannel);
        }
      } else
        showErrorMessage(res);
      isLoading = false;
    } else {
      fileModelUI.currentParentContainer = container;
      fileModelUI.isRootView = false;
      loadBreadCrumb(
        SingleSelectionModel(
            index: fileModelUI.breadCrumbList?.length ?? 0,
            displayName: name,
            id: containerId,
            isSelected: true),
      );

      _initController.sinkAddSafe(fileModelUI);
    }
  }

  void loadBreadCrumb(SingleSelectionModel model) {
    List<SingleSelectionModel> newList = [];
    bool found = false;
    fileModelUI.breadCrumbList?.forEach((element) {
      element.isSelected = false;
      if (element.id != model.id && !found) {
        newList.add(element);
      } else {
        found = true;
      }
    });
    newList.add(model);
    fileModelUI.breadCrumbList = newList;
  }

  void _reconfigureBreadCrumb(String oldPath, String newPath) {
    if (fileModelUI.breadCrumbList!.length > 2)
      oldPath = _getFixedPath(oldPath);
    newPath = _getFixedPath(newPath);
    String p = '';
    for (int i = 2; i < fileModelUI.breadCrumbList!.length; i++) {
      p = p + "/${fileModelUI.breadCrumbList?[i].displayName}";
    }
    if (p.contains(oldPath)) {
      List<SingleSelectionModel> newList = [];
      newList.add(fileModelUI.breadCrumbList![0]);
      newList.add(fileModelUI.breadCrumbList![1]);
      p = p.replaceFirst(oldPath, newPath);
      List<String> names = p.split('/')..removeAt(0);
      for (int i = 2; i < fileModelUI.breadCrumbList!.length; i++) {
        fileModelUI.breadCrumbList?[i].displayName = names[i - 2];
      }
    }
  }

  void setViewType(FileViewMode fileViewMode) {
    if ((_viewModeController.valueOrNull ?? FileViewMode.grid) == fileViewMode)
      return;
    else {
      crossAxis = fileViewMode == FileViewMode.grid ? 2 : 1;
      _viewModeController.sinkAddSafe(fileViewMode);
    }
  }

  void uploadFile(File file) async {
    String slashString =
        fileModelUI.currentParentContainer!.path!.endsWith("/") ? "" : "/";
    if (teamId.isNotEmpty && fileModelUI.currentChannelId!.isNotEmpty) {
      final fileName = file.path.split("/").last;
      final mime = FileManager.lookupMime(file.path);
      FileCreateModel fileCreateModel = FileCreateModel(
          type: 'file',
          size: file.lengthSync(),
          path:
              "${fileModelUI.currentParentContainer?.path}$slashString$fileName",
          mime: mime);
      isLoading = true;
      await _iFileRepository.uploadChannelFile(
          teamId, fileModelUI.currentChannelId!, file, fileCreateModel);
      // if (res is ResultSuccess<FileModel>) {
      //   loadFiles(fileModelUI.currentParentContainer.name,
      //       fileModelUI.currentParentContainer.id,
      //       forceReload: true);
      // }
      isLoading = false;
    }
  }

  void onFileFolderCreated(FileModel file) {
    if (teamId == file.tid && file.id?.isNotEmpty == true) {
      if (file.folder!) {
        final folderPath = _getFixedPath(file.path);
        if (folderPath.split('/').length == 2 &&
            fileModelUI.containerMap?[file.cid] != null &&
            ((fileModelUI.containerMap![file.cid]!.files!.isNotEmpty ||
                    fileModelUI
                        .containerMap![file.cid]!.folders!.isNotEmpty) ||
                (fileModelUI.currentParentContainer?.path == '/' &&
                    fileModelUI.currentParentContainer?.cid == file.cid))) {
          fileModelUI.containerMap?[file.cid]?.folders?.add(file);
          fileModelUI.containerMap?[file.id!] = ParentContainerUI(
              folders: [],
              files: [],
              name: folderPath.split('/').last,
              cid: file.cid,
              id: file.id,
              path: folderPath);
        } else if (folderPath.split('/').length > 2) {
          List<String> p = folderPath.split('/');
          p.removeLast();
          final parentPath = _getFixedPath(p.join('/'));
          bool add = false;
          fileModelUI.containerMap?.forEach((key, value) {
            if (_getFixedPath(value.path!) == parentPath &&
                file.cid == value.cid &&
                ((value.folders!.isNotEmpty || value.files!.isNotEmpty) ||
                    ((fileModelUI.currentParentContainer?.path == parentPath ||
                            fileModelUI.currentParentContainer?.path ==
                                "$parentPath/") &&
                        fileModelUI.currentParentContainer?.cid ==
                            file.cid))) {
              value.folders?.add(file);
              add = true;
            }
          });
          if (add) {
            fileModelUI.containerMap?[file.id!] = ParentContainerUI(
                folders: [],
                files: [],
                name: folderPath.split('/').last,
                cid: file.cid,
                id: file.id,
                path: folderPath);
          }
        }
      } else {
        final filePath = _getFixedPath(file.path);
        if (filePath.split('/').length == 2 &&
            fileModelUI.containerMap![file.cid] != null &&
            ((fileModelUI.containerMap![file.cid]!.files!.isNotEmpty ||
                    fileModelUI
                        .containerMap![file.cid]!.folders!.isNotEmpty) ||
                (fileModelUI.currentParentContainer?.path == '/' &&
                    fileModelUI.currentParentContainer?.cid == file.cid))) {
          fileModelUI.containerMap?[file.cid]?.files?.add(file);
        } else if (filePath.split('/').length > 2) {
          List<String> p = filePath.split('/');
          p.removeLast();
          final parentPath = _getFixedPath(p.join('/'));
          fileModelUI.containerMap?.forEach((key, value) {
            if (_getFixedPath(value.path!) == parentPath &&
                file.cid == value.cid &&
                ((value.folders!.isNotEmpty || value.files!.isNotEmpty) ||
                    ((fileModelUI.currentParentContainer?.path == parentPath ||
                            fileModelUI.currentParentContainer?.path ==
                                "$parentPath/") &&
                        fileModelUI.currentParentContainer?.cid ==
                            file.cid))) {
              value.files?.add(file);
            }
          });
        }
      }
      _initController.sinkAddSafe(fileModelUI);
    }
  }

  void createFolder(String folderName) async {
    if (!GlobalRegexp.genericName.hasMatch(folderName)) {
      showErrorMessageFromString(R.string.folderNameIncorrect);
    } else {
      String slashString =
          fileModelUI.currentParentContainer!.path!.endsWith("/") ? "" : "/";
      if (teamId.isNotEmpty && fileModelUI.currentChannelId!.isNotEmpty) {
        isLoading = true;
        FolderCreateModel folderCreateModel = FolderCreateModel(
          type: 'folder',
          path:
              "${fileModelUI.currentParentContainer!.path}$slashString$folderName",
        );
        final res = await _iFileRepository.createFolder(
            teamId, fileModelUI.currentChannelId!, folderCreateModel);
        if (res is ResultError &&
            (res as ResultError).code == RemoteConstants.code_conflict) {
          showErrorMessageFromString(R.string.thisNameAlreadyExist);
        }
        isLoading = false;
      }
    }
  }

  void onFolderRenamed(
      String folderId, String tid, String cid, String newPath) {
    if (teamId == tid) {
      newPath = _getFixedPath(newPath);
      String oldPath = '';
      fileModelUI.containerMap?.forEach((key, value) {
        if (value.cid == cid) {
          for (int i = 0; i < value.folders!.length && oldPath.isEmpty; i++) {
            if (value.folders![i].id == folderId) {
              oldPath = _getFixedPath(value.folders![i].path);
            }
          }
        }
      });
      if (oldPath.isNotEmpty) {
        fileModelUI.containerMap?.forEach((key, value) {
          value.folders?.forEach((element) {
            if (element.path.contains(oldPath) && element.cid == cid) {
              element.path = element.path.replaceFirst(oldPath, newPath);
              element.name = _getFixedPath(element.path).split('/').last;
            }
          });
          value.files?.forEach((element) {
            if (element.path.contains(oldPath) && element.cid == cid) {
              element.path = element.path.replaceFirst(oldPath, newPath);
              element.name = _getFixedPath(element.path).split('/').last;
            }
          });
          if (value.cid == cid && value.path!.contains(oldPath)) {
            value.path = value.path!.replaceFirst(oldPath, newPath);
            value.name = _getFixedPath(value.path!).split('/').last;
          }
        });
        if (fileModelUI.currentChannelId != null &&
            fileModelUI.currentChannelId == cid)
          _reconfigureBreadCrumb(oldPath, newPath);
        _initController.sinkAddSafe(fileModelUI);
      }
    }
  }

  void renameFolder(String folderId, String newName) async {
    if (!GlobalRegexp.genericName.hasMatch(newName)) {
      showErrorMessageFromString(R.string.folderNameIncorrect);
    } else {
      isLoading = true;
      bool isFile = false;
      int index = fileModelUI.currentParentContainer!.folders!
          .indexWhere((element) => element.id == folderId);
      if (index < 0) {
        isFile = true;
        index = fileModelUI.currentParentContainer!.files!
            .indexWhere((element) => element.id == folderId);
      }
      final oldPath = _getFixedPath(isFile
          ? fileModelUI.currentParentContainer!.files![index].path
          : fileModelUI.currentParentContainer!.folders![index].path);
      List<String> fixedPathArray = oldPath.split('/');
      fixedPathArray[fixedPathArray.length - 1] = newName;
      final newPath = fixedPathArray.join('/');
      final res = await _iFileRepository.renameFolder(
          teamId, fileModelUI.currentChannelId ?? '', folderId, newPath);
      if (res is ResultError &&
          (res as ResultError).code == RemoteConstants.code_conflict) {
        showErrorMessageFromString(R.string.permissionDenied);
      }
      isLoading = false;
    }
  }

  void onFileFolderDeleted(String id, String cid, String tid, String path,
      {isFolder = false}) {
    if (tid == teamId) {
      bool isContained = false;
      if (!isFolder) {
        fileModelUI.containerMap?.forEach((key, value) {
          value.files?.removeWhere((element) => element.id == id);
        });
      } else {
        fileModelUI.containerMap?.forEach((key, value) {
          bool found = false;
          for (int i = 0; i < value.folders!.length && !found; i++) {
            if (value.folders![i].id == id) {
              found = true;
              isContained = (fileModelUI.currentParentContainer?.path
                          ?.contains(value.folders![i].path) ??
                      false) &&
                  fileModelUI.currentChannelId == cid;
              value.folders?.removeAt(i);
            }
          }
        });
        fileModelUI.containerMap?.remove(id);
      }
      if (isFolder && isContained) {
        initView(memberList, fileModelUI.channels, fileModelUI.groups,
            fileModelUI.messages1x1, null, null,
            containerMap: fileModelUI.containerMap);
        showErrorMessageFromString(R.string.youWereInADeletedFolder);
      } else {
        _initController.sinkAddSafe(fileModelUI);
      }
    }
  }

  void deleteFile(String fileId, {bool isFolder = false}) async {
    isLoading = true;
    final res = await _iFileRepository.deleteFile(
        teamId, fileModelUI.currentChannelId ?? "", fileId,
        force: isFolder);
    if (res is ResultError &&
        (res as ResultError).code == RemoteConstants.code_conflict) {
      showErrorMessageFromString(R.string.permissionDenied);
    }
    isLoading = false;
  }

  void downloadFile(FileModel fileModel) async {
    isLoading = true;
    final res = await _iFileRepository.downloadFile(fileModel);
    if (res is ResultSuccess<File>) {
      await OpenFile.open(res.value.path);
    }
    isLoading = false;
  }

  Future<String> conformFolderLink(FileModel file) async {
    final cname = await _prefs.getStringValue(_prefs.currentTeamCname);
    final baseUrl =
        cname.isNotEmpty ? "https://$cname" : Injector.instance.baseUrl;
    final teamName = await _prefs.getStringValue(_prefs.currentTeamName);
    String channelName = '';
    fileModelUI.channels.forEach((element) {
      if (element.id == file.cid) {
        channelName = element.titleFixed;
      }
    });
    if (channelName.isEmpty) {
      fileModelUI.groups.forEach((element) {
        if (element.id == file.cid) {
          channelName = element.titleFixed;
        }
      });
    }
    if (channelName.isEmpty) {
      fileModelUI.messages1x1.forEach((element) {
        if (element.id == file.cid) {
          channelName = element.titleFixed;
        }
      });
    }
    String uri = file.path.endsWith('/')
        ? "$baseUrl/a/#${Endpoint.teams}/$teamName${Endpoint.channels}/$channelName/files${file.path}"
        : "$baseUrl/a/#${Endpoint.teams}/$teamName${Endpoint.channels}/$channelName/files${file.path}/";
    return Uri.encodeFull(uri);
  }

  @override
  void dispose() {
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
    _initController.close();
    _filesController.close();
    _viewModeController.close();
  }
}
