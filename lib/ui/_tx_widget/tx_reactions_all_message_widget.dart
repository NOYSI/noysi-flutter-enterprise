import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textlink_widget.dart';
import 'package:code/utils/common_utils.dart';
import 'package:flutter/material.dart';

class TXReactionsAllMessageWidget extends StatefulWidget {
  final MessageModel? messageModel;

  const TXReactionsAllMessageWidget({
    Key? key,
    this.messageModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TXReactionsAllMessageState();
}

class _TXReactionsAllMessageState extends State<TXReactionsAllMessageWidget> {
  String selectedReaction = "";

  @override
  Widget build(BuildContext context) {
    List<ReactionsModel> reactions = ReactionsModel.getReactions();
    List<ReactionsModel> nonEmptyUsersReactions = widget.messageModel?.reactions
            .where((element) => element.userIds.isNotEmpty)
            .toList() ??
        [];

    int totalPostedReactions = 0;
    List<ReactionsModel> postedReactions = [];
    List<String> allMemberIds = [];

    reactions.forEach((element) {
      final reaction = nonEmptyUsersReactions.firstWhere(
          (nonEmptyR) => element.reactionKey.contains(nonEmptyR.reactionKey),
          orElse: () {
        return ReactionsModel();
      });
      if (reaction.userIds.isNotEmpty) {
        totalPostedReactions += reaction.userIds.length;
        reaction.userIds.forEach((i) {
          allMemberIds.add(i);
        });
        postedReactions.add(ReactionsModel(
            reactionKey: element.reactionKey, userIds: reaction.userIds));
      }
    });
    allMemberIds.toSet().toList();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            color: R.color.grayLightestColor,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TXTextWidget(
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    textOverflow: TextOverflow.ellipsis,
                    text: R.string.reactions,
                    color: R.color.blackColor,
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TXTextLinkWidget(
                  title: R.string.ok,
                  backgroundColor: R.color.grayLightestColor,
                  textColor: R.color.secondaryColor,
                  onTap: () {
                    NavigationUtils.pop(context);
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 60,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedReaction = "";
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TXTextWidget(
                                    text: "${R.string.all}:",
                                    color: R.color.blackColor,
                                  ),
                                  TXTextWidget(
                                    text: "$totalPostedReactions",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 5,
                            color: selectedReaction.isEmpty
                                ? R.color.secondaryColor
                                : R.color.whiteColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  ..._getReactions(postedReactions)
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TXDividerWidget(),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: TXTextWidget(
                        text: R.string.users,
                        color: R.color.blackColor,
                        size: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: FutureBuilder(
                          future: Injector.instance.inMemoryData
                              .resolveMembersAsync(allMemberIds),
                          builder: (context, snapshot) => GridView.count(
                            padding: EdgeInsets.all(0),
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 3.0,
                            children: <Widget>[..._getMembers(postedReactions)],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  List<Widget> _getReactions(List<ReactionsModel> postedReactions) {
    List<Widget> list = [];
    postedReactions.forEach((element) {
      final w = InkWell(
        onTap: () {
          setState(() {
            selectedReaction = element.reactionKey;
          });
        },
        child: Container(
          width: 60,
          height: 50,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      element.reactionKey,
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    TXTextWidget(
                      text: element.userIds.length.toString(),
                    )
                  ],
                ),
              ),
              Container(
                height: 5,
                color: selectedReaction == element.reactionKey
                    ? R.color.secondaryColor
                    : R.color.whiteColor,
              )
            ],
          ),
        ),
      );
      list.add(w);
    });
    return list;
  }

  List<Widget> _getMembers(List<ReactionsModel> postedReactions) {
    List<Widget> list = [];
    Injector.instance.inMemoryData.getMembers().forEach((member) {
      final reactionInPresence =
          postedReactions.where((r) => r.userIds.contains(member.id)).toList();
      reactionInPresence.forEach((element) {
        if (selectedReaction.isEmpty ||
            element.reactionKey == selectedReaction) {
          final w = _getMemberReaction(element, member);
          list.add(w);
        }
      });
    });
    return list;
  }

  Widget _getMemberReaction(
      ReactionsModel reactionsModel, MemberModel memberModel) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 55,
                  height: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      TXNetworkImage(
                        height: 40,
                        width: 40,
                        boxFitImage: BoxFit.cover,
                        forceLoad: true,
                        userBorderRadius: true,
                        imageUrl: CommonUtils.getMemberPhoto(memberModel),
                        placeholderImage: Image.asset(R.image.logo),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(45)),
                              border: Border.all(
                                  color: R.color.secondaryColor, width: 1),
                              color: R.color.whiteColor),
                          padding: EdgeInsets.all(3),
                          child: Image.asset(
                            reactionsModel.reactionKey,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: TXTextWidget(
                    text: "@${CommonUtils.getMemberUsername(memberModel)}",
                  ),
                )
              ],
            ),
          ),
          TXDividerWidget()
        ],
      ),
    );
  }
}
