import 'package:code/_res/R.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/channel_rename/channel_rename_bloc.dart';
import 'package:flutter/material.dart';

class ChannelRenamePage extends StatefulWidget {
  final ChannelModel? channelModel;

  const ChannelRenamePage({Key? key, this.channelModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChannelRenameState();
}

class _ChannelRenameState
    extends StateWithBloC<ChannelRenamePage, ChannelRenameBloC> {
  _navBack() {
    NavigationUtils.pop(context);
  }

  @override
  void initState() {
    super.initState();
    bloc.channelModel = widget.channelModel;

    bloc.channelUpdatedResult.listen((channel) {
      _navBack();
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: widget.channelModel?.titleFixed);
    final _keyFormChannelRename = new GlobalKey<FormState>();

    return WillPopScope(
      onWillPop: () async {
        _navBack();
        return false;
      },
      child: Stack(
        children: <Widget>[
          TXMainAppBarWidget(
            title: R.string.rename,
            leading: TXIconButtonWidget(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                _navBack();
              },
            ),
            body: Container(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _keyFormChannelRename,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          width: double.infinity,
                          child: TXTextWidget(
                            text: R.string.newName,
                            color: Colors.black,
                            textAlign: TextAlign.start,
                          )),
                      TXTextFieldWidget(
                        controller: nameController,
                        validator: bloc.alphanumericRoomName(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        child: TXTextWidget(
                          color: R.color.blackColor,
                          text: R.string.createNameWarning,
                          size: 12,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: TXButtonWidget(
                          onPressed: () {
                            if (_keyFormChannelRename.currentState!.validate()) {
                              bloc.renameChannel(
                                  nameController.text.trim().toLowerCase());
                            }
                          },
                          title: R.string.rename,
                        ),
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
      ),
    );
  }
}
