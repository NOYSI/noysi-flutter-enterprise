import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:rxdart/rxdart.dart';
import 'package:code/utils/extensions.dart';

import '../../enums.dart';

class LinkBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final IChannelRepository _iChannelRepository;

  LinkBloC(this._iChannelRepository);

  @override
  void dispose() {
    _linkController.close();
    _sortController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  BehaviorSubject<ChannelLinkWrappedModel> _linkController =
      new BehaviorSubject();

  Stream<ChannelLinkWrappedModel> get linkResult => _linkController.stream;

  BehaviorSubject<bool> _sortController = new BehaviorSubject();

  Stream<bool> get sortResult => _sortController.stream;

  int max = 25;
  int offset = 0;
  bool isLoadingLinks = false;
  String currentQuery = "";
  late ChannelLinkWrappedModel channelLinkWrappedModel;
  Map<String, ChannelLinkModel> linksAll = {};

  void init() {
    linksAll.clear();
    channelLinkWrappedModel = ChannelLinkWrappedModel(list: [], total: 0, sort: CommonSort.desc);
    loadLinks();
  }

  Future<void> loadLinks({isLoadingMore = false, isSortAction = false}) async {
    offset = isLoadingMore ? offset += max : 0;

    _sortController
        .sinkAddSafe(channelLinkWrappedModel.sort == CommonSort.desc);

    isLoadingLinks = true;
    final res = await _iChannelRepository.geChannelLinks(
        max: max, offset: offset, sort: channelLinkWrappedModel.sort);
    if (res is ResultSuccess<ChannelLinkWrappedModel>) {
      if(isSortAction || !isLoadingMore)
        linksAll.clear();

      res.value.list.forEach((element) {
        linksAll[element.channelLinkId] = element;
      });
      channelLinkWrappedModel.total = res.value.total;
      query(currentQuery);
    } else
      showErrorMessage(res);
    isLoadingLinks = false;
  }

  void query(String q) {
    currentQuery = q;
    channelLinkWrappedModel.list.clear();
    if (currentQuery.isEmpty) {
      channelLinkWrappedModel.list.addAll(linksAll.values.toList());
    } else {
      final filterList = linksAll.values
          .toList()
          .where((element) => element.text
              .trim()
              .toLowerCase()
              .contains(currentQuery.trim().toLowerCase()))
          .toList();
      channelLinkWrappedModel.list = filterList;
    }
    sortByDate();
  }

  void sortByDate() {
    if (channelLinkWrappedModel.list.length >= 2)
      channelLinkWrappedModel.list.sort((v1, v2) =>
      channelLinkWrappedModel.sort == CommonSort.desc
          ? v2.ts!.compareTo(v1.ts!)
          : v1.ts!.compareTo(v2.ts!));
    _linkController.sinkAddSafe(channelLinkWrappedModel);
  }
}
