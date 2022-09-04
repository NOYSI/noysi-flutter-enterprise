import 'dart:async';

import 'package:code/_res/R.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/rtc/rtc_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_alert_dialog.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/team/team_bloc.dart';
import 'package:code/ui/team/tx_team_cell_item_widget.dart';
import 'package:code/ui/team_create/onboarding_welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TeamPage extends StatefulWidget {
  final bool isFromLogin;
  final RTCMemberDisabledEnabledModel? memberDisabled;

  const TeamPage({Key? key, this.isFromLogin = false, this.memberDisabled})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TeamState();
}

class _TeamState extends StateWithBloC<TeamPage, TeamBloC> {
  StreamSubscription? memberDisabledStreamSubscription,
      teamDisabledStreamSubscription,
      teamUpdatedStreamSubscription;

  @override
  void initState() {
    super.initState();
    onMemberDisabledEnabled.sink.add(null);
    // bloc.logoutResult.listen((event) {
    //   if (event ?? false) NavigationUtils.pop(context, result: true);
    // });
    memberDisabledStreamSubscription = onMemberDisabledEnabled.listen((value) {
      if (value != null && mounted) {
        bloc.doOnMemberDisabledEnabled(value);
      }
    });
    teamDisabledStreamSubscription = onTeamDisabled.listen((value) {
      if (mounted) {
        bloc.doOnTeamDisabled(value);
      }
    });
    teamUpdatedStreamSubscription = onTeamUpdatedController.listen((value) {
      if (mounted) {
        bloc.doOnTeamUpdated(value);
      }
    });
    bloc.loadData(memberDisabled: widget.memberDisabled);
  }

  @override
  void dispose() {
    super.dispose();
    memberDisabledStreamSubscription?.cancel();
    teamDisabledStreamSubscription?.cancel();
    teamUpdatedStreamSubscription?.cancel();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        StreamBuilder<bool>(
          initialData: false,
          stream: bloc.hideLeadingResult,
          builder: (context, snapshotLeading) {
            return TXMainAppBarWidget(
              title: R.string.yourTeams,
              hideLeading: snapshotLeading.data!,
              floatingActionButton: bloc.teamIsEnterprise
                  ? null
                  : FloatingActionButton(
                      backgroundColor: R.color.secondaryColor,
                      onPressed: () {
                        NavigationUtils.push(context, OnboardingWelcomePage())
                            .then((res) {
                          if (res is TeamModel || (res is bool && res)) {
                            NavigationUtils.pop(context, result: res);
                          }
                        });
                      },
                      child: Icon(
                        Icons.add,
                        color: R.color.whiteColor,
                      ),
                    ),
              actions: <Widget>[
                TXIconButtonWidget(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    _showDialogLogout(context: context);
                  },
                )
              ],
              body: StreamBuilder<List<TeamModel>>(
                stream: bloc.teamsResult,
                initialData: [],
                builder: (ctx, snapshot) {
                  snapshot.data!.sort((e1, e2) => e1.titleFixed
                      .toLowerCase()
                      .compareTo(e2.titleFixed.toLowerCase()));
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        ...snapshot.data!
                            .map((e) => Column(
                                  children: [
                                    TXTeamCellItemWidget(
                                      team: e,
                                      onTap: () {
                                        NavigationUtils.pop(context, result: e);
                                      },
                                    ),
                                    Row(
                                      children: const [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: TXDividerWidget(),
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                            .toList(),
                        bloc.teamIsEnterprise
                            ? Container()
                            : Container(
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  children: [
                                    TXButtonWidget(
                                        onPressed: () async {
                                          const url =
                                              "https://ltd.noysi.com";
                                          if (await canLaunchUrlString(url)) {
                                            launchUrlString(url);
                                          }
                                        },
                                        title: R.string.lifetimeDeal.toUpperCase(),
                                        mainColor:
                                            R.color.lifetimeDealButtonYellow,
                                        textColor: R.color.primaryColor,
                                        splashColor: R.color.grayLightColor,
                                    fontWeight: FontWeight.w600, fontSize: 20),
                                    Image.asset(R.image.uptimeSlaNoysiColors, height: 150)
                                  ],
                                ),
                                // child: InkWell(
                                //   child: Image.asset(
                                //       R.image.featuredByAppsumo,
                                //       height: 50),
                                //   onTap: () async {
                                //     const url =
                                //         "https://appsumo.com/products/noysi/?utm_source=badge";
                                //     if (await canLaunchUrlString(url)) {
                                //       launchUrlString(url);
                                //     }
                                //   },
                                // )
                              )
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        )
      ],
    );
  }

  void _showDialogLogout({required BuildContext context}) {
    txShowWaringDialogMaterial(context,
        title: TXTextWidget(
          text: R.string.logout,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.bold,
          color: R.color.darkColor,
          size: 16,
        ), onAction: (action) async {
      if (action) {
        bloc
            .logout()
            .then((value) => NavigationUtils.pop(context, result: true));
      }
    },
        content: TXTextWidget(
          text: R.string.closeSessionConfirmation,
          color: R.color.grayDarkestColor,
        ));
  }
}

class TeamPageArguments {
  bool fromLogin;
  RTCMemberDisabledEnabledModel? memberDisabledEnabledModel;
  Key? key;

  TeamPageArguments(
      {this.key, this.memberDisabledEnabledModel, this.fromLogin = false});
}
