import 'package:code/_res/R.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/enums.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/_tx_widget/tx_badge_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_user_presence_widget.dart';
import 'package:code/ui/home/home_ui_model.dart';
import 'package:code/utils/common_utils.dart';
import 'package:code/utils/text_parser_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/subjects.dart';

BehaviorSubject<DrawerChatModel> drawerChatController = BehaviorSubject();

class TXDrawerChatItemWidget extends StatefulWidget {
  final DrawerChatModel drawerChatModel;
  final GestureTapCallback? onTap;

  const TXDrawerChatItemWidget(
      {Key? key, required this.drawerChatModel, this.onTap})
      : super(key: key);

  @override
  State<TXDrawerChatItemWidget> createState() => _TXDrawerChatItemWidgetState();
}

class _TXDrawerChatItemWidgetState extends State<TXDrawerChatItemWidget> {
  late DrawerChatModel _drawerChatModel;

  @override
  void initState() {
    super.initState();
    _drawerChatModel = widget.drawerChatModel;
    drawerChatController.listen((chat) {
      if (!mounted) return;
      if (_drawerChatModel.drawerHeaderChatType == chat.drawerHeaderChatType &&
          chat.drawerHeaderChatType == DrawerHeaderChatType.Thread) {
        _drawerChatModel.unreadMessagesCount = chat.unreadMessagesCount;
      } else if (_drawerChatModel.isChild &&
          chat.isChild &&
          _drawerChatModel.channelModel?.id == chat.channelModel?.id) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _drawerChatModel = widget.drawerChatModel;
    return StreamBuilder<TeamTheme>(
      initialData: R.color.defaultTheme,
      stream: teamThemeController.stream,
      builder: (context, snapshot) {
        return Material(
          color: snapshot.data!.colors.sidebarColor,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4))),
            margin: EdgeInsets.only(left: 5, right: 5),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              onTap: widget.onTap,
              child: _drawerChatModel.isChild
                  ? _getChannelChild(snapshot.data!.colors)
                  : _getHeaderDrawerChatWidget(snapshot.data!.colors),
            ),
          ),
        );
      },
    );
  }

  Widget _getHeaderDrawerChatWidget(TeamColors colors) {
    final icon = _drawerChatModel.drawerHeaderChatType ==
            DrawerHeaderChatType.Thread
        ? Icons.chat_bubble_outline
        : _drawerChatModel.drawerHeaderChatType == DrawerHeaderChatType.Favorite
            ? Icons.star_border
            : null;
    final isThread =
        _drawerChatModel.drawerHeaderChatType == DrawerHeaderChatType.Thread;
    final isFavorite =
        _drawerChatModel.drawerHeaderChatType == DrawerHeaderChatType.Favorite;
    final isM1x1 = _drawerChatModel.drawerHeaderChatType ==
        DrawerHeaderChatType.Message1x1;
    return Container(
      padding: isThread ? const EdgeInsets.symmetric(horizontal: 5, vertical: 8) : EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          icon != null
              ? isThread
                  ? Container(
                      padding: EdgeInsets.only(top: 3),
                      child: Icon(
                        icon,
                        size: 20,
                        color: colors.textColor,
                      ),
                    )
                  : Icon(
                      icon,
                      size: 20,
                      color: colors.textColor,
                    )
              : Container(),
          SizedBox(
            width: 2,
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: TXTextWidget(
                          text: _drawerChatModel.title.toUpperCase(),
                          color: colors.textColor,
                          fontWeight: FontWeight.w500,
                          textOverflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      !isThread
                          ? TXTextWidget(
                              text: "(${_drawerChatModel.childrenCount})",
                              color: colors.textColor!.withOpacity(.6),
                            )
                          : Container(
                              width: 1,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   width: 5,
          // ),
          isThread
              ? _drawerChatModel.unreadMessagesCount > 0
                  ? TXBadgeWidget(
                    count: _drawerChatModel.unreadMessagesCount,
                  )
                  : Container()
              : Container() //!isFavorite
                  // ? Container(
                  //     padding: const EdgeInsets.only(top: 2),
                  //     child: InkWell(
                  //       onTap: widget.onTap,
                  //       child: Icon(
                  //         isM1x1 ? Icons.search : Icons.add_circle_outline,
                  //         size: 20,
                  //         color: colors.textColor,
                  //       ),
                  //     ),
                  //   )
                  // : Container(),
        ],
      ),
    );
  }

  Widget _getChannelChild(TeamColors colors) {
    if (_drawerChatModel.channelModel?.joined == true &&
        _drawerChatModel.channelModel?.open == true) {
      if (_drawerChatModel.channelModel?.isM1x1 == true)
        return _getChannelChild1x1(colors);
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color:
              _drawerChatModel.isSelected ? colors.activeItemBackground : null,
        ),
        padding: EdgeInsets.only(top: 12, bottom: 12, left: 5, right: 5),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: [
                  _drawerChatModel.channelModel?.isPrivateGroup == true
                      ? Icon(
                          Icons.https,
                          size: 20,
                          color: _drawerChatModel.isSelected
                              ? colors.activeItemText
                              : colors.subtextColor,
                        )
                      : Container(),
                  SizedBox(
                    width: _drawerChatModel.channelModel?.isPrivateGroup == true
                        ? 5
                        : 0,
                  ),
                  Expanded(
                    child: TXTextWidget(
                      text: _drawerChatModel.title.toLowerCase(),
                      color: _drawerChatModel.isSelected
                          ? colors.activeItemText
                          : colors.subtextColor,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      fontWeight: _drawerChatModel.isSelected
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
            _drawerChatModel.unreadMessagesCount > 0 == true
                ? TXBadgeWidget(
                    count: _drawerChatModel.unreadMessagesCount,
                  )
                : Container()
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getChannelChild1x1(TeamColors colors) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: _drawerChatModel.isSelected ? colors.activeItemBackground : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5, top: 5),
                child: TXNetworkImage(
                  height: 40,
                  width: 40,
                  imageUrl:
                      CommonUtils.getMemberPhoto(_drawerChatModel.memberModel),
                  forceLoad: true,
                  placeholderImage: Image.asset(R.image.logo),
                ),
              ),
              Positioned(
                child: TXUserPresenceWidget(
                  userPresence: _drawerChatModel.memberModel?.userPresence ??
                      UserPresence.out,
                  isUserEnabled: _drawerChatModel.memberModel?.active == true && _drawerChatModel.memberModel?.isDeletedUser == false,
                ),
              )
            ],
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: TXTextWidget(
                              text: _drawerChatModel.memberModel?.isDeletedUser == true ? R.string.memberDeleted : _drawerChatModel.memberModel?.active ==
                                      false
                                  ? R.string.inactiveMember
                                  : CommonUtils.getMemberNameSingle(_drawerChatModel.memberModel) ?? "",
                              color:
                                  _drawerChatModel.memberModel?.active == false || _drawerChatModel.memberModel?.isDeletedUser == true
                                      ? Colors.redAccent
                                      : _drawerChatModel.isSelected
                                          ? colors.activeItemText
                                          : colors.subtextColor,
                              fontWeight: _drawerChatModel.memberModel?.active == false || _drawerChatModel.memberModel?.isDeletedUser == true ? FontWeight.normal : FontWeight.w500,
                              maxLines: 1,
                              fontStyle:
                                  _drawerChatModel.memberModel?.active == false || _drawerChatModel.memberModel?.isDeletedUser == true
                                      ? FontStyle.italic
                                      : null,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                          !(_drawerChatModel.memberModel?.statusIcon.isEmpty ==
                                  true)
                              ? InkWell(
                                  borderRadius: BorderRadius.circular(45),
                                  onTap: !(_drawerChatModel.memberModel
                                              ?.statusText.isEmpty ==
                                          true)
                                      ? () {
                                          Fluttertoast.showToast(
                                              msg: _drawerChatModel.memberModel
                                                      ?.statusText ??
                                                  "");
                                        }
                                      : null,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2),
                                    child: TXTextWidget(
                                      text: _drawerChatModel
                                                  .memberModel?.statusIcon ==
                                              null
                                          ? ""
                                          : TextUtilsParser.emojiParserFromHex(
                                              _drawerChatModel
                                                      .memberModel?.statusIcon
                                                      .split('-') ??
                                                  []),
                                      //fontFamily: "EmojiOne",
                                      size: 20,
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TXTextWidget(
                        text:
                            "@${CommonUtils.getMemberUsername(_drawerChatModel.memberModel) ?? ""}",
                        color: colors.subtextColor,
                        fontWeight: FontWeight.w400,
                        size: 16,
                      ),
                    ],
                  ),
                ),
                _drawerChatModel.unreadMessagesCount > 0
                    ? TXBadgeWidget(
                        count: _drawerChatModel.unreadMessagesCount,
                      )
                    : Container()
              ],
            ),
          )
        ],
      ),
    );
  }

  // String _formatText(String text, {int length = 14}) {
  //   return text.length > length ? text.substring(0, length) + "..." : text;
  // }
}
