import 'package:code/_res/R.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_checkbox_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/channel_preferences/channel_preferences_bloc.dart';
import 'package:flutter/material.dart';

class ChannelPreferencesPage extends StatefulWidget {
  final ChannelModel? channelModel;

  const ChannelPreferencesPage({
    Key? key,
    this.channelModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChannelPreferencesState();
}

class _ChannelPreferencesState
    extends StateWithBloC<ChannelPreferencesPage, ChannelPreferencesBloC> {
  _navBack() {
    NavigationUtils.pop(context, result: bloc.channelModel);
  }

  @override
  void initState() {
    super.initState();
    bloc.initData(widget.channelModel);
    bloc.channelUpdatedResult.listen((channel) {
      _navBack();
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navBack();
        return false;
      },
      child: Stack(
        children: <Widget>[
          TXMainAppBarWidget(
            title: R.string.channelPreferences,
            leading: TXIconButtonWidget(
              icon: Icon(
                Icons.keyboard_arrow_left,
                size: 30,
              ),
              onPressed: () {
                _navBack();
              },
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    TXTextWidget(
                      text: R.string.notifications,
                      fontWeight: FontWeight.bold,
                      color: R.color.blackColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TXCheckBoxWidget(
                      leading: true,
                      text: R.string.turnOffChannelSounds,
                      value: !bloc.sounds,
                      onChange: (value) {
                        setState(() {
                          bloc.sounds = !value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TXCheckBoxWidget(
                      leading: true,
                      text: R.string.sendAlwaysAPush,
                      value: bloc.pushesAlways,
                      onChange: (value) {
                        setState(() {
                          bloc.pushesAlways = value;
                        });
                      },
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // TXCheckBoxWidget(
                    //   leading: true,
                    //   text: R.string.turnOffChannelEmails,
                    //   value: bloc.emails,
                    //   onChange: (value) {
                    //     setState(() {
                    //       bloc.emails = value;
                    //     });
                    //   },
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                    TXButtonWidget(
                      onPressed: () {
                        if (bloc.sounds !=
                                widget.channelModel!.notifications!
                                    .sounds /*||
                            bloc.emails !=
                                widget.channelModel.notifications.emails*/
                            ||
                            bloc.pushesAlways !=
                                widget.channelModel!.notifications!.alwaysPush) {
                          bloc.setNotifications();
                        } else
                          _navBack();
                      },
                      title: R.string.savePreferences,
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
}
