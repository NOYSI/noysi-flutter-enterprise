import 'package:code/_res/R.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_bottomsheet_selector_widget.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/invite_people/invite_people_bloc.dart';
import 'package:code/ui/invite_people/invite_peoploe_new_model_ui.dart';
import 'package:flutter/material.dart';

import '../../domain/channel/channel_model.dart';

class InvitePeoplePage extends StatefulWidget {
  final bool inviteMembers;
  final List<ChannelModel> privateGroups;

  const InvitePeoplePage(
      {Key? key, required this.inviteMembers, required this.privateGroups})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _InvitePeopleNewState();
}

class _InvitePeopleNewState
    extends StateWithBloC<InvitePeoplePage, InvitePeopleBloC> {
  TextEditingController emailController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final _keyFormInvite = new GlobalKey<FormState>();

  _navBack(List<String>? failedEmails) {
    NavigationUtils.pop(context, result: failedEmails);
  }

  @override
  void initState() {
    super.initState();
    bloc.initViewData(widget.inviteMembers, widget.privateGroups);
    bloc.invitationsSentResult.listen((event) {
      _navBack(event);
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navBack(null);
        return false;
      },
      child: Stack(
        children: <Widget>[
          TXMainAppBarWidget(
            centeredTitle: true,
            title: R.string.sendInvitations,
            onLeadingTap: () {
              _navBack(null);
            },
            body: Container(
              child: StreamBuilder<InvitePeopleModelUI>(
                  stream: bloc.initResult,
                  initialData: null,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) return Container();
                    final model = snapshot.data;
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: R.color.grayLightestColor),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.info,
                                  color: R.color.secondaryColor,
                                  size: 60,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TXTextWidget(
                                        color: R.color.blackColor,
                                        size: 14,
                                        text: widget.inviteMembers
                                            ? R.string.inviteMemberWarning
                                            : R.string.inviteGuestsWarning,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              controller: scrollController,
                              padding: EdgeInsets.symmetric(horizontal: 10)
                                  .copyWith(top: 5, bottom: 50),
                              child: Form(
                                key: _keyFormInvite,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Container(
                                    //   child: Wrap(
                                    //     alignment: WrapAlignment.start,
                                    //     spacing: 5,
                                    //     children: [
                                    //       ..._getEmails(snapshot.data.emails)
                                    //     ],
                                    //   ),
                                    //   width: double.infinity,
                                    // ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    TXTextWidget(
                                      text: widget.inviteMembers
                                          ? R.string.inviteToAGroupNotRequired
                                          : R.string.inviteToAGroup,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    model!.groups!.isNotEmpty
                                        ? TXBottomSheetSelectorWidget(
                                            itemTextSize: 18,
                                            list: model.groups!,
                                            onItemSelected: (value) {
                                              model.groups?.forEach((element) {
                                                element.isSelected =
                                                    element.id == value.id;
                                              });
                                              model.groupRequired = null;
                                              bloc.refreshData;
                                            },
                                            title: widget.inviteMembers
                                                ? R.string
                                                    .inviteToAGroupNotRequired
                                                : R.string.inviteToAGroup,
                                          )
                                        : Container(),
                                    (model.groupRequired != null &&
                                            model.groupRequired!)
                                        ? TXTextWidget(
                                            text: R.string.groupRequired,
                                            color: Colors.red[600],
                                            size: 12,
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    TXTextWidget(
                                      text: R.string.invitationLanguageTitle,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TXBottomSheetSelectorWidget(
                                      itemTextSize: 18,
                                      list: model.languageInvitations,
                                      onItemSelected: (value) {
                                        final previousLang = model
                                            .languageInvitations
                                            .firstWhere((element) =>
                                                element.isSelected);
                                        if (bloc.descriptionController.text
                                                .trim() ==
                                            bloc
                                                .getBodyMessageClass(
                                                    previousLang.id)
                                                .invitationMessageDefault)
                                          bloc.descriptionController.text = bloc
                                              .getBodyMessageClass(value.id)
                                              .invitationMessageDefault;
                                        model.languageInvitations
                                            .forEach((element) {
                                          element.isSelected =
                                              element.id == value.id;
                                        });
                                        bloc.refreshData;
                                      },
                                      title: R.string.invitationLanguageTitle,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    TXTextWidget(
                                      text: R.string.invitationMessage,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TXTextFieldWidget(
                                      controller: bloc.descriptionController,
                                      minLines: 5,
                                      maxLines: 10,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    TXTextWidget(
                                      text: widget.inviteMembers
                                          ? R.string.addMembers
                                          : R.string.addGuests,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Column(
                                      children: [
                                        ..._getInvitationsEmailsNameWidget()
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        bloc.addInvitationPeople();
                                      },
                                      child: Row(
                                        children: [
                                          TXTextWidget(
                                            text: R.string.addAnother,
                                            fontWeight: FontWeight.bold,
                                            color: R.color.secondaryColor,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.add_circle_outline,
                                            color: R.color.secondaryColor,
                                            size: 15,
                                          )
                                        ],
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     model.inviteMany = !model.inviteMany;
                                    //     bloc.refreshData;
                                    //   },
                                    //   child: Row(
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.center,
                                    //     children: [
                                    //       TXTextWidget(
                                    //         text: !model.inviteMany
                                    //             ? R.string.inviteManyAtOnce
                                    //             : R.string
                                    //                 .inviteFewMorePersonal,
                                    //         color: R.color.blackColor,
                                    //         fontWeight: FontWeight.bold,
                                    //       ),
                                    //       SizedBox(
                                    //         width: 5,
                                    //       ),
                                    //       Icon(
                                    //         Icons.add_circle_outline,
                                    //         color: R.color.blackColor,
                                    //         size: 15,
                                    //       )
                                    //     ],
                                    //   ),
                                    // )
                                  ],
                                ),
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
                            title: R.string.invite,
                            onPressed: () {
                              if (_keyFormInvite.currentState!.validate()) {
                                bloc.invite();
                              }
                            },
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ),
          TXLoadingWidget(
            loadingStream: bloc.isLoadingStream,
          )
        ],
      ),
    );
  }

  List<Widget> _getInvitationsEmailsNameWidget() {
    List<Widget> cardsInvitations = [];
    for (int i = 0;
        i < bloc.invitePeopleModelUI.invitePeopleEmailNameList.length;
        i++) {
      final element = bloc.invitePeopleModelUI.invitePeopleEmailNameList[i];
      final w = Card(
        margin: EdgeInsets.symmetric(horizontal: 0).copyWith(bottom: 10),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              TXTextFieldWidget(
                textInputType: TextInputType.emailAddress,
                controller: element.emailController,
                label: R.string.email,
                validator: bloc.email(),
              ),
              SizedBox(
                height: 10,
              ),
              TXTextFieldWidget(
                controller: element.nameController,
                label: R.string.firstName,
                validator: bloc.required(),
              )
            ],
          ),
        ),
      );
      cardsInvitations.add(Row(
        children: [
          Expanded(child: w),
          i > 0
              ? TXIconButtonWidget(
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    bloc.removeInvitationPeople(element);
                  },
                )
              : Container()
        ],
      ));
    }
    return cardsInvitations;
  }
}
