import 'package:code/_res/R.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_checkbox_widget.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/channel_create/channel_create_bloc.dart';
import 'package:flutter/material.dart';

class ChannelCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChannelCreateState();
}

class _ChannelCreateState
    extends StateWithBloC<ChannelCreatePage, ChannelCreateBloC> {
  TextEditingController nameController = TextEditingController();
  final _keyFormChannel = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bloc.channelResult.listen((value) {
      if (value is ChannelModel) {
        NavigationUtils.popUntilWithRouteAndMaterial(
            context, NavigationUtils.HomeRoute);
      }
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        TXGestureHideKeyBoard(
          child: TXMainAppBarWidget(
            title: R.string.createChannel,
            body: Container(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: <Widget>[
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
                                  text: R.string.createNewChannelAction,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TXTextWidget(
                                  text: R.string.openChannelAllMemberAccess,
                                  color: R.color.blackColor,
                                  fontWeight: FontWeight.bold,
                                  size: 12,
                                )
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
                      key: _keyFormChannel,
                      child: TXTextFieldWidget(
                        controller: nameController,
                        validator: bloc.alphanumericRoomName(),
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
                    TXCheckBoxWidget(
                      leading: true,
                      value: bloc.isReadOnly,
                      onChange: (value) {
                        setState(() {
                          bloc.isReadOnly = value;
                        });
                      },
                      text: R.string.createNewChannelForAdminsOnly,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TXButtonWidget(
                      onPressed: () {
                        if (_keyFormChannel.currentState!.validate()) {
                          bloc.createChannel(
                              nameController.text.trim().toLowerCase());
                        }
                      },
                      title: R.string.createChannel,
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
}
