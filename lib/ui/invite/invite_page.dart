import 'package:code/_res/R.dart';
import 'package:code/enums.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/invitations/invitations_page.dart';
import 'package:code/ui/invite/invite_bloc.dart';
import 'package:code/ui/invite_people/invite_people_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../domain/channel/channel_model.dart';

class InvitePage extends StatefulWidget {
  final List<ChannelModel> privateGroups;

  const InvitePage({required this.privateGroups});

  @override
  State<StatefulWidget> createState() => _InvitePeopleState();
}

class _InvitePeopleState extends StateWithBloC<InvitePage, InviteBloC> {
  @override
  void initState() {
    super.initState();
    bloc.loadMember();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return TXMainAppBarWidget(
      centeredTitle: true,
      title: R.string.invitePeople,
      leading: TXIconButtonWidget(
        icon: Icon(Icons.close),
        onPressed: () {
          NavigationUtils.pop(context);
        },
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            TXTextWidget(
              text: R.string.inviteTitle,
              size: 30,
              color: Colors.black,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TXTextWidget(
                textAlign: TextAlign.center,
                text: R.string.inviteSubtitle,
                size: 18,
                maxLines: 2,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        child: InkWell(
                          onTap: () async {
                            if (bloc.memberModel != null &&
                                bloc.memberModel?.userRol == UserRol.Admin) {
                              final res = await NavigationUtils.push(
                                  context,
                                  InvitePeoplePage(
                                    inviteMembers: true,
                                    privateGroups: widget.privateGroups,
                                  ));
                              if (res is List<String>) {
                                if (res.isNotEmpty) {
                                } else {
                                  Fluttertoast.showToast(
                                      msg: R.string.invitationsSent,
                                      toastLength: Toast.LENGTH_LONG,
                                      textColor: R.color.whiteColor,
                                      backgroundColor: R.color.primaryColor);
                                }
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: R.string.permissionDenied,
                                  toastLength: Toast.LENGTH_LONG,
                                  textColor: R.color.whiteColor,
                                  backgroundColor: Colors.red);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                SvgPicture.asset(
                                  R.image.members,
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TXTextWidget(
                                  text: R.string.members,
                                  size: 22,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TXTextWidget(
                                  text: R.string.inviteMemberTitle,
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TXTextWidget(
                                  text: "*${R.string.inviteMemberWarningTitle}",
                                  color: R.color.secondaryColor,
                                  maxLines: 2,
                                  size: 14,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Card(
                        child: InkWell(
                          onTap: () async {
                            if (bloc.memberModel != null &&
                                bloc.memberModel?.userRol != UserRol.Guest) {
                              final res = await NavigationUtils.push(
                                  context,
                                  InvitePeoplePage(
                                    inviteMembers: false,
                                    privateGroups: widget.privateGroups,
                                  ));
                              if (res is List<String>) {
                                if (res.isNotEmpty) {
                                } else {
                                  Fluttertoast.showToast(
                                      msg: R.string.invitationsSent,
                                      toastLength: Toast.LENGTH_LONG,
                                      textColor: R.color.whiteColor,
                                      backgroundColor: R.color.primaryColor);
                                }
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: R.string.permissionDenied,
                                  toastLength: Toast.LENGTH_LONG,
                                  textColor: R.color.whiteColor,
                                  backgroundColor: Colors.red);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                SvgPicture.asset(
                                  R.image.guests,
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TXTextWidget(
                                  text: R.string.guests,
                                  size: 22,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TXTextWidget(
                                  text: R.string.inviteNewMemberTitle,
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TXTextWidget(
                                  text:
                                      "*${R.string.inviteNewMemberWarningTitle}",
                                  color: R.color.secondaryColor,
                                  maxLines: 2,
                                  size: 14,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: TXButtonWidget(
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                title: R.string.seePendingAcceptedInvitations,
                onPressed: () {
                  NavigationUtils.push(context, InvitationsPage());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
