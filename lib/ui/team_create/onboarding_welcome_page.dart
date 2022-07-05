import 'package:code/_res/R.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/team_create/onboarding_welcome_bloc.dart';
import 'package:code/ui/team_create/team_create_page.dart';
import 'package:flutter/material.dart';

class OnboardingWelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OnboardingWelcomeState();
}

class OnboardingWelcomeState
    extends StateWithBloC<OnboardingWelcomePage, OnboardingWelcomeBloC> {
  @override
  void initState() {
    super.initState();
    bloc.init();
    bloc.logoutResult.listen((event) {
      _navBack(loggingOut: true);
    });
  }

  _navBack({loggingOut = false, teamCreated}) async {
    NavigationUtils.pop(context, result: loggingOut ? loggingOut : teamCreated);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: [
        TXMainAppBarWidget(
            //appBarBackgroundColor: R.color.primaryColor,
            title: R.string.createTeam,
            onLeadingTap: () {
              _navBack();
            },
            body: TXGestureHideKeyBoard(
              child: Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            TXTextWidget(
                              text: R.string.welcome,
                              size: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TXTextWidget(
                              text: R.string.createTeamIntro,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TXTextWidget(
                              text: R.string.invitationSentAt,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            StreamBuilder<String>(
                              stream: bloc.userEmailResult,
                              initialData: "",
                              builder: (context, snapshot) {
                                return TXTextWidget(
                                  text: snapshot.data!,
                                  color: R.color.secondaryColor,
                                  size: 20,
                                  fontWeight: FontWeight.bold,
                                );
                              }
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TXTextWidget(
                              text: R.string.isCorrectEmailAddress,
                              size: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            MaterialButton(
                                height: 40,
                                elevation: 3,
                                color: R.color.secondaryColor,
                                child: TXTextWidget(
                                  text: R.string.confirmIsCorrectEmailAddress,
                                  color: R.color.whiteColor,
                                ),
                                onPressed: () async {
                                  final res = await NavigationUtils.push(
                                      context, TeamCreatePage());
                                  if(res != null) _navBack(teamCreated: res);
                                }),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              child: TXTextWidget(
                                text: R.string.changeCreateTeamMail,
                                color: R.color.secondaryColor,
                              ),
                              onTap: () {
                                bloc.logout();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            )),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        )
      ],
    );
  }
}
