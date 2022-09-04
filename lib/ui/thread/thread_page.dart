import 'package:code/_res/R.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/thread/thread_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_message_body_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/ui/thread/thread_bloc.dart';
import 'package:code/ui/thread_type_page/thread_type_page.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:code/utils/common_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:code/utils/extensions.dart';

class ThreadPage extends StatefulWidget {
  final TeamJoinedModel teamJoinedModel;
  final List<DrawerChatModel> drawerChatList;

  ThreadPage({
    required this.teamJoinedModel,
    required this.drawerChatList,
  });

  @override
  State<StatefulWidget> createState() => _ThreadState();
}

class _ThreadState extends StateWithBloC<ThreadPage, ThreadBloC> {
  @override
  void initState() {
    super.initState();
    bloc.loadThreads();
    onMessageReceivedController.listen((value) {
      bloc.onMessageArrived(value);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        TXMainAppBarWidget(
          title: R.string.allThreads,
          body: Container(
            child: StreamBuilder<List<ThreadModel>>(
              stream: bloc.threadsResult,
              initialData: [],
              builder: (ctx, snapshot) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
                  child: Column(
                    children: [
                      ..._getThreadWidgets(snapshot.data!),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        )
      ],
    );
  }

  List<Widget> _getThreadWidgets(List<ThreadModel> list) {
    return list.map((e) => _getThreadWidget(e)).toList();
  }

  Widget _getThreadWidget(ThreadModel threadModel) {
    final member = bloc.members.firstWhereOrNull(
        (element) => element.id == threadModel.parentMessage?.uid);
    final channel = bloc.channels
        .firstWhereOrNull((element) => element.id == threadModel.cid);

    List<Widget> participants = [];
    threadModel.participants.forEach((element) {
      final p = bloc.members.firstWhereOrNull((m) => m.id == element);
      if (p != null) {
        participants.add(TXTextWidget(
          text: "@${CommonUtils.getMemberUsername(p)}",
          color: R.color.secondaryColor,
          size: 14,
        ));
        participants.add(TXTextWidget(
          text: R.string.and.toLowerCase(),
          size: 14,
        ));
      }
    });
    if (participants.isNotEmpty) participants.removeLast();

    List<Widget> messages = [];
    int unread = 0;
    threadModel.childMessages.forEach((element) {
      final member =
          bloc.members.firstWhereOrNull((m) => m.id == element.uid);
      if (member != null) {
        bool isUnread = false;
        if ((threadModel.tsLastReadByUser
            ?.compareTo(element.edited ?? element.ts!) ?? 1) <
            0) {
          unread++;
          isUnread = !isUnread;
        }
        messages.add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: member.profile?.fullNameWithUsername.isUpperCase() == true ? 3.5 : 5.7),
              child: TXNetworkImage(
                imageUrl: CommonUtils.getMemberPhoto(member),
                forceLoad: true,
                placeholderImage: Image.asset(R.image.logo),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 8, bottom: 8),
                    child: Wrap(
                      spacing: 3,
                      children: <Widget>[
                        TXTextWidget(
                          text: CommonUtils.getMemberUsername(member) ?? "",
                          color: R.color.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                        TXTextWidget(
                          text: CalendarUtils.showInFormat(
                                  R.string.dateFormat3, element.ts)
                              ?.toLowerCase() ?? "",
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: element.isFile ? 0 : 8, left: 8, right: 8),
                    child: TXMessageBodyWidget(
                      message: MessageModel(
                          text: element.text,
                          html: element.html,
                          messageStatus: MessageStatus.Sent),
                    ),
                  ),
                  !element.isFile
                      ? Container()
                      : Container(
                          padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                          child: _getFile(context, element, false, member),
                        ),
                ],
              ),
            ),
            isUnread
                ? Container(
                    margin: EdgeInsets.only(top: 15, right: 5),
                    child: _getUnreadWidget(R.color.unreadThread),
                  )
                : Container(),
          ],
        ));
      }
    });

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TXTextWidget(
            text: (channel != null &&
                    (channel.isPrivateGroup || channel.isOpenChannel))
                ? channel.name ?? ""
                : "@${CommonUtils.getMemberUsername(member) ?? ""}",
            color: R.color.blackColor,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 5,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 3,
            runSpacing: 3,
            children: <Widget>[...participants],
          ),
          Card(
            child: InkWell(
              onTap: () async {
                final removed = await NavigationUtils.push(
                  context,
                  ThreadTypePage(
                    teamJoinedModel: widget.teamJoinedModel,
                    threadId: threadModel.pmid,
                    channel: channel!,
                    comeFromThreadPage: true,
                    drawerChatList: widget.drawerChatList,
                  ),
                );
                if (removed ?? false) {
                  bloc.removeThread(threadModel);
                } else {
                  setState(() {
                    threadModel.tsLastReadByUser = DateTime.now();
                  });
                }
              },
              onLongPress: () {
                showTXModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return _showThreadOptions(
                          context, unread > 0, threadModel);
                    });
              },
              child: Container(
                padding: messages.isEmpty ? EdgeInsets.all(10) : EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 2),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: member?.profile?.fullNameWithUsername.isUpperCase() == true ? 3.5 : 5.7),
                          child: TXNetworkImage(
                            imageUrl: CommonUtils.getMemberPhoto(member),
                            forceLoad: true,
                            placeholderImage: Image.asset(R.image.logo),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Wrap(
                                  spacing: 3,
                                  runSpacing: 3,
                                  alignment: WrapAlignment.start,
                                  children: <Widget>[
                                    TXTextWidget(
                                      text: CommonUtils.getMemberName(member) ?? "",
                                      color: R.color.blackColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    TXTextWidget(
                                      text: CalendarUtils.showInFormat(
                                              R.string.dateFormat3,
                                              threadModel.parentMessage?.ts)
                                          ?.toLowerCase() ?? "",
                                      color: R.color.grayColor,
                                    ),
                                    TXTextWidget(
                                      text: (channel != null &&
                                              (channel.isPrivateGroup ||
                                                  channel.isOpenChannel))
                                          ? "#${channel.name}"
                                          : "@${CommonUtils.getMemberUsername(member) ?? ""}",
                                      color: R.color.secondaryColor,
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.only(left: 8),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                                child: TXMessageBodyWidget(
                                  message: MessageModel(
                                      text: threadModel.parentMessage?.text ?? "",
                                      html: threadModel.parentMessage?.html ?? "",
                                      messageStatus: MessageStatus.Sent),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TXTextWidget(
                          text: R.string
                              .seeAnswerMessages(threadModel.numReplies),
                          color: R.color.secondaryColor,
                          size: 14,
                        ),
                        Expanded(child: TXDividerWidget())
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: <Widget>[...messages],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getUnreadWidget(Color color) => Container(
        width: 12,
        height: 12,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 1.5)),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(2.5),
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
            ),
          ],
        ),
      );

  Widget _getFile(BuildContext context, MessageModel messageModel,
      bool showMessageMemberInfo, MemberModel memberModel) {
    final fileRenderW = messageModel.fileModel?.width == null
        ? 250 / 4
        : messageModel.fileModel!.width!.toDouble() * 1 / 8;
    final fileRenderH = messageModel.fileModel?.height == null
        ? 250 / 4
        : messageModel.fileModel!.height!.toDouble() * 1 / 8;
    return AbsorbPointer(
      absorbing: messageModel.fileModel?.isUploadingDownloading ?? false,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            showMessageMemberInfo
                ? TXTextWidget(
                    text: CommonUtils.getMemberName(memberModel) ?? "",
                    color: R.color.blackColor,
                    fontWeight: FontWeight.bold,
                  )
                : Container(),
            SizedBox(
              height: showMessageMemberInfo ? 8 : 0,
            ),
            TXTextWidget(
              text: messageModel.fileModel?.titleFixed ?? "",
              color: R.color.secondaryColor,
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Stack(
                children: [
                  TXNetworkImage(
                    forceLoad: true,
                    boxFitImage: BoxFit.cover,
                    mimeType: messageModel.fileModel?.mimeType ?? "",
                    width: math.max(fileRenderW, 80),
                    height: math.max(fileRenderH, 80),
                    imageUrl: messageModel.fileModel?.link ?? "",
                    placeholderImage: Image.asset(
                      R.image.imageDefaultIcon,
                    ),
                  ),
                  messageModel.fileModel?.isUploadingDownloading == true
                      ? Container(
                          width: fileRenderW,
                          height: fileRenderH,
                          child: Center(
                            child: Container(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    R.color.primaryColor),
                                strokeWidth: 3,
                                backgroundColor: null,
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TXTextWidget(
              text:
                  "${messageModel.fileModel?.sizeFixed ?? ""} ${messageModel.fileModel?.mimeType ?? ""}",
            )
          ],
        ),
      ),
    );
  }

  Widget _showThreadOptions(
          BuildContext context, bool isUnread, ThreadModel thread) =>
      SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(maxWidth: 270),
          child: Column(
            children: [
              isUnread
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 45,
                      child: TXMenuOptionItemWidget(
                        icon: Icon(Icons.check_circle_outline),
                        text: R.string.markThreadAsRead,
                        onTap: () async {
                          await NavigationUtils.pop(context);
                          bloc.markAsRead(thread.pmid).then((value) {
                            if (value) {
                              setState(() {
                                thread.tsLastReadByUser = DateTime.now();
                              });
                            }
                          });
                        },
                      ),
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 45,
                child: TXMenuOptionItemWidget(
                  icon: Icon(Icons.close),
                  text: R.string.stopFollowingThread,
                  onTap: () async {
                    await NavigationUtils.pop(context);
                    bloc.unfollow(thread.pmid).then((value) {
                      if (value) bloc.removeThread(thread);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );
}
