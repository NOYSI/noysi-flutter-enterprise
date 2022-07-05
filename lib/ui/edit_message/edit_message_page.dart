import 'package:code/_res/R.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/edit_message/edit_message_bloc.dart';
import 'package:flutter/material.dart';

class EditMessagePage extends StatefulWidget {
  final MessageModel model;

  const EditMessagePage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditMessageState();
}

class _EditMessageState
    extends StateWithBloC<EditMessagePage, EditMessageBloC> {
  TextEditingController textEditingController = TextEditingController();
  final _keyFormEditMessage = new GlobalKey<FormState>();

  _navBack() {
    NavigationUtils.pop(context, result: bloc.edited ? bloc.model : null);
  }

  @override
  void initState() {
    super.initState();
    String text = widget.model.hasAnswerMessage &&
            widget.model.links.isNotEmpty == true &&
            widget.model.text.contains(widget.model.links[0])
        ? widget.model.text.replaceAll(widget.model.links[0], "").trim()
        : widget.model.text;
    textEditingController.text = text;
    bloc.model = widget.model;
    bloc.editResult.listen((edited) {
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
            title: R.string.edit,
            onLeadingTap: () {
              _navBack();
            },
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Form(
                key: _keyFormEditMessage,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TXTextFieldWidget(
                        controller: textEditingController,
                        validator: bloc.required(),
                        maxLines: 10,
                        textInputType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                      ),
                      constraints: BoxConstraints(
                        maxHeight: 200,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TXButtonWidget(
                      title: R.string.saveChanges,
                      onPressed: () {
                        if (_keyFormEditMessage.currentState!.validate()) {
                          bloc.edit(textEditingController.text);
                        }
                      },
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
