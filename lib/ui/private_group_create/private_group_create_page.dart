import 'package:code/_res/R.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/private_group_create/private_group_create_bloc.dart';
import 'package:code/ui/search_user/search_user_page.dart';
import 'package:code/utils/common_utils.dart';
import 'package:flutter/material.dart';

class PrivateGroupCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PrivateGroupCreateState();
}

class _PrivateGroupCreateState
    extends StateWithBloC<PrivateGroupCreatePage, PrivateGroupCreateBloC> {
  TextEditingController nameController = TextEditingController();
  final _keyFormPrivateGroup = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bloc.privateGroupResult.listen((value) {
      NavigationUtils.popUntilWithRouteAndMaterial(
          context, NavigationUtils.HomeRoute);
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: [
        TXGestureHideKeyBoard(
          child: TXMainAppBarWidget(
            title: R.string.createPrivateGroup,
            body: Container(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: <Widget>[
                    TXTextWidget(
                      text: R.string.createNewPrivateGroup,
                      size: 20,
                      color: R.color.blackColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TXTextWidget(
                                  text: R.string.createPrivateGroupWarning,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _keyFormPrivateGroup,
                      child: TXTextFieldWidget(
                        controller: nameController,
                        validator: bloc.alphanumericRoomName(),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: TXTextWidget(
                        textAlign: TextAlign.right,
                        text: R.string.fieldMax25,
                        size: 12,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        TXTextWidget(
                          text: R.string.users,
                        ),
                        TXIconButtonWidget(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () async {
                            final res = await NavigationUtils.push(
                                context,
                                SearchUserPage(
                                  pickMember: true,
                                  userGroupBy: UserGroupBy.team,
                                  excludeMembers:
                                      bloc.members.map((e) => e.id).toList(),
                                  excludeBotMembers: true,
                                ));
                            if (res is MemberModel) {
                              bloc.addMember(res);
                            }
                          },
                        )
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: StreamBuilder<List<MemberModel>?>(
                        stream: bloc.membersResult,
                        initialData: [],
                        builder: (ctx, snapshot) {
                          if (snapshot.data?.isEmpty == true) return Container();
                          return Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 5,
                            children: [..._getMembers(snapshot.data!)],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TXButtonWidget(
                      onPressed: () {
                        if (_keyFormPrivateGroup.currentState!.validate()) {
                          bloc.createPrivateGroup(
                              nameController.text.trim().toLowerCase());
                        }
                      },
                      title: R.string.createPrivateGroup,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        )
      ],
    );
  }

  List<Widget> _getMembers(List<MemberModel> members) {
    List<Widget> list = [];
    members.forEach((member) {
      final w = Chip(
        backgroundColor: R.color.primaryLightColor,
        label: TXTextWidget(
          text: "@${CommonUtils.getMemberUsername(member)}",
          color: R.color.whiteColor,
        ),
        deleteIcon: Icon(
          Icons.remove_circle,
          color: R.color.whiteColor,
        ),
        onDeleted: () {
          bloc.removeMember(member);
        },
      );
      list.add(w);
    });
    return list;
  }
}
