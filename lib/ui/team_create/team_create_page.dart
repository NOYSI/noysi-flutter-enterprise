import 'package:code/_res/R.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/team_create/onboarding_page_indicator.dart';
import 'package:code/ui/team_create/team_create_bloc.dart';
import 'package:flutter/material.dart';

class TeamCreatePage extends StatefulWidget {
  final String? mail;
  final bool loggedIn;
  final bool fromLogin;

  TeamCreatePage({this.mail, this.loggedIn = false, this.fromLogin = false});

  @override
  State<StatefulWidget> createState() => _TeamCreateState();
}

class _TeamCreateState extends StateWithBloC<TeamCreatePage, TeamCreateBloC> {
  late PageController _pageController;
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  // TextEditingController peopleController = TextEditingController();
  final _keyFormCompany = new GlobalKey<FormState>();
  final _keyFormUsername = new GlobalKey<FormState>();
  final _keyFormPassword = new GlobalKey<FormState>();
  // final _keyFormPeople = new GlobalKey<FormState>();

  FocusNode usernameFocusNode = FocusNode();
  FocusNode companyFocusNode = FocusNode();

  _navBack() async {
    if (bloc.teamCreated == null && widget.fromLogin && bloc.currentPage == 1)
      bloc.logout(callApi: true);
    NavigationUtils.pop(context, result: bloc.teamCreated);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: widget.loggedIn || widget.mail == null ? 1 : 0);
    bloc.initData(
        initPage: _pageController.initialPage, fromLogin: widget.fromLogin);
    bloc.pageResult.listen((index) {
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    });
    bloc.teamCreateResult.listen((event) {
      _navBack();
    });
  }

  void _pageBack() {
    if (bloc.currentPage == 0 ||
        (bloc.currentPage == 1 &&
            (widget.loggedIn ||
                widget.mail != null ||
                (!widget.loggedIn && widget.mail == null)))) {
      _navBack();
    } else {
      bloc.changePage(bloc.currentPage - 1);
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _pageBack();
        return false;
      },
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: R.color.primaryColor,
            body: TXGestureHideKeyBoard(
              child: Container(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: TXIconButtonWidget(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: R.color.whiteColor,
                          size: 30,
                        ),
                        onPressed: () {
                          _pageBack();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<int>(
                      stream: bloc.pageResult,
                      initialData:
                          widget.loggedIn || widget.mail == null ? 1 : 0,
                      builder: (ctx, pageSnapshot) {
                        return Container(
                          child: OnboardingPageIndicatorWidget(
                            labels: widget.loggedIn || widget.mail != null
                                ? [
                                    "${R.string.step(1)}:\n${R.string.password}",
                                    "${R.string.step(2)}:\n${R.string.team}",
                                    "${R.string.step(3)}:\n${R.string.user}"
                                  ]
                                : [
                                    "${R.string.step(1)}:\n${R.string.team}",
                                    "${R.string.step(2)}:\n${R.string.user}"
                                  ],
                            count:
                                widget.loggedIn || widget.mail != null ? 3 : 2,
                            currentIndex:
                                widget.loggedIn || widget.mail != null
                                    ? pageSnapshot.data!
                                    : pageSnapshot.data! - 1,
                          ),
                          alignment: Alignment.center,
                          width: double.infinity,
                        );
                      },
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Expanded(
                      child: PageView.builder(
                        itemBuilder: (ctx, indexPage) {
                          if (indexPage == 0)
                            return _getPagePassword();
                          else if (indexPage == 1)
                            return _getPage2();
                          else //if (indexPage == 2)
                            return _getPage3();
                          // else
                          //   return _getPage4();
                        },
                        itemCount: 3,
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: TXButtonWidget(
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        textColor: Colors.white,
                        title: bloc.currentPage == 2
                            ? R.string.startNow
                            : R.string.next,
                        mainColor: R.color.secondaryColor,
                        onPressed: () {
                          switch (bloc.currentPage) {
                            case 0:
                              if (widget.mail != null) {
                                if (_keyFormPassword.currentState!.validate()) {
                                  if (passwordController.text ==
                                      passwordController2.text)
                                    bloc.register(
                                        widget.mail!, passwordController.text);
                                  else
                                    bloc.showErrorMessageFromString(
                                        R.string.passwordDontMatch);
                                }
                              }
                              break;
                            case 1:
                              if (_keyFormCompany.currentState!.validate()) {
                                bloc.checkTeamName();
                              }
                              break;
                            default:
                              if (_keyFormUsername.currentState!.validate()) {
                                //bloc.changePage(bloc.currentPage + 1);
                                bloc.createTeam();
                              }
                              break;
                            // default:
                            //   bloc.createTeam();
                            //   break;
                          }
                        },
                      ),
                    )
                  ],
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

  Widget _getPagePassword() {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _keyFormPassword,
            child: Column(
              children: [
                TXTextWidget(
                  text: R.string.yourPassword,
                  size: 40,
                  color: R.color.grayLightestColor,
                  fontWeight: FontWeight.w300,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TXTextWidget(
                    textAlign: TextAlign.center,
                    text: R.string.chooseASecurePasswordText,
                    color: R.color.grayLightestColor,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TXTextFieldWidget(
                  label: R.string.password,
                  obscureText: true,
                  controller: passwordController,
                  validator: bloc.password(),
                  cursorColor: R.color.grayLightestColor,
                  labelColor: R.color.grayLightestColor,
                  textColor: R.color.grayLightestColor,
                  inputBorderColor: R.color.grayLightestColor,
                  suffixIconColor: R.color.grayLightestColor,
                ),
                SizedBox(
                  height: 30,
                ),
                TXTextFieldWidget(
                  label: R.string.confirmPassword,
                  obscureText: true,
                  controller: passwordController2,
                  cursorColor: R.color.grayLightestColor,
                  labelColor: R.color.grayLightestColor,
                  textColor: R.color.grayLightestColor,
                  inputBorderColor: R.color.grayLightestColor,
                  suffixIconColor: R.color.grayLightestColor,
                ),
                SizedBox(
                  height: 20,
                ),
                TXTextWidget(
                  text: R.string.passwordRestriction,
                  textAlign: TextAlign.justify,
                  color: R.color.grayLightestColor,
                ),
              ],
            ),
          ),
        ));
  }

  // Widget _getPage1() {
  //   return Container(
  //     padding: EdgeInsets.only(left: 20, right: 20),
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: <Widget>[
  //           TXTextWidget(
  //             text: R.string.welcome,
  //             size: 40,
  //             color: Colors.black,
  //             fontWeight: FontWeight.w300,
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           TXTextWidget(
  //             text: R.string.createTeamIntro,
  //           ),
  //           SizedBox(
  //             height: 5,
  //           ),
  //           TXTextWidget(
  //             text: R.string.invitationSentAt,
  //           ),
  //           SizedBox(
  //             height: 30,
  //           ),
  //           TXTextWidget(
  //             text: bloc.userEmail,
  //             color: R.color.secondaryColor,
  //             size: 20,
  //             fontWeight: FontWeight.bold,
  //           ),
  //           SizedBox(
  //             height: 30,
  //           ),
  //           TXTextWidget(
  //             text: R.string.isCorrectEmailAddress,
  //             size: 16,
  //             fontWeight: FontWeight.bold,
  //           ),
  //           SizedBox(
  //             height: 50,
  //           ),
  //           MaterialButton(
  //               height: 40,
  //               elevation: 3,
  //               color: R.color.secondaryColor,
  //               child: TXTextWidget(
  //                 text: R.string.confirmIsCorrectEmailAddress,
  //                 color: R.color.whiteColor,
  //               ),
  //               onPressed: () {
  //                 bloc.changePage(bloc.currentPage + 1);
  //               }),
  //           SizedBox(
  //             height: 30,
  //           ),
  //           InkWell(
  //             child: TXTextWidget(
  //               text: "No, quiero cambiar el email",
  //               color: R.color.secondaryColor,
  //             ),
  //             onTap: () {
  //               bloc.logout();
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _getPage2() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Form(
          key: _keyFormCompany,
          child: Column(
            children: <Widget>[
              TXTextWidget(
                text: R.string.yourTeam,
                size: 40,
                color: R.color.grayLightestColor,
                fontWeight: FontWeight.w300,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TXTextWidget(
                  textAlign: TextAlign.center,
                  text: R.string.teamNameOrgCompany,
                  color: R.color.grayLightestColor,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TXTextFieldWidget(
                label: R.string.teamNameOrgCompanyLabel,
                validator: bloc.alphanumericRoomName(),
                controller: companyNameController,
                autoFocus: true,
                textColor: R.color.grayLightestColor,
                labelColor: R.color.grayLightestColor,
                cursorColor: R.color.grayLightestColor,
                inputBorderColor: R.color.grayLightestColor,
                focusNode: companyFocusNode,
                onChanged: (value) {
                  bloc.model.name = value.trim();
                  setState(() {});
                },
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TXTextWidget(
                      textAlign: TextAlign.right,
                      text: R.string.charsRemaining,
                      color: R.color.grayLightColor,
                    ),
                    TXTextWidget(
                      textAlign: TextAlign.right,
                      color: 25 - companyNameController.text.length < 0
                          ? Colors.red
                          : R.color.grayLightColor,
                      fontWeight: FontWeight.bold,
                      text: "${25 - companyNameController.text.length}",
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPage3() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Form(
          key: _keyFormUsername,
          child: Column(
            children: <Widget>[
              TXTextWidget(
                text: R.string.userName,
                size: 40,
                color: R.color.grayLightestColor,
                fontWeight: FontWeight.w300,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TXTextWidget(
                    textAlign: TextAlign.center,
                    text: R.string.userNameIntro,
                    color: R.color.grayLightestColor),
              ),
              SizedBox(
                height: 15,
              ),
              TXTextFieldWidget(
                  label: R.string.userNameLabel,
                  controller: userNameController,
                  autoFocus: true,
                  textColor: R.color.grayLightestColor,
                  inputBorderColor: R.color.grayLightestColor,
                  labelColor: R.color.grayLightestColor,
                  cursorColor: R.color.grayLightestColor,
                  validator: bloc.alphanumericRoomNameWithoutSpaces(),
                  focusNode: usernameFocusNode,
                  onChanged: (value) {
                    bloc.model.username = value.trim();
                    setState(() {});
                  }),
              Container(
                padding: EdgeInsets.only(top: 10),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TXTextWidget(
                      textAlign: TextAlign.right,
                      text: R.string.charsRemaining,
                      color: R.color.grayLightColor,
                    ),
                    TXTextWidget(
                      textAlign: TextAlign.right,
                      color: 18 - userNameController.text.length < 0
                          ? Colors.red
                          : R.color.grayLightColor,
                      fontWeight: FontWeight.bold,
                      text: "${18 - userNameController.text.length}",
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   height: 15,
              // ),
              // StreamBuilder<bool>(
              //   stream: bloc.checkResult,
              //   initialData: true,
              //   builder: (ctx, checkSnapshot) {
              //     return TXCheckBoxWidget(
              //       leading: true,
              //       value: checkSnapshot.data,
              //       text: R.string.noysiServiceNewsletters,
              //       textColor: R.color.grayLightestColor,
              //       onChange: (value) {
              //         bloc.changeCheck(value);
              //       },
              //     );
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }

  // Widget _getPage4() {
  //   return Container(
  //     padding: EdgeInsets.only(left: 20, right: 20),
  //     child: SingleChildScrollView(
  //       physics: BouncingScrollPhysics(),
  //       child: Form(
  //         key: _keyFormPeople,
  //         child: Column(
  //           children: <Widget>[
  //             TXTextWidget(
  //               text: R.string.invitations,
  //               size: 40,
  //               color: Colors.black,
  //               fontWeight: FontWeight.w300,
  //             ),
  //             SizedBox(
  //               height: 20,
  //             ),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 10),
  //               child: TXTextWidget(
  //                 textAlign: TextAlign.center,
  //                 text: R.string.noysiIsTeamWorkInvite,
  //               ),
  //             ),
  //             SizedBox(
  //               height: 15,
  //             ),
  //             TXTextWidget(
  //               textAlign: TextAlign.center,
  //               text: R.string.invitePeople,
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //             ),
  //             SizedBox(
  //               height: 15,
  //             ),
  //             StreamBuilder<List<InvitationsMailModel>>(
  //                 stream: bloc.invitationsResult,
  //                 initialData: [],
  //                 builder: (context, snapshotInvitations) {
  //                   return Column(
  //                     children: <Widget>[
  //                       ..._getPeopleWidgets(),
  //                       bloc.initialState
  //                           ? Container()
  //                           : TXTextFieldWidget(
  //                               controller: peopleController,
  //                               validator: bloc.email(),
  //                               autoFocus: true,
  //                             ),
  //                       TXButtonWidget(
  //                         title: R.string.addAnother,
  //                         onPressed: () {
  //                           if (_keyFormPeople.currentState.validate()) {
  //                             bloc.addPeople(peopleController.text);
  //                             peopleController.text = "";
  //                           }
  //                         },
  //                       )
  //                     ],
  //                   );
  //                 })
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // List<Widget> _getPeopleWidgets() {
  //   List<Widget> list = [];
  //   bloc.model.invitations.forEach((element) {
  //     final w = Container(
  //       child: Card(
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             Expanded(
  //               child: Container(
  //                 padding: EdgeInsets.only(left: 10, right: 5),
  //                 child: TXTextWidget(
  //                   text: element.email,
  //                   maxLines: 1,
  //                   textOverflow: TextOverflow.ellipsis,
  //                 ),
  //               ),
  //             ),
  //             TXIconButtonWidget(
  //               icon: Icon(Icons.cancel),
  //               onPressed: () {
  //                 bloc.removePeople(element);
  //               },
  //             )
  //           ],
  //         ),
  //       ),
  //     );
  //     list.add(w);
  //   });
  //   return list;
  // }
}
