import 'package:code/_res/R.dart';
import 'package:code/domain/activity/activity_model.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_alert_dialog.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_menu_option_item_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/activity_zone/sessions/sessions_bloc.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class SessionsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SessionsState();
}

class _SessionsState extends StateWithBloC<SessionsPage, SessionsBloC> {
  @override
  void initState() {
    super.initState();
    onSignedIn.listen((value) {
      bloc.onSessionOpen(value);
    });
    onSignedOut.listen((value) {
      bloc.onSessionClosed(value);
    });
    bloc.loadSessions();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) => Stack(
        children: [
          TXMainAppBarWidget(
            title: R.string.sessions,
            body: StreamBuilder<List<SessionModel>>(
                initialData: [],
                stream: bloc.sessionsResult,
                builder: (context, snapshot) {
                  final current = snapshot.data!
                      .firstWhereOrNull((element) => element.current);
                  final other = snapshot.data!
                      .where((element) => !element.current)
                      .toList();
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        current != null
                            ? _getCurrentSessionWidget(context, current,
                                terminateAllIsActive: other.isNotEmpty)
                            : Container(),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 30,
                                alignment: Alignment.centerLeft,
                                child: TXTextWidget(
                                  text: R.string.openSessions,
                                  color: R.color.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ..._getSessionWidgets(context, other)
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          TXLoadingWidget(
            loadingStream: bloc.isLoadingStream,
          )
        ],
      );

  Widget _getCurrentSessionWidget(BuildContext context, SessionModel session,
      {bool terminateAllIsActive = true}) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 30,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
          child: TXTextWidget(
            text: R.string.currentSession,
            color: R.color.secondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: _getSessionWidget(context, session),
        ),
        InkWell(
          onTap: terminateAllIsActive
              ? () {
                  _showDialogLogoutAllOther(context);
                }
              : null,
          child: Container(
            width: double.infinity,
            height: 50,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 25),
            child: TXTextWidget(
                text: R.string.terminateAllOtherSessions,
                size: 18,
                color:
                    terminateAllIsActive ? Colors.red : R.color.grayLightColor),
          ),
        ),
        TXDividerWidget(
          height: .75,
        ),
        Container(
          height: 50,
          width: double.infinity,
          color: R.color.grayBar,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 25),
          child: TXTextWidget(
            text: R.string.logOutAllExceptForThisOne,
            color: R.color.graySemiLightColor,
          ),
        ),
        TXDividerWidget(),
      ],
    );
  }

  List<Widget> _getSessionWidgets(
          BuildContext context, List<SessionModel> sessions) =>
      sessions.map((e) => _getSessionWidget(context, e)).toList();

  Widget _getSessionWidget(BuildContext context, SessionModel session) {
    return InkWell(
      onLongPress: () {
        showTXModalBottomSheet(
            context: context,
            builder: (context) {
              return _launchOptions(context, session);
            });
      },
      child: Container(
          child: Column(children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15, right: 20),
              child: Image.asset(session.icon, width: 40, height: 40),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TXTextWidget(
                      text: session.isMobile
                          ? "${session.os} ${session.version} ${session.model ?? ""}"
                          : "${session.name} ${session.version} ${session.os}",
                      fontWeight: FontWeight.bold,
                      color: R.color.darkColor,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TXTextWidget(
                      text: session.ipAddress ?? "",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
            ),
            SizedBox(
              width: 10,
            ),
            session.current
                ? Container(
                    width: 12,
                    height: 12,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: R.color.presenceColor, width: 1.5)),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(2.5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: R.color.presenceColor),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            IconButton(
                icon: Icon(Icons.more_horiz, color: R.color.grayColor),
                onPressed: () {
                  showTXModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return _launchOptions(context, session);
                      });
                }),
          ],
        ),
        TXDividerWidget()
      ])),
    );
  }

  Widget _launchOptions(BuildContext context, SessionModel session) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        constraints: BoxConstraints(maxHeight: 180),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: TXTextWidget(
                text: session.isMobile
                    ? session.model ?? ""
                    : "${session.name} ${session.version}",
                color: R.color.grayDarkestColor,
                size: 18,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TXDividerWidget(),
            Container(
              height: 45,
              child: TXMenuOptionItemWidget(
                icon: Icon(Icons.info_outline, color: R.color.grayColor),
                text: R.string.moreInfo,
                onTap: () async {
                  await NavigationUtils.pop(context);
                  txShowWarningDialogBlur(context,
                      title: Row(
                        children: [
                          TXTextWidget(
                            text: R.string.moreInfo,
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.bold,
                            color: R.color.darkColor,
                            size: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.info_outline, color: R.color.grayColor),
                        ],
                      ),
                      yesNo: false,
                      content: _getMoreInfoWidget(session));
                },
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: TXDividerWidget(),
                ),
              ],
            ),
            Container(
              height: 45,
              child: TXMenuOptionItemWidget(
                icon: Icon(Icons.exit_to_app, color: Colors.red),
                text: R.string.logout,
                textColor: Colors.red,
                onTap: () async {
                  await NavigationUtils.pop(context);
                  _showDialogLogout(context, session);
                },
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: TXDividerWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDialogLogout(context, session) {
    txShowWaringDialogMaterial(context,
        title: TXTextWidget(
          text: R.string.logout,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.bold,
          color: R.color.darkColor,
          size: 18,
        ), onAction: (action) {
      if (action) bloc.closeSession(session);
    },
        content: Container(
          child: TXTextWidget(
            text: R.string.closeSessionConfirmation,
            color: R.color.grayDarkestColor,
          ),
        ));
  }

  void _showDialogLogoutAllOther(context) {
    txShowWaringDialogMaterial(context,
        title: TXTextWidget(
          text: R.string.logout,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.bold,
          color: R.color.darkColor,
          size: 18,
        ), onAction: (action) {
      if (action) bloc.closeAllExceptMine();
    },
        content: Container(
          child: TXTextWidget(
            text: R.string.closeAllSessionsConfirmation,
            color: R.color.grayDarkestColor,
          ),
        ));
  }

  Widget _getMoreInfoWidget(SessionModel session) {
    return Container(
      height: session.isMobile ? 145 : 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: session.isMobile
            ? [
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.date}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: CalendarUtils.showInFormat(
                              R.string.dateFormat5, session.ts) ??
                          '',
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.manufacturer}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: session.name ?? "",
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.device}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: session.model ?? '',
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.operativeSystem}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: "${session.os} ${session.version}",
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.appVersion}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: session.appVersion ?? "",
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "IP: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: session.ipAddress ?? "",
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
              ]
            : [
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.date}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: CalendarUtils.showInFormat(
                              R.string.dateFormat5, session.ts) ??
                          '',
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.browser}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: "${session.name} ${session.version}",
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "${R.string.operativeSystem}: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: session.os ?? "",
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TXTextWidget(
                      text: "IP: ",
                      color: R.color.grayDarkestColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TXTextWidget(
                      text: session.ipAddress ?? "",
                      color: R.color.grayDarkestColor,
                    ),
                  ],
                ),
              ],
      ),
    );
  }
}
