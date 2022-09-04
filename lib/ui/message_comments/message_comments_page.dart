import 'package:code/_res/R.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_cupertino_dialog_widget.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_message_body_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_reactions_all_message_widget.dart';
import 'package:code/ui/_tx_widget/tx_reactions_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/chat_text_widget/tx_chat_text_input_widget.dart';
import 'package:code/ui/edit_message/edit_message_page.dart';
import 'package:code/ui/files_explorer/files_explorer_page.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/ui/home/tx_folder_notification_widget.dart';
import 'package:code/ui/message_comments/message_comments_bloc.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:code/utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;
import 'package:code/utils/extensions.dart';
import 'package:collection/collection.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../_tx_widget/tx_alert_dialog.dart';

class MessageCommentsPage extends StatefulWidget {
  final MessageModel? messageModel;
  final String parentMessageId;
  final ChannelModel channel;
  final TeamJoinedModel teamJoinedModel;
  final List<DrawerChatModel> drawerChatList;

  const MessageCommentsPage(
      {Key? key,
      this.messageModel,
      required this.channel,
      this.parentMessageId = '',
      required this.teamJoinedModel,
      required this.drawerChatList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageCommentsState();
}

class _MessageCommentsState
    extends StateWithBloC<MessageCommentsPage, MessageCommentsBloC>
    with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  AnimationController? _animationController;

  _navBack() {
    NavigationUtils.pop(context, result: true);
  }

  @override
  void initState() {
    super.initState();
    widget.messageModel == null
        ? bloc.getMessageComments(
            tid: widget.teamJoinedModel.team.id,
            cid: widget.channel.id,
            mid: widget.parentMessageId)
        : bloc.getMessageComments(messageModel: widget.messageModel);

    _animationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 0, // initially visible
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels < 70) {
        _animationController?.reverse();
      } else {
        _animationController?.forward();
      }
    });
    bloc.messageCommentsResult.listen((value) {
      if (value != null) {
        if (_scrollController.hasClients &&
            _scrollController.position.pixels <
                _scrollController.position.minScrollExtent + 100) {
          _scrollController.animateTo(
            _scrollController.position.minScrollExtent,
            curve: Curves.ease,
            duration: const Duration(seconds: 1),
          );
        }
      }
    });
    bloc.popToHome.listen((value) {
      if (value)
        NavigationUtils.popUntilWithRouteAndMaterial(
            context, NavigationUtils.HomeRoute);
    });
    onFolderDeletedController.listen((value) {
      if (value != null) {
        bloc.onFolderDeleted(value);
      }
    });
    onFolderRenamedController.listen((value) {
      if (value != null) {
        bloc.onFolderRenamed(value);
      }
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navBack();
        return false;
      },
      child: Stack(
        children: <Widget>[
          TXMainAppBarWidget(
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FadeTransition(
              opacity: _animationController!,
              child: ScaleTransition(
                scale: _animationController!,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 140),
                  child: FloatingActionButton(
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                      color: R.color.whiteColor,
                    ),
                    backgroundColor: R.color.secondaryColor,
                    onPressed: () {
                      _scrollController.animateTo(
                        _scrollController.position.minScrollExtent,
                        curve: Curves.ease,
                        duration: const Duration(seconds: 1),
                      );
                    },
                    mini: true,
                  ),
                ),
              ),
            ),
            title: R.string.comments,
            onLeadingTap: () {
              _navBack();
            },
            body: SafeArea(
              child: Container(
                height: double.infinity,
                child: TXGestureHideKeyBoard(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        reverse: true,
                        controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 90),
                        child: Column(
                          children: [
                            StreamBuilder<MessageModel>(
                              initialData: null,
                              stream: bloc.parentMessageResult,
                              builder: (context, snapshot) =>
                                  snapshot.data == null
                                      ? Container()
                                      : _getFile(context, snapshot.data),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            StreamBuilder<List<MessageComment>?>(
                                stream: bloc.messageCommentsResult,
                                initialData: [],
                                builder: (context, snapshot) {
                                  return Column(
                                      children: _getMessageWidgetList(
                                          snapshot.data!));
                                }),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Material(
                          child: Container(
                            child: TXChatTextInputWidget(
                              isReadOnlyChannel:
                                  widget.channel.readonly ?? false,
                              showFileAttach: false,
                              onSendTap: (value) {
                                bloc.postMessageComment(
                                    value,
                                    widget.teamJoinedModel,
                                    widget.drawerChatList);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          TXLoadingWidget(
            loadingStream: bloc.isLoadingStream,
          )
        ],
      ),
    );
  }

  Widget _getFile(BuildContext context, MessageModel? messageModel) {
    final fileRenderW = messageModel?.fileModel?.width == null
        ? 250 / 4
        : messageModel!.fileModel!.width!.toDouble() * 1 / 8;
    final fileRenderH = messageModel?.fileModel?.height == null
        ? 250 / 4
        : messageModel!.fileModel!.height!.toDouble() * 1 / 8;
    final member = bloc.members
        .firstWhereOrNull((element) => element.id == messageModel?.uid);
    String? channelName =
        ((widget.channel.isPrivateGroup || widget.channel.isOpenChannel))
            ? "#${widget.channel.name}"
            : "@${CommonUtils.getMemberUsername(member)}";
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: TXTextWidget(
                      text: messageModel!.isFile
                          ? messageModel.fileModel!.titleFixed
                          : messageModel.parsedMessage,
                      color: R.color.secondaryColor,
                      maxLines: 5,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              height: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: TXNetworkImage(
                forceLoad: true,
                boxFitImage: BoxFit.cover,
                mimeType: messageModel.fileModel!.mimeType,
                width: math.max(fileRenderW, 80),
                height: math.max(fileRenderH, 80),
                imageUrl: messageModel.fileModel!.link ?? "",
                placeholderImage: Image.asset(
                  R.image.imageDefaultIcon,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TXTextWidget(
                    text: channelName.isNotEmpty
                        ? "${CalendarUtils.showInFormat(R.string.dateFormat5, messageModel.fileModel?.ts)} / ${messageModel.fileModel?.sizeFixed ?? ""} ${messageModel.fileModel?.mimeType ?? ""} / $channelName"
                        : "${CalendarUtils.showInFormat(R.string.dateFormat5, messageModel.fileModel?.ts)} / ${messageModel.fileModel?.sizeFixed ?? ""} ${messageModel.fileModel?.mimeType ?? ""}",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getMessageWidgetList(List<MessageComment> messageList) {
    return messageList.map((message) {
      final member = bloc.members.firstWhereOrNull((m) => m.id == message.uid);
      return _getMessage(member!, message);
    }).toList();
  }

  Widget _getMessage(MemberModel member, MessageComment messageComment) {
    MessageModel messageModel = MessageModel(
        folders: messageComment.folders,
        ts: messageComment.ts,
        text: messageComment.text,
        html: messageComment.html,
        reactions: messageComment.reactions,
        links: messageComment.links,
        id: messageComment.id,
        uid: messageComment.uid,
        messageStatus: MessageStatus.Sent,
        tid: messageComment.tid,
        cid: messageComment.cid,
        extra: messageComment.extra,
        mid: messageComment.mid);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: member.profile!.fullNameWithUsername.isUpperCase()
                        ? 3.5
                        : 5.7),
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
                      padding: EdgeInsets.only(left: 8),
                      child: Wrap(
                        spacing: 3,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              if(!member.isDeletedUser) {
                                bloc.onMentionClicked(member.profile!.name);
                              }
                            },
                            child: TXTextWidget(
                              text: CommonUtils.getMemberName(member) ?? "",
                              color: R.color.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TXTextWidget(
                            text: CalendarUtils.showInFormat(
                                    R.string.dateFormat3, messageModel.ts)!
                                .toLowerCase(),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onLongPress: () {
                        bloc.currentMessageSelected = messageModel;
                        showTXModalBottomSheetAutoAdjustable(
                            context: context,
                            builder: (context) {
                              FocusScope.of(context).unfocus();
                              return _showMessageOptions(context);
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: Column(
                          children: [
                            TXMessageBodyWidget(
                              message: messageModel,
                              onLinkTap: (link) async {
                                if (link.startsWith("http")) {
                                  if (await canLaunchUrlString(link)) {
                                    await launchUrlString(link);
                                  }
                                } else {
                                  final username =
                                      CommonUtils.getUsernameFromLink(
                                          link);
                                  bloc.onMentionClicked(username);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    messageModel.isFolderLinkMessage
                        ? Container(
                            padding: EdgeInsets.only(left: 8, right: 8),
                            child: TXFolderNotificationWidget(
                              message: messageModel,
                              onFolderTap: (FolderModel folder) async {
                                if (folder.deleted) {
                                  bloc.showErrorMessageFromString(
                                      R.string.folderDeleted);
                                } else {
                                  final path =
                                      (await bloc.resolveFolderReference(
                                                  folder.tid,
                                                  folder.cid,
                                                  folder.id))
                                              ?.path ??
                                          '';
                                  folder.path = path;
                                  if (folder.path.isNotEmpty)
                                    navigateToFiles(context, folder);
                                  else
                                    bloc.showErrorMessageFromString(
                                        R.string.folderIsNotInAvailableChannel);
                                }
                              },
                              onLongPress: () {
                                bloc.currentMessageSelected = messageModel;
                                showTXModalBottomSheetAutoAdjustable(
                                    context: context,
                                    builder: (context) {
                                      FocusScope.of(context).unfocus();
                                      return _showMessageOptions(context);
                                    });
                              },
                            ),
                          )
                        : Container(),
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 5),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 3,
                        runSpacing: 3,
                        children: <Widget>[
                          ..._getReactions(context, messageModel),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _getReactions(BuildContext context, MessageModel? message) {
    List<Widget> list = [];
    message?.reactions.forEach((element) {
      if (element.userIds.isNotEmpty) {
        final w = InkWell(
          onTap: () {
            bloc.currentMessageSelected = message;
            bloc.addRemoveReaction(element.reactionKey);
            bloc.currentMessageSelected = null;
          },
          child: IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: R.color.secondaryColor.lighten(.4),
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                border: Border.all(color: R.color.secondaryColor, width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "${R.image.reactionBase}${element.reactionKey}.gif",
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TXTextWidget(
                    text: "${element.userIds.length}",
                    color: R.color.blackColor,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
            ),
          ),
        );
        list.add(w);
      }
    });

    if (message?.reactions.isNotEmpty == true && list.isNotEmpty) {
      final w = InkWell(
        onTap: () {
          showTXModalBottomSheet(
              context: context,
              builder: (context) {
                return TXReactionsAllMessageWidget(
                  messageModel: message,
                );
              });
        },
        child: Container(
          padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
          child: TXTextWidget(
            text: R.string.seeAll,
            color: R.color.secondaryColor,
            size: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      list.add(w);
    }
    return list;
  }

  Widget _showMessageOptions(BuildContext context) {
    final isOwner =
        bloc.currentMessageSelected?.uid == bloc.inMemoryData.currentMember?.id;
    final canDeleteMessage = isOwner ||
        (bloc.inMemoryData.currentMember?.userRol == UserRol.Admin &&
            bloc.inMemoryData.currentTeam!.adminsCanDelete!);
    return Container(
      //constraints: BoxConstraints(maxHeight: canDeleteMessage ? 200 : 270),
      child: Column(
        children: <Widget>[
          Container(
            height: 45,
            child: TXMenuOptionItemWidget(
              icon: Icon(Icons.link, color: R.color.grayColor),
              text: R.string.copyPermanentLink,
              padding: EdgeInsets.symmetric(horizontal: 10),
              onTap: () async {
                await NavigationUtils.pop(context);
                final link = await bloc.conformMessageLink();
                await Clipboard.setData(new ClipboardData(text: link));
                Fluttertoast.showToast(
                    msg: link,
                    toastLength: Toast.LENGTH_LONG,
                    textColor: R.color.whiteColor,
                    backgroundColor: R.color.primaryColor);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 45,
            child: TXMenuOptionItemWidget(
              icon: Icon(Icons.insert_emoticon, color: R.color.grayColor),
              text: R.string.addReaction,
              onTap: () async {
                await NavigationUtils.pop(context);
                showTXModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return _showReactions(context);
                    });
              },
            ),
          ),
          isOwner
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    icon: Icon(Icons.edit, color: R.color.grayColor),
                    text: R.string.edit,
                    onTap: () async {
                      await NavigationUtils.pop(context);
                      final res = await NavigationUtils.push(
                          context,
                          EditMessagePage(
                            model: bloc.currentMessageSelected!,
                          ));
                      if ((res is MessageModel)) {
                        bloc.updateMessageTextAfterEdit(res);
                      }
                    },
                  ),
                )
              : Container(),
          canDeleteMessage
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    icon: Icon(Icons.delete_forever, color: Colors.redAccent),
                    text: R.string.remove,
                    textColor: Colors.redAccent,
                    onTap: () async {
                      await NavigationUtils.pop(context);
                      _showDialogRemoveMessage(context: context);
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _showReactions(BuildContext context) {
    return TXReactionsWidget(
      onReactionSelected: (reactionKey) async {
        await NavigationUtils.pop(context);
        bloc.addRemoveReaction(reactionKey);
      },
    );
  }

  void _showDialogRemoveMessage({required BuildContext context}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => TXCupertinoDialogWidget(
        title: R.string.deleteMessageTitle,
        content: R.string.deleteMessageContent,
        onOK: () async {
          await NavigationUtils.pop(context);
          bloc.deleteMessage();
        },
        onCancel: () {
          NavigationUtils.pop(context);
        },
      ),
    );
  }

  void navigateToFiles(BuildContext context, FolderModel? selectedFolder) {
    if (selectedFolder != null &&
        selectedFolder.tid != widget.teamJoinedModel.team.id) {
      bloc.showErrorMessageFromString(R.string.folderIsNotInCurrentTeam);
    } else {
      NavigationUtils.push(
          context,
          FilesExplorerPage(
            channels: widget.teamJoinedModel.channels,
            groups: widget.teamJoinedModel.groups,
            messages1x1: widget.teamJoinedModel.messages1x1,
            members: widget.teamJoinedModel.memberWrapperModel.list,
            selectedFolder: selectedFolder,
          ));
    }
  }
}
