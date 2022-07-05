import 'package:code/data/api/remote/result.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/channel/i_channel_repository.dart';
import 'package:code/domain/message/i_message_repository.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/user/i_user_repository.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:code/utils/extensions.dart';
import 'package:collection/collection.dart';

class MentionBloC extends BaseBloC with LoadingBloC, ErrorHandlerBloC {
  final IChannelRepository _iChannelRepository;
  final IMessageRepository _iMessageRepository;
  final InMemoryData inMemoryData;
  final IUserRepository _iUserRepository;

  MentionBloC(this._iChannelRepository, this._iUserRepository,
      this.inMemoryData, this._iMessageRepository);

  @override
  void dispose() {
    _mentionController.close();
    _sortController.close();
    popToHome.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  BehaviorSubject<ChannelMentionWrappedModel> _mentionController =
      new BehaviorSubject();

  Stream<ChannelMentionWrappedModel> get mentionResult =>
      _mentionController.stream;

  BehaviorSubject<bool> _sortController = new BehaviorSubject();

  Stream<bool> get sortResult => _sortController.stream;

  BehaviorSubject<bool> popToHome = new BehaviorSubject.seeded(false);

  int max = 25;
  int offset = 0;
  bool isLoadingMentions = false;
  String currentQuery = "";
  Map<String, ChannelMentionModel> mentionsAll = {};
  bool hasMoreMentions = false;
  late ChannelMentionWrappedModel channelMentionWrappedModel;

  void init() {
    mentionsAll.clear();
    channelMentionWrappedModel =
        ChannelMentionWrappedModel(list: [], total: 0, sort: CommonSort.desc);
    loadMentions();
  }

  Future<void> loadMentions(
      {isLoadingMore = false, isSortAction = false}) async {
    offset = isLoadingMore ? offset += max : 0;

    _sortController
        .sinkAddSafe(channelMentionWrappedModel.sort == CommonSort.desc);

    isLoadingMentions = true;
    final res = await _iChannelRepository.geChannelMentions(
        max: max, offset: offset, sort: channelMentionWrappedModel.sort);
    if (res is ResultSuccess<ChannelMentionWrappedModel>) {
      if (isSortAction || !isLoadingMore) mentionsAll.clear();

      res.value.list.forEach((element) {
        mentionsAll[element.channelMentionId] = element;
      });
      channelMentionWrappedModel.total = res.value.total;
      hasMoreMentions = mentionsAll.length < res.value.total;

      query(currentQuery);
    } else
      showErrorMessage(res);
    isLoadingMentions = false;
  }

  void query(String q) {
    currentQuery = q;
    channelMentionWrappedModel.list.clear();
    if (currentQuery.isEmpty) {
      channelMentionWrappedModel.list.addAll(mentionsAll.values.toList());
    } else {
      final filterList = mentionsAll.values
          .toList()
          .where((element) => element.text
              .trim()
              .toLowerCase()
              .contains(currentQuery.trim().toLowerCase()))
          .toList();
      channelMentionWrappedModel.list = filterList;
    }
    sortByDate();
  }

  void sortByDate() {
    if (channelMentionWrappedModel.list.length >= 2)
      channelMentionWrappedModel.list.sort((v1, v2) =>
          channelMentionWrappedModel.sort == CommonSort.desc
              ? v2.ts!.compareTo(v1.ts!)
              : v1.ts!.compareTo(v2.ts!));

    _mentionController.sinkAddSafe(channelMentionWrappedModel);
  }

  void onMentionClicked(String username) async {
    if (username.isNotEmpty &&
        username != 'channel' &&
        username != 'all' &&
        username != inMemoryData.currentMember!.profile!.name) {
      final membersInMemory = inMemoryData.getMembers(
          excludeMe: true, teamId: inMemoryData.currentTeam?.id);
      final memberIsInMemory = membersInMemory
          .firstWhereOrNull((element) => element.profile!.name == username);
      if (memberIsInMemory == null) {
        final membersQuery = await _iUserRepository.getTeamMembers(
            inMemoryData.currentTeam!.id,
            max: 1,
            offset: 0,
            action: "search",
            active: true,
            query: username);
        if (membersQuery is ResultSuccess<MemberWrapperModel> &&
            membersQuery.value.list.isNotEmpty &&
            membersQuery.value.list[0].profile?.name == username) {
          final member = membersQuery.value.list[0];
          final res = await _iChannelRepository.create1x1Channel(member);
          if (res is ResultSuccess<ChannelModel>) {
            popToHome.sinkAddSafe(true);
            changeChannelAutoController.sinkAddSafe(
                ChannelCreatedUI(members: [member], channelModel: res.value));
          } else {
            //showErrorMessage(res);
          }
        }
      } else {
        final res =
            await _iChannelRepository.create1x1Channel(memberIsInMemory);
        if (res is ResultSuccess<ChannelModel>) {
          popToHome.sinkAddSafe(true);
          changeChannelAutoController.sinkAddSafe(ChannelCreatedUI(
              members: [memberIsInMemory], channelModel: res.value));
        } else {
          //showErrorMessage(res);
        }
      }
    }
  }

  Future<ChannelModel?> getChannelFromId(String tid, String cid) async {
    final res = await _iChannelRepository.getChannel(tid, cid);
    if (res is ResultSuccess<ChannelModel>) return res.value;
    return null;
  }

  void onMessageTap(ChannelMentionModel mention) async {
    isLoading = true;
    final resMessage = await _iMessageRepository.getMessage(
        mention.tid, mention.cid, mention.mid);
    if (resMessage is ResultSuccess<MessageModel>) {
      final res =
          await _iChannelRepository.getChannel(mention.tid, mention.cid);
      if (res is ResultSuccess<ChannelModel>) {
        popToHome.sinkAddSafe(true);
        changeChannelAutoController.sinkAddSafe(ChannelCreatedUI(
            members: [],
            channelModel: res.value,
            lastReadMessage: resMessage.value,
            fromSearchMessage: true));
      } else
        showErrorMessage(res);
    } else
      showErrorMessage(resMessage);
    isLoading = false;
  }
}
