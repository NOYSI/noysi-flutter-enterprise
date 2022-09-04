import 'package:code/_res/R.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_message_body_widget.dart';
import 'package:code/ui/_tx_widget/tx_pull_to_refresh_widget.dart';
import 'package:code/ui/_tx_widget/tx_search_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/ui/mention/mention_bloc.dart';
import 'package:code/ui/message_comments/message_comments_page.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:code/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MentionsPage extends StatefulWidget {
  final List<MemberModel> members;
  final TeamJoinedModel? teamJoinedModel;
  final List<DrawerChatModel>? drawerChatList;

  const MentionsPage({
    Key? key,
    required this.members,
    this.drawerChatList,
    this.teamJoinedModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MentionState();
}

class _MentionState extends StateWithBloC<MentionsPage, MentionBloC> {
  ScrollController _scrollController = new ScrollController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.init();
    bloc.popToHome.listen((value) {
      if (value)
        NavigationUtils.popUntilWithRouteAndMaterial(
            context, NavigationUtils.HomeRoute);
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        TXSearchBarAppWidget(
          title: R.string.mentions,
          onTextChange: (query) {
            bloc.query(query);
          },
          onNavBack: () {
            NavigationUtils.pop(context);
          },
          actions: <Widget>[
            StreamBuilder<bool>(
                stream: bloc.sortResult,
                initialData: true,
                builder: (context, snapshotSort) {
                  return TXIconButtonWidget(
                    icon: Icon(
                        snapshotSort.data!
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: R.color.grayLightColor),
                    onPressed: () async {
                      if (!bloc.isLoadingMentions) {
                        bloc.currentQuery = "";
                        bloc.channelMentionWrappedModel.sort =
                            bloc.channelMentionWrappedModel.sort ==
                                    CommonSort.desc
                                ? CommonSort.asc
                                : CommonSort.desc;
                        await bloc.loadMentions(isSortAction: true);
                        _scrollController
                            .jumpTo(_scrollController.position.minScrollExtent);
                      }
                    },
                  );
                }),
          ],
          body: Container(
            child: StreamBuilder<ChannelMentionWrappedModel>(
                stream: bloc.mentionResult,
                initialData: bloc.channelMentionWrappedModel,
                builder: (context, snapshot) {
                  return TXPullToRefreshWidget(
                    onRefresh: (_refreshController) async {
                      await bloc.loadMentions();
                      _refreshController.refreshCompleted();
                    },
                    onLoadMore: (_refreshController) async {
                      await bloc.loadMentions(isLoadingMore: true);
                      _refreshController.loadComplete();
                    },
                    body: _getMentionsListWidget(context, snapshot.data!),
                  );
                }),
          ),
        ),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        )
      ],
    );
  }

  Widget _getMentionsListWidget(BuildContext context,
      ChannelMentionWrappedModel channelMentionWrappedModel) {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(bottom: 60),
      itemBuilder: (ctx, index) {
        final ChannelMentionModel model =
            channelMentionWrappedModel.list[index];
        return Container(child: _getMentionWidget(model));
      },
      itemCount: channelMentionWrappedModel.list.length,
    );
  }

  Widget _getMentionWidget(ChannelMentionModel mention) {
    final member =
        widget.members.firstWhereOrNull((element) => element.id == mention.uid);

    return InkWell(
      onTap: () {
        bloc.onMessageTap(mention);
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      if(member?.isDeletedUser == false) {
                        bloc.onMentionClicked(member!.profile!.name);
                      }
                    },
                    child: TXTextWidget(
                      text: "@${CommonUtils.getMemberUsername(member)}",
                      color: R.color.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TXTextWidget(
                    text: CalendarUtils.showInFormat(
                            R.string.dateFormat1, mention.ts) ??
                        '',
                  )
                ],
              ),
            ),
            Container(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TXMessageBodyWidget(
                  message: MessageModel(
                      id: mention.mid,
                      uid: mention.uid,
                      cid: mention.cid,
                      tid: mention.tid,
                      text: mention.text,
                      html: mention.html,
                      ts: mention.ts,
                      messageStatus: MessageStatus.Sent),
                  onLinkTap: (link) async {
                    if (link.trim().isNotEmpty == true) {
                      if (link.startsWith("#file-comment")) {
                        bloc
                            .getChannelFromId(mention.tid, mention.cid)
                            .then((value) {
                          if (value != null) {
                            NavigationUtils.push(
                                context,
                                MessageCommentsPage(
                                  teamJoinedModel: widget.teamJoinedModel!,
                                  drawerChatList: widget.drawerChatList!,
                                  channel: value,
                                  parentMessageId: mention.mid,
                                ));
                          } else {
                            bloc.showErrorMessageFromString(
                                R.string.errorFetchingData);
                          }
                        });
                      } else {
                        final username = CommonUtils.getUsernameFromLink(
                            link);
                        bloc.onMentionClicked(username);
                      }
                    }
                  },
                ),
              ),
            ),
            TXDividerWidget()
          ],
        ),
      ),
    );
  }
}
