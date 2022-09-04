import 'package:code/_res/R.dart';
import 'package:code/domain/account/account_model.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/_tx_widget/tx_textlink_widget.dart';
import 'package:code/ui/home/home_page.dart';
import 'package:code/ui/login/login_bloc.dart';
import 'package:code/ui/recover_password/recover_password_page.dart';
import 'package:code/ui/register/register_page.dart';
import 'package:code/ui/team_create/team_create_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  final bool tokenExpired;

  const LoginPage({this.tokenExpired = false});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends StateWithBloC<LoginPage, LoginBloC> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bloc.navResult.listen((event) async {
      if (event == 0) {
        NavigationUtils.pushReplacementWithRouteAndMaterial(
            context, HomePage(), NavigationUtils.HomeRoute);
      } else if (event == 1) {
        final createRes = await NavigationUtils.push(
            context,
            TeamCreatePage(
              loggedIn: true,
              fromLogin: true,
            ));
        if (createRes != null) {
          NavigationUtils.pushReplacementWithRouteAndMaterial(
              context, HomePage(), NavigationUtils.HomeRoute);
        }
      }
    });
    bloc.initLoginResult.listen((value) {
      if (value == null) {
        value = LoginModel(email: '', password: '');
      } else {
        emailController.text = value.email;
        passwordController.text = value.password;
      }
    });
    bloc.init(isTokenExpired: widget.tokenExpired);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    var availableWidth = MediaQuery.of(context).size.width / 6 * 5;
    var availableHeight = MediaQuery.of(context).size.height -
        (2 / 12 * MediaQuery.of(context).size.height);
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: R.color.primaryColor,
          body: TXGestureHideKeyBoard(
              child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              width: double.infinity,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: availableWidth,
                  ),
                  child: Form(
                    key: _keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height:
                              1.65 / 12 * MediaQuery.of(context).size.height,
                        ),
                        Image.asset(
                          R.image.logoNoysiGradient,
                          width: 200,
                          height: 1.7 / 12 * availableHeight,
                        ),
                        SizedBox(
                          height: 0.7 / 12 * MediaQuery.of(context).size.height,
                        ),
                        TXTextWidget(
                          text: R.string.enterIntoYourAccount,
                          color: R.color.whiteColor,
                          size: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TXTextFieldWidget(
                          label: R.string.email,
                          suffixIcon: Icons.email,
                          inputBorderColor: R.color.secondaryColor,
                          suffixIconColor: R.color.whiteColor,
                          textColor: R.color.whiteColor,
                          labelColor: R.color.whiteColor,
                          cursorColor: R.color.whiteColor,
                          validator: bloc.email(),
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          focusNode: emailFocus,
                          nextFocus: passFocus,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TXTextFieldWidget(
                          label: R.string.password,
                          validator: bloc.passwordLogin(),
                          obscureText: true,
                          inputBorderColor: R.color.secondaryColor,
                          suffixIconColor: R.color.whiteColor,
                          textColor: R.color.whiteColor,
                          labelColor: R.color.whiteColor,
                          cursorColor: R.color.whiteColor,
                          controller: passwordController,
                          focusNode: passFocus,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (pass) {
                            if (_keyForm.currentState!.validate()) {
                              bloc.login(
                                  emailController.text.trim().toLowerCase(),
                                  passwordController.text);
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          child: TXButtonWidget(
                            title: R.string.goAhead,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_keyForm.currentState!.validate()) {
                                bloc.login(
                                    emailController.text.trim().toLowerCase(),
                                    passwordController.text);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: TXTextLinkWidget(
                                title: "${R.string.forgotPassword}",
                                textDecoration: TextDecoration.none,
                                textColor: R.color.whiteColor,
                                fontSize: 14,
                                onTap: () {
                                  NavigationUtils.push(
                                      context, RecoverPasswordPage());
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: TXTextLinkWidget(
                                title: "${R.string.createNewTeam}",
                                textDecoration: TextDecoration.none,
                                textColor: R.color.whiteColor,
                                fontSize: 14,
                                onTap: () async {
                                  final res = await NavigationUtils.push(
                                      context,
                                      RegisterPage(
                                        loginModel: LoginModel(
                                            email: emailController.text,
                                            password: passwordController.text),
                                      ));
                                  if (res != null) {
                                    final createRes =
                                        await NavigationUtils.push(
                                            context,
                                            TeamCreatePage(
                                              mail: res,
                                              fromLogin: true,
                                            ));
                                    if (createRes != null) {
                                      NavigationUtils
                                          .pushReplacementWithRouteAndMaterial(
                                              context,
                                              HomePage(),
                                              NavigationUtils.HomeRoute);
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _getSeparateDivider(R.string.or.toUpperCase()),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: R.color.whiteColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(R.image.googleColor, height: 30),
                                SizedBox(width: 10),
                                TXTextWidget(
                                  text: "${R.string.connectWith} Google",
                                  color: R.color.blackColor,
                                  size: 16,
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            bloc.loginWithGoogle();
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Platform.isIOS
                            ? InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    color: R.color.whiteColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(R.image.appleWhite,
                                          height: 30, color: R.color.blackColor,),
                                      SizedBox(width: 10),
                                      TXTextWidget(
                                        text: "${R.string.connectWith} Apple",
                                        color: R.color.blackColor,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  bloc.loginWithApple();
                                },
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
        ),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        ),
      ],
    );
  }

  Widget _getSeparateDivider(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Divider(
            color: R.color.grayLightColor,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: TXTextWidget(
            text: text,
            size: 12,
          ),
        ),
        Expanded(
          child: Divider(
            color: R.color.grayLightColor,
          ),
        ),
      ],
    );
  }
}
