import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/file/file_model.dart';
import 'package:code/domain/single_selection_model.dart';

import '../../enums.dart';

class FileModelUI {
  bool isRootView;
  List<SingleSelectionModel>? breadCrumbList;
  Map<String, ParentContainerUI>? containerMap;
  ChannelModel? noysiChannel;
  List<ChannelModel> channels;
  List<ChannelModel> messages1x1;
  List<ChannelModel> groups;
  SortFileMode? sortMode;
  ParentContainerUI? currentParentContainer;
  String? currentChannelId;

  FileModelUI({
    this.isRootView = true,
    this.currentParentContainer,
    this.breadCrumbList,
    this.noysiChannel,
    this.currentChannelId = '',
    required this.channels,
    required this.messages1x1,
    required this.groups,
    this.sortMode,
  });
}

class ParentContainerUI {
  String? id;
  String? name;
  String? path;
  String? cid;
  int total;
  int offset;
  List<FileModel>? folders;
  List<FileModel>? files;

  ParentContainerUI({
    this.id,
    required this.cid,
    this.name,
    this.folders,
    this.files,
    this.path,
    this.total = 0,
    this.offset = 0,
  });
}
