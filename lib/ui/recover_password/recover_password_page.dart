import 'package:code/_res/R.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/recover_password/recover_password_bloc.dart';
import 'package:flutter/material.dart';

class RecoverPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState
    extends StateWithBloC<RecoverPasswordPage, RecoverPasswordBloC> {
  TextEditingController emailController = TextEditingController();
  final _keyFormRecover = GlobalKey<FormState>();

  _navBack() {
    NavigationUtils.pop(context, result: true);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navBack();
        return false;
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: R.color.primaryColor,
            body: TXGestureHideKeyBoard(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth:
                          MediaQuery.of(context).size.width / 6 * 5,
                        ),
                        child: Form(
                          key: _keyFormRecover,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 40,),
                              Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: TXIconButtonWidget(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: R.color.whiteColor,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    _navBack();
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Image.asset(R.image.logoNoysiGradient, width: 200, height: 150,),
                              TXTextWidget(
                                text: R.string.recoverYorPassword,
                                color: R.color.whiteColor,
                                size: 22,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TXTextWidget(
                                text: R.string.recoverYorPasswordWarning,
                                color: R.color.whiteColor,
                                textAlign: TextAlign.center,
                              ),
                              StreamBuilder(
                                initialData: bloc.recovered,
                                stream: bloc.recoverResult,
                                builder: (ctx, snapshot) {
                                  return snapshot.data == true
                                      ? recoverPasswordWidget()
                                      : formWidget();
                                },
                              ),
                              StreamBuilder<bool>(
                                  initialData: bloc.recovered,
                                  stream: bloc.recoverResult,
                                  builder: (context, snapshot) {
                                    return Container(
                                      width: double.infinity,
                                      child: TXButtonWidget(
                                        title: snapshot.data == true
                                            ? R.string.continueStr
                                            : R.string.goAhead,
                                        onPressed: () {
                                          if (snapshot.data == true) {
                                            _navBack();
                                          } else {
                                            if (_keyFormRecover
                                                .currentState
                                                !.validate()) {
                                              bloc.recoverPassword(
                                                  emailController.text.trim().toLowerCase());
                                            }
                                          }
                                        },
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          TXLoadingWidget(
            loadingStream: bloc.isLoadingStream,
          ),
        ],
      ),
    );
  }

  Widget formWidget() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        TXTextFieldWidget(
          label: R.string.email,
          suffixIcon: Icons.email,
          inputBorderColor: R.color.secondaryColor,
          suffixIconColor: R.color.whiteColor,
          textColor: R.color.whiteColor,
          labelColor: R.color.whiteColor,
          cursorColor: R.color.whiteColor,
          controller: emailController,
          validator: bloc.email(),
          textInputType: TextInputType.emailAddress,
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget recoverPasswordWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Container(
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
                    color: R.color.blackColor,
                    size: 16,
                    fontWeight: FontWeight.bold,
                    text: R.string.recoverPasswordResponse(
                        emailController.text.trim().toLowerCase()),
                  ),
                  TXTextWidget(
                    color: R.color.blackColor,
                    text: R.string.recoverPasswordResponse1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
