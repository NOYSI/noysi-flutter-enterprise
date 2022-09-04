import 'package:code/_res/R.dart';
import 'package:code/domain/account/account_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_icon_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/register/register_bloc.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final LoginModel loginModel;

  const RegisterPage({Key? key, required this.loginModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends StateWithBloC<RegisterPage, RegisterBloC> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  _navBack() {
    NavigationUtils.pop(context, result: bloc.registeredMail);
  }

  @override
  void initState() {
    super.initState();
    emailController.text = widget.loginModel.email;
    passwordController.text = widget.loginModel.password;
    bloc.registerResult.listen((event) {
      if (event) {
        _navBack();
      }
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
          Scaffold(
            backgroundColor: R.color.primaryColor,
            body: TXGestureHideKeyBoard(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 6 * 5,
                      ),
                      child: Form(
                        key: _keyForm,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
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
                              text: R.string.createANewTeam,
                              color: R.color.whiteColor,
                              size: 22,
                            ),
                            SizedBox(
                              height: 10,
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
                            // SizedBox(
                            //   height: 30,
                            // ),
                            // TXTextFieldWidget(
                            //   label: R.string.password,
                            //   obscureText: true,
                            //   inputBorderColor: R.color.secondaryColor,
                            //   suffixIconColor: R.color.whiteColor,
                            //   textColor: R.color.whiteColor,
                            //   labelColor: R.color.whiteColor,
                            //   cursorColor: R.color.whiteColor,
                            //   controller: passwordController,
                            //   validator: bloc.password(),
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              child: TXButtonWidget(
                                title: R.string.createNewTeam,
                                onPressed: () {
                                  if (_keyForm.currentState!.validate()) {
                                    bloc.checkMail(
                                        emailController.text
                                            .trim()
                                            .toLowerCase());
                                  }
                                },
                              ),
                            ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // TXTextWidget(
                            //   text: R.string.passwordRestriction,
                            //   textAlign: TextAlign.justify,
                            //   color: R.color.whiteColor,
                            // )
                          ],
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
          )
        ],
      ),
    );
  }
}
