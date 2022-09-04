import 'dart:async';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/ui/_tx_widget/TXAudioPlayer/tx_audio_player_widget.dart';
import 'package:code/ui/_tx_widget/tx_message_body_widget.dart';
import 'package:code/ui/_tx_widget/tx_video_player.dart';
import 'package:code/ui/home/tx_folder_notification_widget.dart';
import 'package:code/ui/message_comments/message_comments_page.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:code/utils/common_utils.dart';
import 'package:code/utils/extensions.dart';
import 'package:code/_res/R.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_reactions_all_message_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/favorites/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:math' as math;

import '../home/home_ui_model.dart';
import '../home/tx_task_notification_widget.dart';

class FavoritesPage extends StatefulWidget {
  final TeamJoinedModel joinedTeam;
  final List<DrawerChatModel> drawerChatList;

  const FavoritesPage({required this.joinedTeam, required this.drawerChatList});

  @override
  State<StatefulWidget> createState() => _FavoritesState();
}

class _FavoritesState extends StateWithBloC<FavoritesPage, FavoritesBloC> {
  StreamSubscription? ssMessage, ssPopHome, ssFolderRenamed, ssFolderDeleted;
  bool reversed = false;

  @override
  void initState() {
    super.initState();
    ssMessage = onMessageReceivedController.listen((value) {
      if (value.messageStatus == MessageStatus.Updated)
        bloc.onMessageEdited(value);
    });
    ssPopHome = bloc.popToHome.listen((value) {
      if (value)
        NavigationUtils.popUntilWithRouteAndMaterial(
            context, NavigationUtils.HomeRoute);
    });
    ssFolderRenamed = onFolderRenamedController.listen((value) {
      if (value != null) {
        bloc.onFolderRenamed(value);
      }
    });
    ssFolderDeleted = onFolderDeletedController.listen((value) {
      if (value != null) {
        bloc.onFolderDeleted(value);
      }
    });
    bloc.initView(widget.joinedTeam);
  }

  @override
  void dispose() {
    ssMessage?.cancel();
    ssPopHome?.cancel();
    ssFolderDeleted?.cancel();
    ssFolderRenamed?.cancel();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return TXMainAppBarWidget(
        title: R.string.favorites,
        body: Stack(
          children: [
            StreamBuilder<List<FavoriteItem>>(
              initialData: [],
              stream: bloc.favoritesResult,
              builder: (context, snapshot) {
                final items =
                    reversed ? snapshot.data!.reversed.toList() : snapshot.data!;
                return Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        reversed = !reversed;
                                      });
                                    },
                                    child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: TXTextWidget(
                                          text: R.string.date,
                                          color: R.color.grayDarkestColor,
                                          size: 18,
                                        ))),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        reversed = !reversed;
                                      });
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: reversed
                                          ? Icon(
                                              Icons.keyboard_arrow_down,
                                              color: R.color.grayDarkestColor,
                                              size: 20,
                                            )
                                          : Icon(
                                              Icons.keyboard_arrow_up,
                                              color: R.color.grayDarkestColor,
                                              size: 20,
                                            ),
                                    ))
                              ],
                            )),
                        Expanded(
                          child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  TXDividerWidget(),
                              itemBuilder: (context, index) => _getFavWidget(
                                  items[index],
                                  isFirst: index == 0,
                                  isLast: index == items.length - 1),
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 20),
                              itemCount: items.length),
                        ),
                      ],
                    ));
              },
            ),
            TXLoadingWidget(
                loadingStream: bloc.isLoadingStream,
                backgroundColor: Colors.transparent)
          ],
        ));
  }

  Widget _getFavWidget(FavoriteItem item,
      {bool isFirst = false, bool isLast = false}) {
    return Column(
      children: [
        isFirst ? TXDividerWidget() : Container(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _getMessage(item.member, item.message, item.channel),
              ),
              Container(
                margin: EdgeInsets.only(right: 10, top: 10),
                height: 30,
                width: 30,
                child: InkWell(
                  onTap: () {
                    bloc.unsetFavorite(item.message.id);
                  },
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    child: Icon(
                        (item.message.favorite)
                            ? Icons.star
                            : Icons.star_border,
                        color: (item.message.favorite)
                            ? Colors.yellow
                            : R.color.grayColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        isLast ? TXDividerWidget() : Container(),
      ],
    );
  }

  Widget _getMessage(
      MemberModel member, MessageModel messageModel, ChannelModel channel) {
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
                    top: member.profile?.fullNameWithUsername.isUpperCase() == true
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
                                bloc.onMentionClicked(member.profile?.name ?? "");
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
                                ?.toLowerCase() ?? "",
                          ),
                          TXTextWidget(
                            text: "(${channel.titleFixed.toLowerCase()})",
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        bloc.onMessageTap(messageModel);
                      },
                      // onLongPress: () {
                      //   bloc.currentMessageSelected = messageModel;
                      //   showTXModalBottomSheet(
                      //       context: context,
                      //       builder: (context) {
                      //         FocusScope.of(context).requestFocus(FocusNode());
                      //         return _showMessageOptions(context);
                      //       });
                      // },
                      child: Container(
                        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: Column(
                          children: [
                            TXMessageBodyWidget(
                              message: messageModel,
                              onLinkTap: (link) async {
                                if (link.startsWith("#file-comment")) {
                                  bloc.getChannelFromId(messageModel.cid).then((value) {
                                    if(value != null) {
                                      NavigationUtils.push(
                                          context,
                                          MessageCommentsPage(
                                            teamJoinedModel: widget.joinedTeam,
                                            drawerChatList: widget.drawerChatList,
                                            channel: value,
                                            parentMessageId: messageModel.mid ?? "",
                                          ));
                                    } else {
                                      bloc.showErrorMessageFromString(R.string.errorFetchingData);
                                    }
                                  });
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
                            messageModel.isTaskNotification
                                ? TXTaskNotificationWidget(
                              messageModel: messageModel,
                              // onLongPress: () {
                              //   bloc.currentMessageSelected =
                              //       messageModel;
                              //   showTXModalBottomSheetAutoAdjustable(
                              //       context: context,
                              //       builder: (context) {
                              //         FocusScope.of(context)
                              //             .unfocus();
                              //         return _showMessageOptions(
                              //             context);
                              //       });
                              // },
                            )
                                : Container(),
                            messageModel.isFolderLinkMessage ||
                                    messageModel.isFolderShareMessage ||
                                    messageModel.isFolderUploadMessage
                                ? TXFolderNotificationWidget(
                                    message: messageModel,
                                    // onFolderTap: (FolderModel folder) async {
                                    // if (folder.deleted) {
                                    //   bloc.showErrorMessageFromString(
                                    //       R.string.folderDeleted);
                                    // } else {
                                    //   final path =
                                    //       (await bloc.resolveFolderReference(
                                    //                   folder.tid,
                                    //                   folder.cid,
                                    //                   folder.id))
                                    //               ?.path ??
                                    //           '';
                                    //   folder.path = path;
                                    //   if (folder.path != null &&
                                    //       folder.path.isNotEmpty)
                                    //     navigateToFiles(context, folder);
                                    //   else
                                    //     bloc.showErrorMessageFromString(R
                                    //         .string
                                    //         .folderIsNotInAvailableChannel);
                                    // }
                                    // },
                                    // onLongPress: () {
                                    //   bloc.currentMessageSelected =
                                    //       messageModel;
                                    //   showTXModalBottomSheet(
                                    //       context: context,
                                    //       builder: (context) {
                                    //         FocusScope.of(context).unfocus();
                                    //         return _showMessageOptions(context);
                                    //       });
                                    // },
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

  Widget _getFile(BuildContext context, MessageModel messageModel,
      bool showMessageMemberInfo, MemberModel memberModel) {
    final fileRenderW = messageModel.fileModel?.width == null
        ? 250 / 4
        : messageModel.fileModel!.width!.toDouble() * 1 / 8;
    final fileRenderH = messageModel.fileModel?.height == null
        ? 250 / 4
        : messageModel.fileModel!.height!.toDouble() * 1 / 8;

    final isAudio =
        messageModel.fileModel?.mimeType.startsWith("audio") == true;
    final isVideo =
        messageModel.fileModel?.mimeType.startsWith("video") == true;
    final isApp =
        messageModel.fileModel?.mimeType.startsWith("application") == true;

    final isAudioVideoApp = isVideo || isAudio || isApp;

    return AbsorbPointer(
      absorbing: messageModel.fileModel?.isUploadingDownloading == true,
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
                  !isAudio && !isVideo
                      ? TXNetworkImage(
                          forceLoad: true,
                          boxFitImage: BoxFit.cover,
                          mimeType: messageModel.fileModel?.mimeType ?? "",
                          width: isAudioVideoApp
                              ? math.min(fileRenderW, 80)
                              : math.max(fileRenderW, 80),
                          height: math.max(fileRenderH, 80),
                          imageUrl: messageModel.fileModel?.link ?? "",
                          placeholderImage: Image.asset(
                            messageModel.fileModel?.mimeType
                                        .startsWith("image") ==
                                    true
                                ? R.image.imageDefaultIcon
                                : R.image.logo,
                            fit: BoxFit.cover,
                          ),
                        )
                      : !isVideo
                          ? TXAudioPlayer(link: messageModel.fileModel?.link, mimeType: messageModel.fileModel?.mimeType)
                          : TXVideoPlayer(link: messageModel.fileModel?.link ?? ""),
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

  // Widget _showReactions(BuildContext context) {
  //   return TXReactionsWidget(
  //     onReactionSelected: (reactionKey) async {
  //       await NavigationUtils.pop(context);
  //       bloc.addRemoveReaction(reactionKey);
  //     },
  //   );
  // }

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
          padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
          child: TXTextWidget(
            text: R.string.seeAll,
            color: R.color.secondaryColor,
            size: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      list.add(w);
    }
    return list;
  }

  // void _navigateToFiles(BuildContext context, FolderModel selectedFolder) {
  //   if (selectedFolder != null &&
  //       selectedFolder.tid != widget.joinedTeam.team.id) {
  //     bloc.showErrorMessageFromString(R.string.folderIsNotInCurrentTeam);
  //   } else {
  //     NavigationUtils.push(
  //         context,
  //         FilesExplorerPage(
  //           channels: widget.joinedTeam.channels,
  //           groups: widget.joinedTeam.groups,
  //           messages1x1: widget.joinedTeam.messages1x1,
  //           members: widget.joinedTeam.memberWrapperModel.list,
  //           selectedFolder: selectedFolder,
  //         ));
  //   }
  // }
}
