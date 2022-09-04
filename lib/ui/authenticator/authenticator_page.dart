import 'dart:async';

import 'package:code/enums.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_alert_dialog.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/authenticator/authenticator_bloc.dart';
import 'package:code/ui/_tx_widget/tx_qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;
import '../../_res/R.dart';
import '../../domain/2fa/authenticated_entity_model.dart';
import '../_tx_widget/tx_menu_option_item_widget.dart';

class AuthenticatorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthenticatorPageState();
}

class _AuthenticatorPageState
    extends StateWithBloC<AuthenticatorPage, AuthenticatorBloC>
    with TickerProviderStateMixin {
  late AnimationController timeUpFadeAnimationController;
  late StreamSubscription timeFadeSS;
  final _keyForm = GlobalKey<FormState>();
  TextEditingController _labelController = TextEditingController(),
      _secretController = TextEditingController();
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    timeUpFadeAnimationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
        lowerBound: .6,
        value: 1.0);
    timeFadeSS = bloc.timerResult.listen((event) {
      if (event > 24 && event < 30)
        timeUpFadeAnimationController.repeat(reverse: true);
      else if (event == 30) {
        timeUpFadeAnimationController.reset();
        timeUpFadeAnimationController.value = 1.0;
      }
    });
    bloc.loadData();
  }

  @override
  void dispose() {
    timeUpFadeAnimationController.dispose();
    timeFadeSS.cancel();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        }
        return true;
      },
      child: StreamBuilder<List<AuthenticatedEntity>>(
          stream: bloc.dataResult,
          initialData: [],
          builder: (context, snapshot) => TXMainAppBarWidget(
              title: R.string.noysiAuthenticator,
              floatingActionButton: SpeedDial(
                openCloseDial: isDialOpen,
                children: [..._getDialWidgets(context)],
                icon: Icons.add,
                activeIcon: Icons.close,
                backgroundColor: R.color.secondaryColor,
                iconTheme: IconThemeData(color: R.color.whiteColor),
                spacing: 10,
                spaceBetweenChildren: 5,
              ),
              actions: [
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 0,
                        child: TXMenuOptionItemWidget(
                          icon: Icon(Icons.delete_forever,
                              color: snapshot.data!.isEmpty
                                  ? R.color.grayColor
                                  : Colors.red),
                          text: R.string.deleteAll,
                          textColor: snapshot.data!.isEmpty
                              ? R.color.grayColor
                              : Colors.red,
                        ),
                      )
                    ];
                  },
                  onSelected: (key) {
                    if ((key as int) == 0 && snapshot.data!.isNotEmpty) {
                      txShowWaringDialogMaterial(context,
                          title: TXTextWidget(text: R.string.deleteAll, fontWeight: FontWeight.bold),
                          content: TXTextWidget(
                              text: R.string.operationConfirmation),
                          onAction: (ok) {
                        if (ok) bloc.removeApps();
                      });
                    }
                  },
                ),
              ],
              body: Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        ...snapshot.data!.map((e) => _getItem(e)).toList()
                      ],
                    ),
                  ),
                  TXLoadingWidget(loadingStream: bloc.isLoadingStream)
                ],
              ))),
    );
  }

  Widget _getItem(AuthenticatedEntity model) {
    return Container(
      child: StreamBuilder<int>(
        stream: bloc.timerResult,
        initialData: 30,
        builder: (context, snapshot) {
          final warning = snapshot.data! > 24 && snapshot.data! < 30;
          final spent = snapshot.data! / 30;
          return Column(
            children: [
              Slidable(
                closeOnScroll: true,
                startActionPane: ActionPane(
                  extentRatio: 0.4,
                  motion: DrawerMotion(),
                  children: [
                    SlidableAction(
                      label: R.string.delete,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      icon: Icons.delete_outline,
                      onPressed: (BuildContext context) {
                        txShowWaringDialogMaterial(context,
                            title: TXTextWidget(text: R.string.delete, fontWeight: FontWeight.bold),
                            content: TXTextWidget(
                                text: R.string.operationConfirmation),
                            onAction: (ok) {
                              if (ok) bloc.removeApp(model.id);
                            });
                      },
                    )
                  ],
                ),
                endActionPane: ActionPane(
                  extentRatio: 0.4,
                  motion: DrawerMotion(),
                  children: [
                    SlidableAction(
                      label: R.string.delete,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      icon: Icons.delete_outline,
                      onPressed: (BuildContext context) {
                        txShowWaringDialogMaterial(context,
                            title: TXTextWidget(text: R.string.delete, fontWeight: FontWeight.bold),
                            content: TXTextWidget(
                                text: R.string.operationConfirmation),
                            onAction: (ok) {
                          if (ok) bloc.removeApp(model.id);
                        });
                      },
                    )
                  ],
                ),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 7,
                        ),
                        TXTextWidget(text: "${model.label}"),
                        FadeTransition(
                            opacity: timeUpFadeAnimationController,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onLongPress: () {
                                    Clipboard.setData(
                                        ClipboardData(text: model.code));
                                    Fluttertoast.showToast(
                                        msg:
                                            "${model.code} ${R.string.copiedToClipboard}");
                                  },
                                  child: TXTextWidget(
                                      text: model.code,
                                      size: 36,
                                      fontWeight: FontWeight.w600,
                                      color: warning
                                          ? Colors.red
                                          : R.color.secondaryColor),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Container(
                                  height: 25,
                                  width: 25,
                                  margin: EdgeInsets.only(right: 5),
                                  child: ShaderMask(
                                      shaderCallback: (rect) {
                                        return SweepGradient(
                                                startAngle: 0.0,
                                                endAngle: math.pi * 2,
                                                stops: [spent, spent],
                                                center: Alignment.center,
                                                colors: [
                                                  Colors.transparent,
                                                  warning
                                                      ? Colors.red
                                                      : R.color.secondaryColor
                                                ],
                                                transform: GradientRotation(
                                                    -math.pi / 2))
                                            .createShader(rect);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                      )),
                                )
                              ],
                            )),
                        SizedBox(
                          height: 7,
                        ),
                      ],
                    )),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 1,
                color: R.color.grayLightColor,
              )
            ],
          );
        },
      ),
    );
  }

  List<SpeedDialChild> _getDialWidgets(BuildContext context) {
    final qr = SpeedDialChild(
      child: Icon(Icons.qr_code_scanner),
      label: R.string.qrScanner,
      labelStyle: TextStyle(fontSize: 20),
      onTap: () async {
        final res = await NavigationUtils.push(context, QRScanner()) as String?;
        if (res?.isNotEmpty == true) {
          bloc.processQrResult(res!);
        }
      },
    );
    final manual = SpeedDialChild(
      child: Icon(Icons.keyboard),
      label: R.string.enterKeyManually,
      labelStyle: TextStyle(fontSize: 20),
      onTap: () {
        _showManualKeyForm(context);
      },
    );
    return [qr, manual];
  }

  void _showManualKeyForm(BuildContext context) {
    txShowWaringDialogMaterial(context,
        title: TXTextWidget(
            text: R.string.enterKeyManually,
            fontWeight: FontWeight.bold,
            size: 20),
        content: Container(
          height: 170,
          child: Form(
              key: _keyForm,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  TXTextFieldWidget(
                      controller: _labelController,
                      validator: bloc.otpLabelValidator(),
                      label: R.string.label),
                  SizedBox(
                    height: 15,
                  ),
                  TXTextFieldWidget(
                      controller: _secretController,
                      validator: bloc.otpSecretValidator(),
                      label: R.string.secretCode),
                ],
              )),
        ),
        alwaysPopDialog: false,
        barrierDismissible: false, onAction: (ok) {
      if (ok && _keyForm.currentState!.validate()) {
        bloc.createApp(
            "", _labelController.text, OTPType.totp, _secretController.text);
        NavigationUtils.pop(context);
        _labelController.clear();
        _secretController.clear();
      } else if (!ok) {
        NavigationUtils.pop(context);
        _labelController.clear();
        _secretController.clear();
      }
    }, noText: R.string.cancel, yesText: R.string.accept);
  }
}
