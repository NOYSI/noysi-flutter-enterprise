import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/thread/thread_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/TXAudioPlayer/tx_audio_player_widget.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_cupertino_dialog_widget.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_reactions_all_message_widget.dart';
import 'package:code/ui/_tx_widget/tx_reactions_widget.dart';
import 'package:code/ui/_tx_widget/tx_video_player.dart';
import 'package:code/ui/chat_text_widget/tx_chat_text_input_widget.dart';
import 'package:code/ui/_tx_widget/tx_checkbox_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_message_body_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/edit_message/edit_message_page.dart';
import 'package:code/ui/files_explorer/files_explorer_page.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/ui/home/tx_folder_notification_widget.dart';
import 'package:code/ui/message_comments/message_comments_page.dart';
import 'package:code/ui/thread_type_page/thread_type_bloc.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:code/utils/common_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;
import 'package:code/utils/extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../enums.dart';
import '../_tx_widget/tx_alert_dialog.dart';

class ThreadTypePage extends StatefulWidget {
  final String threadId;
  final ChannelModel channel;
  final MessageModel? messageModel;
  final bool comeFromThreadPage;
  final TeamJoinedModel teamJoinedModel;
  final List<DrawerChatModel> drawerChatList;

  const ThreadTypePage(
      {Key? key,
      required this.teamJoinedModel,
      required this.threadId,
      required this.channel,
      this.messageModel,
      required this.drawerChatList,
      this.comeFromThreadPage = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ThreadTypeState();
}

class _ThreadTypeState extends StateWithBloC<ThreadTypePage, ThreadTypeBloC>
    with SingleTickerProviderStateMixin {
  String userTyping = "";
  final inMemoryData = Injector.instance.inMemoryData;
  DateTime? userTypingMark;
  ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    if (widget.messageModel == null)
      bloc.checkIsBeingFollowed(widget.threadId, widget.comeFromThreadPage);
    bloc.loadThread(widget.threadId, widget.channel,
        messageModel: widget.messageModel);
    onMessageReceivedController.listen((value) async {
      bloc.onMessageArrived(value);
    });
    onUserTypingChannelController.listen((value) {
      final member = inMemoryData
          .getMembers()
          .firstWhereOrNull((element) => element.id == value.uid);
      if (member != null &&
          member.userPresence == UserPresence.online &&
          member.id != inMemoryData.currentMember?.id) {
        userTypingMark = DateTime.now();
        if (mounted)
          setState(() {
            userTyping = CommonUtils.getMemberUsername(member) ?? "";
            Future.delayed(Duration(seconds: 3), () {
              final dif = DateTime.now().difference(userTypingMark!);
              if (dif.inSeconds > 2)
                setState(() {
                  userTyping = "";
                });
            });
          });
      }
    });
    onNotifyThreadController.listen((value) {
      bloc.onThreadDeleted(value);
    });
    bloc.popToHome.listen((value) {
      if (value)
        NavigationUtils.popUntilWithRouteAndMaterial(
            context, NavigationUtils.HomeRoute);
    });
    bloc.messageArrivedForThisThread.listen((value) {
      if ((value) &&
          _scrollController.hasClients == true &&
          _scrollController.position.pixels <
              _scrollController.position.minScrollExtent + 140) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          curve: Curves.ease,
          duration: const Duration(seconds: 1),
        );
      }
    });
    onFolderRenamedController.listen((value) {
      if (value != null) bloc.onFolderRenamed(value);
    });
    onFolderDeletedController.listen((value) {
      if (value != null) bloc.onFolderDeleted(value);
    });
    _animationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 0, // initially visible
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels < 90) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: [
        TXMainAppBarWidget(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FadeTransition(
            opacity: _animationController,
            child: ScaleTransition(
              scale: _animationController,
              child: Padding(
                padding: EdgeInsets.only(bottom: 150),
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
          actions: [
            widget.messageModel == null
                ? PopupMenuButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: R.color.whiteColor,
                    ),
                    itemBuilder: (ctx) => popupMenuItems(),
                  )
                : Container()
          ],
          title: R.string.thread,
          body: SafeArea(
            child: Container(
              child: StreamBuilder<ThreadModel>(
                  stream: bloc.threadResult,
                  initialData: null,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) return Container();

                    final threadModel = snapshot.data!;
                    final member = bloc.members.firstWhereOrNull((element) =>
                        element.id == threadModel.parentMessage?.uid);

                    final chatName = ((widget.channel.isPrivateGroup ||
                            widget.channel.isOpenChannel))
                        ? "#${widget.channel.name}"
                        : "@${CommonUtils.getMemberUsername(member) ?? ""}";
                    return Container(
                      height: double.infinity,
                      child: Stack(
                        children: <Widget>[
                          TXGestureHideKeyBoard(
                            child: Container(
                              child: SingleChildScrollView(
                                padding: EdgeInsets.only(bottom: 130),
                                controller: _scrollController,
                                physics: BouncingScrollPhysics(),
                                reverse: true,
                                child: Column(
                                  children: <Widget>[
                                    _getHeader(member, chatName, threadModel),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ..._getMessageWidgetList(
                                        threadModel.childMessages),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Material(
                              child: Column(
                                children: <Widget>[
                                  TXChatTextInputWidget(
                                    isReadOnlyChannel:
                                        bloc.channelModel.readonly ?? false,
                                    onSendTap: (value) {
                                      bloc.sendMessageThread(
                                          value,
                                          widget.teamJoinedModel,
                                          widget.drawerChatList);
                                    },
                                    pmid: snapshot.data?.pmid ?? "",
                                    showOnChannel: (value) {
                                      bloc.publishInChannel = value;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        ),
      ],
    );
  }

  List<Widget> _getMessageWidgetList(List<MessageModel> messageList) {
    return messageList.map((message) {
      final member = bloc.members.firstWhereOrNull((m) => m.id == message.uid);
      return _getMessage(member, message);
    }).toList();
  }

  Widget _getHeader(
      MemberModel? member, String chatName, ThreadModel threadModel) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: member?.profile?.fullNameWithUsername.isUpperCase() ==
                          true
                      ? 3.5
                      : 5.7),
              child: TXNetworkImage(
                imageUrl: CommonUtils.getMemberPhoto(member),
                forceLoad: true,
                placeholderImage: Image.asset(R.image.logo),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Wrap(
                      spacing: 3,
                      runSpacing: 3,
                      alignment: WrapAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if(member?.isDeletedUser == false) {
                              bloc.onMentionClicked(member?.profile?.name ?? '');
                            }
                          },
                          child: TXTextWidget(
                            text: CommonUtils.getMemberName(member) ?? "",
                            color: R.color.blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TXTextWidget(
                          text: CalendarUtils.showInFormat(R.string.dateFormat3,
                                      threadModel.parentMessage?.ts)
                                  ?.toLowerCase() ??
                              "",
                          color: R.color.grayColor,
                        ),
                        TXTextWidget(
                          text: chatName,
                          color: R.color.secondaryColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8, top: 8),
                    child: TXMessageBodyWidget(
                      message: MessageModel(
                          text: threadModel.parentMessage?.text ?? "",
                          html: threadModel.parentMessage?.html,
                          messageStatus: MessageStatus.Sent),
                      onLinkTap: (link) async {
                        if (link.startsWith("#file-comment")) {
                          NavigationUtils.push(
                              context,
                              MessageCommentsPage(
                                teamJoinedModel: widget.teamJoinedModel,
                                drawerChatList: widget.drawerChatList,
                                channel: widget.channel,
                                parentMessageId:
                                    threadModel.parentMessage?.mid ?? "",
                              ));
                        } else {
                          final username = CommonUtils.getUsernameFromLink(
                              link);
                          bloc.onMentionClicked(username);
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getMessage(MemberModel? member, MessageModel messageModel) {
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
                    top: member?.profile?.fullNameWithUsername.isUpperCase() ==
                            true
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
                              if(member?.isDeletedUser == false) {
                                bloc.onMentionClicked(
                                    member?.profile?.name ?? "");
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
                                        R.string.dateFormat5, messageModel.ts)
                                    ?.toLowerCase() ??
                                "",
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
                              FocusScope.of(context).requestFocus(FocusNode());
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
                                if (link.startsWith("#file-comment")) {
                                  NavigationUtils.push(
                                      context,
                                      MessageCommentsPage(
                                        teamJoinedModel: widget.teamJoinedModel,
                                        drawerChatList: widget.drawerChatList,
                                        channel: widget.channel,
                                        parentMessageId: messageModel.mid ?? "",
                                      ));
                                } else {
                                  final username =
                                      CommonUtils.getUsernameFromLink(
                                          link);
                                  bloc.onMentionClicked(username);
                                }
                              },
                            ),
                            !messageModel.isFile
                                ? Container()
                                : Container(
                                    //padding: EdgeInsets.all(8),
                                    child: _getFile(
                                        context, messageModel, false, member),
                                  ),
                            messageModel.isFolderLinkMessage
                                ? TXFolderNotificationWidget(
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
                                          bloc.showErrorMessageFromString(R
                                              .string
                                              .folderIsNotInAvailableChannel);
                                      }
                                    },
                                    onLongPress: () {
                                      bloc.currentMessageSelected =
                                          messageModel;
                                      showTXModalBottomSheetAutoAdjustable(
                                          context: context,
                                          builder: (context) {
                                            FocusScope.of(context).unfocus();
                                            return _showMessageOptions(context);
                                          });
                                    },
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
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

  Widget _getFile(BuildContext context, MessageModel? messageModel,
      bool showMessageMemberInfo, MemberModel? memberModel) {
    final fileRenderW = messageModel?.fileModel?.width == null
        ? 250 / 4
        : messageModel!.fileModel!.width!.toDouble() * 1 / 8;
    final fileRenderH = messageModel?.fileModel?.height == null
        ? 250 / 4
        : messageModel!.fileModel!.height!.toDouble() * 1 / 8;

    final isAudio =
        messageModel?.fileModel?.mimeType.startsWith("audio") == true;
    final isVideo =
        messageModel?.fileModel?.mimeType.startsWith("video") == true;
    final isApp =
        messageModel?.fileModel?.mimeType.startsWith("application") == true;

    final isAudioVideoApp = isVideo || isAudio || isApp;

    return AbsorbPointer(
      absorbing: messageModel?.fileModel?.isUploadingDownloading ?? false,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            showMessageMemberInfo
                ? TXTextWidget(
                    text: CommonUtils.getMemberName(memberModel) ?? "",
                    color: R.color.blackColor,
                    fontWeight: FontWeight.bold,
                    size: 16,
                  )
                : Container(),
            SizedBox(
              height: showMessageMemberInfo ? 8 : 0,
            ),
            TXTextWidget(
              text: messageModel?.fileModel?.titleFixed ?? "",
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
                  !isAudio && !isVideo
                      ? TXNetworkImage(
                          forceLoad: true,
                          boxFitImage: BoxFit.cover,
                          mimeType: messageModel?.fileModel?.mimeType ?? "",
                          width: isAudioVideoApp
                              ? math.min(fileRenderW, 80)
                              : math.max(fileRenderW, 80),
                          height: math.max(fileRenderH, 80),
                          imageUrl: messageModel?.fileModel?.link ?? "",
                          placeholderImage: Image.asset(
                            messageModel?.fileModel?.mimeType
                                        .startsWith("image") ==
                                    true
                                ? R.image.imageDefaultIcon
                                : R.image.logo,
                            fit: BoxFit.cover,
                          ),
                        )
                      : !isVideo
                          ? TXAudioPlayer(
                              link: messageModel?.fileModel?.link,
                              mimeType: messageModel?.fileModel?.mimeType)
                          : TXVideoPlayer(
                              link: messageModel?.fileModel?.link ?? ''),
                  messageModel?.fileModel?.isUploadingDownloading == true
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
                  "${messageModel?.fileModel?.sizeFixed ?? ""} ${messageModel?.fileModel?.mimeType ?? ""}",
            )
          ],
        ),
      ),
    );
  }

  List<PopupMenuItem> popupMenuItems() {
    final follow = PopupMenuItem(
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.chat_bubble, color: R.color.grayColor),
        text: R.string.followThread,
        onTap: () {
          NavigationUtils.pop(context);
          bloc.follow(widget.threadId);
        },
      ),
    );

    final unfollow = PopupMenuItem(
      child: TXMenuOptionItemWidget(
        icon: Icon(Icons.close, color: R.color.grayColor),
        text: R.string.stopFollowingThread,
        onTap: () async {
          NavigationUtils.pop(context);
          final res = await bloc.unfollow(widget.threadId);
          if (res) {
            NavigationUtils.pop(context, result: res);
          }
        },
      ),
    );

    return [bloc.isBeingFollowed ? unfollow : follow];
  }

  Widget _showMessageOptions(BuildContext context) {
    final isOwner =
        bloc.currentMessageSelected?.uid == bloc.inMemoryData.currentMember?.id;
    final isFile = bloc.currentMessageSelected?.isFile == true;
    //final isFavorite = bloc.currentMessageSelected?.favorite == true;
    final canDeleteMessage = isOwner ||
        (bloc.inMemoryData.currentMember?.userRol == UserRol.Admin &&
            widget.teamJoinedModel.team.adminsCanDelete == true);
    return Container(
      //constraints: BoxConstraints(maxHeight: canDeleteMessage ? 180 : 160),
      child: Column(
        children: <Widget>[
          // Container(
          //   height: 45,
          //   child: TXMenuOptionItemWidget(
          //     icon: Icon(Icons.link, color: R.color.grayColor),
          //     text: R.string.copyPermanentLink,
          //     padding: EdgeInsets.symmetric(horizontal: 10),
          //     onTap: () async {
          //       await NavigationUtils.pop(context);
          //       final link = bloc.conformMessageLink();
          //       await Clipboard.setData(new ClipboardData(text: link));
          //       Fluttertoast.showToast(msg: link);
          //     },
          //   ),
          // ),
          Container(
            height: 45,
            child: TXMenuOptionItemWidget(
              padding: EdgeInsets.symmetric(horizontal: 10),
              icon: Icon(isFile ? Icons.comment : Icons.content_copy,
                  color: R.color.grayColor),
              text: isFile
                  ? "${R.string.addComment} ${bloc.currentMessageSelected?.fileModel?.comments ?? ""}"
                  : R.string.copyMessage,
              onTap: () async {
                await NavigationUtils.pop(context);
                if (isFile) {
                  NavigationUtils.push(
                      context,
                      MessageCommentsPage(
                        messageModel: bloc.currentMessageSelected!,
                        channel: widget.channel,
                        teamJoinedModel: widget.teamJoinedModel,
                        drawerChatList: widget.drawerChatList,
                      ));
                } else {
                  await Clipboard.setData(new ClipboardData(
                      text: bloc.currentMessageSelected?.text ?? ""));
                  Fluttertoast.showToast(
                      msg: R.string.copiedToClipboard,
                      toastLength: Toast.LENGTH_LONG,
                      textColor: R.color.whiteColor,
                      backgroundColor: R.color.primaryColor);
                }
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
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   height: 45,
          //   child: TXMenuOptionItemWidget(
          //     icon: Icon(isFavorite ? Icons.star : Icons.star_border,
          //         color: isFavorite ? R.color.orange : R.color.grayColor),
          //     text: isFavorite
          //         ? R.string.removeFromFavorites
          //         : R.string.favorite,
          //     onTap: () async {
          //       await NavigationUtils.pop(context);
          //       bloc.setFavoriteMessage(bloc.currentMessageSelected);
          //     },
          //   ),
          // ),
          isOwner && !isFile
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
          isFile
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  child: TXMenuOptionItemWidget(
                    icon: Icon(Icons.cloud_download, color: R.color.grayColor),
                    text: R.string.download,
                    onTap: () async {
                      await NavigationUtils.pop(context);
                      bloc.downloadFile();
                    },
                  ),
                )
              : Container(),
          // isFile
          //     ? Container(
          //   height: 45,
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: TXMenuOptionItemWidget(
          //     icon: Icon(Icons.share, color: R.color.grayColor),
          //     text: R.string.share,
          //     onTap: () async {
          //       await NavigationUtils.pop(context);
          //       final res = await NavigationUtils.push(
          //           context,
          //           ShareFilePage(
          //             fileModel: bloc.currentMessageSelected.fileModel,
          //           ));
          //       if (res != null) {
          //         bloc.changeChannelAuto(
          //             ChannelCreatedUI(channelModel: res, members: []));
          //       }
          //     },
          //   ),
          // )
          //     : Container(),
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

  void _showDialogRemoveMessage({required BuildContext context}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => TXCupertinoDialogWidget(
        title: R.string.deleteMessageTitle,
        content: R.string.deleteMessageContent,
        onOK: () async {
          await NavigationUtils.pop(context);
          bloc.deleteThreadMessage();
        },
        onCancel: () {
          NavigationUtils.pop(context);
        },
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

  List<Widget> _getReactions(BuildContext context, MessageModel message) {
    List<Widget> list = [];
    message.reactions.forEach((element) {
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

    if (message.reactions.isNotEmpty == true && list.isNotEmpty) {
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

  void navigateToFiles(BuildContext context, FolderModel selectedFolder) {
    if (selectedFolder.tid != widget.teamJoinedModel.team.id) {
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
