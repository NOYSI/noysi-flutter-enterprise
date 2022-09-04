import 'dart:async';

import 'package:code/_res/R.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/rtc/rtc_manager.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_alert_dialog.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_checkbox_widget.dart';
import 'package:code/ui/_tx_widget/tx_cupertino_dialog_widget.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_media_selector_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/edit_team/edit_team_bloc.dart';
import 'package:code/utils/file_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/api/remote/remote_constants.dart';
import '../../domain/usage/usage_model.dart';
import '../_tx_widget/tx_button_widget.dart';
import '../_tx_widget/tx_info_widget.dart';
import '../_tx_widget/tx_textfield_widget.dart';

class EditTeamPage extends StatefulWidget {
  final TeamModel? teamModel;

  const EditTeamPage({this.teamModel});

  @override
  State<StatefulWidget> createState() => _EditTeamState();
}

class _EditTeamState extends StateWithBloC<EditTeamPage, EditTeamBloC> {
  PageController pageController = PageController(initialPage: 0);
  final _keyFormName = new GlobalKey<FormState>();
  StreamSubscription? ssTeamPhotoUpdated, ssTeamUpdated, ssThemeUpdated;

  @override
  void initState() {
    super.initState();
    ssTeamPhotoUpdated = onTeamPhotoUpdatedController.listen((value) {
      bloc.doOnTeamPhotoUpdated(value);
    });
    ssTeamUpdated = onTeamUpdatedController.listen((value) {
      bloc.doOnTeamUpdated(value);
    });
    ssThemeUpdated = onTeamThemeUpdatedController.listen((value) {
      bloc.doOnThemeUpdated(value);
    });
    bloc.init(widget.teamModel);
  }

  @override
  void dispose() {
    ssTeamPhotoUpdated?.cancel();
    ssTeamUpdated?.cancel();
    ssThemeUpdated?.cancel();
    super.dispose();
  }

  Widget _getTab(int index, bool isActive, String title) {
    return InkWell(
      onTap: () {
        if (!isActive) bloc.changePageTab(index);
        pageController.jumpToPage(index);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: isActive ? 5.0 : 1,
                color: isActive
                    ? R.color.secondaryColor
                    : R.color.grayLightestColor),
          ),
        ),
        padding: EdgeInsets.only(bottom: 10, left: 25, right: 25, top: 20),
        child: TXTextWidget(
          text: "${title.toUpperCase()}",
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.normal,
          size: 16,
          color: isActive ? R.color.grayDarkestColor : R.color.grayColor,
        ),
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        TXMainAppBarWidget(
          title: R.string.editTeam,
          body: Container(
            child: Column(
              children: <Widget>[
                StreamBuilder<int>(
                    stream: bloc.pageTabResult,
                    initialData: 0,
                    builder: (context, snapshotTab) {
                      return Container(
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child:
                                  _getTab(0, snapshotTab.data == 0, R.string.settings),
                            ),
                            Expanded(
                              child: _getTab(1, snapshotTab.data == 1, R.string.theme),
                            ),
                            _getTab(
                                2, snapshotTab.data == 2, R.string.security),
                          ],
                        ),
                      );
                    }),
                Expanded(
                  child: StreamBuilder<TeamModel>(
                    stream: bloc.teamResult,
                    initialData: null,
                    builder: (ctx, snapshot) {
                      return PageView.builder(
                        physics: BouncingScrollPhysics(),
                        controller: pageController,
                        itemBuilder: (ctx, index) {
                          return SingleChildScrollView(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, bottom: 30, top: 30),
                            child: snapshot.data == null
                                ? Container()
                                : index == 2
                                    ? _getSecurity(snapshot.data!)
                                    : index == 1
                                        ? _getTheme()
                                        : _getSettings(snapshot.data!),
                          );
                        },
                        onPageChanged: (page) {
                          bloc.changePageTab(page);
                        },
                        itemCount: 3,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        TXLoadingWidget(
          loadingStream: bloc.isLoadingStream,
        )
      ],
    );
  }

  Widget _getSettings(TeamModel model) {
    return TXGestureHideKeyBoard(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: R.color.grayColor, width: .5)),
            child: model.photo != null
                ? TXNetworkImage(
                    width: 100,
                    height: 100,
                    forceLoad: true,
                    imageUrl: model.photo!,
                    placeholderImage: Image.asset(R.image.logo),
                  )
                : Container(
                    height: 100,
                    width: 100,
                  ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: R.color.grayColor, width: .5)),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              onTap: () {
                showTXModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return _showSourceSelector(context);
                    });
              },
              child: TXTextWidget(
                text: R.string.changePhoto,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: TXTextWidget(
              text: R.string.teamName,
              color: R.color.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Form(
            key: _keyFormName,
            child: TXTextFieldWidget(
              controller: bloc.teamNameController,
              validator: bloc.alphanumericRoomName(),
              onChanged: (text) {
                bloc.checkSaveButtonSettings();
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TXCheckBoxWidget(
            leading: true,
            text: R.string.adminsCanDeleteMessage,
            removeCheckboxExtraPadding: true,
            textColor: R.color.blackColor,
            value: model.adminsCanDelete ?? false,
            crossAxisAlignment: CrossAxisAlignment.start,
            onChange: (value) {
              bloc.teamModel.adminsCanDelete = value;
              bloc.checkSaveButtonSettings();
            },
          ),
          SizedBox(
            height: 10,
          ),
          TXCheckBoxWidget(
            leading: true,
            text: R.string.allForAdminsOnly,
            removeCheckboxExtraPadding: true,
            textColor: R.color.blackColor,
            value: model.allMentionProtected ?? false,
            crossAxisAlignment: CrossAxisAlignment.start,
            onChange: (value) {
              bloc.teamModel.allMentionProtected = value;
              bloc.checkSaveButtonSettings();
            },
          ),
          SizedBox(
            height: 10,
          ),
          TXCheckBoxWidget(
            leading: true,
            text: R.string.channelForAdminsOnly,
            removeCheckboxExtraPadding: true,
            textColor: R.color.blackColor,
            value: model.channelMentionProtected ?? false,
            crossAxisAlignment: CrossAxisAlignment.start,
            onChange: (value) {
              bloc.teamModel.channelMentionProtected = value;
              bloc.checkSaveButtonSettings();
            },
          ),
          SizedBox(
            height: 10,
          ),
          TXCheckBoxWidget(
            leading: true,
            text:
                R.string.taskUpdateProtected,
            removeCheckboxExtraPadding: true,
            textColor: R.color.blackColor,
            value: model.taskUpdateProtected ?? false,
            crossAxisAlignment: CrossAxisAlignment.start,
            onChange: (value) {
              bloc.teamModel.taskUpdateProtected = value;
              bloc.checkSaveButtonSettings();
            },
          ),
          SizedBox(
            height: 10,
          ),
          TXCheckBoxWidget(
            leading: true,
            text: R.string.updateUsernameBlocked,
            removeCheckboxExtraPadding: true,
            textColor: R.color.blackColor,
            value: model.updateUsernameBlocked ?? false,
            crossAxisAlignment: CrossAxisAlignment.start,
            onChange: (value) {
              bloc.teamModel.updateUsernameBlocked = value;
              bloc.checkSaveButtonSettings();
            },
          ),
          SizedBox(
            height: 10,
          ),
          TXCheckBoxWidget(
            leading: true,
            text: R.string.onlyAdminInvitesAllowed,
            removeCheckboxExtraPadding: true,
            textColor: R.color.blackColor,
            value: model.onlyAdminInvitesAllowed ?? false,
            crossAxisAlignment: CrossAxisAlignment.start,
            onChange: (value) {
              bloc.teamModel.onlyAdminInvitesAllowed = value;
              bloc.checkSaveButtonSettings();
            },
          ),
          SizedBox(
            height: 10,
          ),
          TXCheckBoxWidget(
            leading: true,
            text: R.string.showEmails,
            removeCheckboxExtraPadding: true,
            textColor: R.color.blackColor,
            value: model.showEmails,
            crossAxisAlignment: CrossAxisAlignment.start,
            onChange: (value) {
              bloc.teamModel.showEmails = value;
              bloc.checkSaveButtonSettings();
            },
          ),
          SizedBox(
            height: 10,
          ),
          TXCheckBoxWidget(
            leading: true,
            text: R.string.showPhoneNumbers,
            removeCheckboxExtraPadding: true,
            textColor: R.color.blackColor,
            value: model.showPhoneNumbers,
            crossAxisAlignment: CrossAxisAlignment.start,
            onChange: (value) {
              bloc.teamModel.showPhoneNumbers = value;
              bloc.checkSaveButtonSettings();
            },
          ),
          SizedBox(
            height: 10,
          ),
          TXCheckBoxWidget(
            leading: true,
            text: R.string.enablePushAllChannels,
            removeCheckboxExtraPadding: true,
            textColor: R.color.blackColor,
            value: model.alwaysPush ?? false,
            crossAxisAlignment: CrossAxisAlignment.start,
            onChange: (value) {
              bloc.teamModel.alwaysPush = value;
              bloc.checkSaveButtonSettings();
            },
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: StreamBuilder<bool>(
              initialData: false,
              stream: bloc.saveButtonSettingsResult,
              builder: (context, snapshot) {
                return TXButtonWidget(
                  title: R.string.saveChanges,
                  mainColor: snapshot.data!
                      ? R.color.secondaryColor
                      : R.color.grayLightColor,
                  splashColor: snapshot.data!
                      ? R.color.secondaryHeaderColor
                      : R.color.grayLightColor,
                  onPressed: () async {
                    if (snapshot.data! &&
                        _keyFormName.currentState!.validate()) {
                      bloc.checkTeamNameAndUpdate();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTheme() {
    return StreamBuilder<TeamTheme>(
        stream: bloc.teamEditThemeController.stream,
        initialData: R.color.defaultTheme,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TXTextWidget(
                  text: R.string.chooseTheme,
                  size: 20,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: 15,
              ),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _getSelectableTheme(
                      RemoteConstants.defaultTheme,
                      R.image.defaultTheme,
                      snapshot.data!.themeName == RemoteConstants.defaultTheme),
                  _getSelectableTheme(
                      RemoteConstants.bluejeansTheme,
                      R.image.bluejeansTheme,
                      snapshot.data!.themeName ==
                          RemoteConstants.bluejeansTheme),
                  _getSelectableTheme(
                      RemoteConstants.blackboardTheme,
                      R.image.blackboardTheme,
                      snapshot.data!.themeName ==
                          RemoteConstants.blackboardTheme),
                  _getSelectableTheme(
                      RemoteConstants.lightTheme,
                      R.image.lightTheme,
                      snapshot.data!.themeName == RemoteConstants.lightTheme),
                  _getSelectableTheme(
                      RemoteConstants.greenbeansTheme,
                      R.image.greenBeansTheme,
                      snapshot.data!.themeName ==
                          RemoteConstants.greenbeansTheme),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _getSelectableColor(
                      R.string.sidebarColor, snapshot.data!.colors.sidebarColor,
                      (color) {
                    final theme = bloc.teamEditThemeController.value;
                    final newTheme = TeamTheme(
                        theme.themeName,
                        TeamColors(
                          textColor: theme.colors.textColor,
                          activeItemBackground:
                              theme.colors.activeItemBackground,
                          activeItemText: theme.colors.activeItemText,
                          activePresence: theme.colors.activePresence,
                          inactivePresence: theme.colors.inactivePresence,
                          notificationBadgeBackground:
                              theme.colors.notificationBadgeBackground,
                          notificationBadgeText:
                              theme.colors.notificationBadgeText,
                          sidebarColor: color,
                        ));
                    bloc.sinkTheme(newTheme);
                  }),
                  _getSelectableColor(R.string.activeItemBackgroundColor,
                      snapshot.data!.colors.activeItemBackground, (color) {
                    final theme = bloc.teamEditThemeController.value;
                    final newTheme = TeamTheme(
                        theme.themeName,
                        TeamColors(
                          textColor: theme.colors.textColor,
                          activeItemBackground: color,
                          activeItemText: theme.colors.activeItemText,
                          activePresence: theme.colors.activePresence,
                          inactivePresence: theme.colors.inactivePresence,
                          notificationBadgeBackground:
                              theme.colors.notificationBadgeBackground,
                          notificationBadgeText:
                              theme.colors.notificationBadgeText,
                          sidebarColor: theme.colors.sidebarColor,
                        ));
                    bloc.sinkTheme(newTheme);
                  }),
                  _getSelectableColor(
                      R.string.activeItemTextColor, snapshot.data!.colors.activeItemText,
                      (color) {
                    final theme = bloc.teamEditThemeController.value;
                    final newTheme = TeamTheme(
                        theme.themeName,
                        TeamColors(
                          textColor: theme.colors.textColor,
                          activeItemBackground:
                              theme.colors.activeItemBackground,
                          activeItemText: color,
                          activePresence: theme.colors.activePresence,
                          inactivePresence: theme.colors.inactivePresence,
                          notificationBadgeBackground:
                              theme.colors.notificationBadgeBackground,
                          notificationBadgeText:
                              theme.colors.notificationBadgeText,
                          sidebarColor: theme.colors.sidebarColor,
                        ));
                    bloc.sinkTheme(newTheme);
                  }),
                  _getSelectableColor(
                      R.string.textColor, snapshot.data!.colors.textColor, (color) {
                    final theme = bloc.teamEditThemeController.value;
                    final newTheme = TeamTheme(
                        theme.themeName,
                        TeamColors(
                          textColor: color,
                          activeItemBackground:
                              theme.colors.activeItemBackground,
                          activeItemText: theme.colors.activeItemText,
                          activePresence: theme.colors.activePresence,
                          inactivePresence: theme.colors.inactivePresence,
                          notificationBadgeBackground:
                              theme.colors.notificationBadgeBackground,
                          notificationBadgeText:
                              theme.colors.notificationBadgeText,
                          sidebarColor: theme.colors.sidebarColor,
                        ));
                    bloc.sinkTheme(newTheme);
                  }),
                  _getSelectableColor(
                      R.string.activePresenceColor, snapshot.data!.colors.activePresence,
                      (color) {
                    final theme = bloc.teamEditThemeController.value;
                    final newTheme = TeamTheme(
                        theme.themeName,
                        TeamColors(
                          textColor: theme.colors.textColor,
                          activeItemBackground:
                              theme.colors.activeItemBackground,
                          activeItemText: theme.colors.activeItemText,
                          activePresence: color,
                          inactivePresence: theme.colors.inactivePresence,
                          notificationBadgeBackground:
                              theme.colors.notificationBadgeBackground,
                          notificationBadgeText:
                              theme.colors.notificationBadgeText,
                          sidebarColor: theme.colors.sidebarColor,
                        ));
                    bloc.sinkTheme(newTheme);
                  }),
                  _getSelectableColor(R.string.inactivePresenceColor,
                      snapshot.data!.colors.inactivePresence, (color) {
                    final theme = bloc.teamEditThemeController.value;
                    final newTheme = TeamTheme(
                        theme.themeName,
                        TeamColors(
                          textColor: theme.colors.textColor,
                          activeItemBackground:
                              theme.colors.activeItemBackground,
                          activeItemText: theme.colors.activeItemText,
                          activePresence: theme.colors.activePresence,
                          inactivePresence: color,
                          notificationBadgeBackground:
                              theme.colors.notificationBadgeBackground,
                          notificationBadgeText:
                              theme.colors.notificationBadgeText,
                          sidebarColor: theme.colors.sidebarColor,
                        ));
                    bloc.sinkTheme(newTheme);
                  }),
                  _getSelectableColor(R.string.notificationBadgeBackgroundColor,
                      snapshot.data!.colors.notificationBadgeBackground,
                      (color) {
                    final theme = bloc.teamEditThemeController.value;
                    final newTheme = TeamTheme(
                        theme.themeName,
                        TeamColors(
                          textColor: theme.colors.textColor,
                          activeItemBackground:
                              theme.colors.activeItemBackground,
                          activeItemText: theme.colors.activeItemText,
                          activePresence: theme.colors.activePresence,
                          inactivePresence: theme.colors.inactivePresence,
                          notificationBadgeBackground: color,
                          notificationBadgeText:
                              theme.colors.notificationBadgeText,
                          sidebarColor: theme.colors.sidebarColor,
                        ));
                    bloc.sinkTheme(newTheme);
                  }),
                  _getSelectableColor(
                      R.string.notificationBadgeTextColor, snapshot.data!.colors.notificationBadgeText,
                      (color) {
                    final theme = bloc.teamEditThemeController.value;
                    final newTheme = TeamTheme(
                        theme.themeName,
                        TeamColors(
                          textColor: theme.colors.textColor,
                          activeItemBackground:
                              theme.colors.activeItemBackground,
                          activeItemText: theme.colors.activeItemText,
                          activePresence: theme.colors.activePresence,
                          inactivePresence: theme.colors.inactivePresence,
                          notificationBadgeBackground:
                              theme.colors.notificationBadgeBackground,
                          notificationBadgeText: color,
                          sidebarColor: theme.colors.sidebarColor,
                        ));
                    bloc.sinkTheme(newTheme);
                  }),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TXButtonWidget(
                    title: R.string.reset,
                    mainColor: Theme.of(context).scaffoldBackgroundColor,
                    splashColor: R.color.grayLightColor,
                    textColor: R.color.blackColor,
                    onPressed: () async {
                      bloc.sinkTheme(bloc.teamModel.theme);
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  StreamBuilder<bool>(
                    initialData: false,
                    stream: bloc.saveButtonThemeResult,
                    builder: (context, snapshotSave) {
                      return TXButtonWidget(
                        title: R.string.saveChanges,
                        mainColor: snapshotSave.data!
                            ? R.color.secondaryColor
                            : R.color.grayLightColor,
                        splashColor: snapshotSave.data!
                            ? R.color.secondaryHeaderColor
                            : R.color.grayLightColor,
                        onPressed: () async {
                          if (snapshotSave.data!) {
                            bloc.updateTheme();
                          }
                        },
                      );
                    },
                  )
                ],
              )
            ],
          );
        });
  }

  Widget _getSelectableColor(
      String name, Color? color, ValueChanged<Color> onColorChanged) {
    Color? selectedColor;
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: color ?? Colors.white,
                    onColorChanged: (newColor) {
                      selectedColor = newColor;
                    },
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      NavigationUtils.pop(context);
                    },
                    child: TXTextWidget(
                        color: R.color.darkColor, text: R.string.cancel),
                  ),
                  TextButton(
                    onPressed: () {
                      NavigationUtils.pop(context);
                      if (selectedColor != null) {
                        onColorChanged(selectedColor!);
                      }
                    },
                    child: TXTextWidget(
                        color: R.color.primaryColor, text: R.string.ok),
                  ),
                ],
              );
            });
      },
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    border: Border.all(color: R.color.grayColor, width: 1)),
              ),
              SizedBox(
                width: 10,
              ),
              TXTextWidget(text: name, fontWeight: FontWeight.w600),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getSelectableTheme(String name, String image, bool isSelected) {
    final screenWidth = MediaQuery.of(context).size.width;
    double width = (screenWidth - 55) / 2;
    if(width > 170) width = 160;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (!isSelected) {
              switch (name) {
                case RemoteConstants.bluejeansTheme:
                  bloc.sinkTheme(R.color.bluejeansTheme);
                  break;
                case RemoteConstants.blackboardTheme:
                  bloc.sinkTheme(R.color.blackboardTheme);
                  break;
                case RemoteConstants.lightTheme:
                  bloc.sinkTheme(R.color.lightTheme);
                  break;
                case RemoteConstants.greenbeansTheme:
                  bloc.sinkTheme(R.color.greenbeansTheme);
                  break;
                default:
                  bloc.sinkTheme(R.color.defaultTheme);
                  break;
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: isSelected
                    ? Border.all(color: R.color.secondaryColor, width: 3)
                    : Border.all(color: R.color.grayColor, width: 3)),
            child:
            Image.asset(image, height: 80, width: width, fit: BoxFit.fill),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TXTextWidget(
          text: name,
          fontWeight: FontWeight.w600,
          color: isSelected ? R.color.secondaryHeaderColor : null,
        )
      ],
    );
  }

  Widget _getSecurity(TeamModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getTeamUsageInfo(model.trial ?? true),
        SizedBox(
          height: 10,
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        Container(
            alignment: Alignment.center,
            child: TextButton.icon(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      side: BorderSide(color: R.color.grayColor, width: .5)),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
              ),
              icon: Icon(
                Icons.close,
                size: 20,
                color: R.color.whiteColor,
              ),
              label: TXTextWidget(
                text: R.string.leaveTeam,
                maxLines: 1,
                color: R.color.whiteColor,
                textOverflow: TextOverflow.ellipsis,
              ),
              onPressed: () {
                _showDeactivateAccountConfirmation();
              },
            )),
        SizedBox(
          height: 10,
        ),
        Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: TXInfoWidget(
              type: InfoType.warning,
              info: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TXTextWidget(
                      color: R.color.grayDarkestColor,
                      size: 16,
                      textAlign: TextAlign.justify,
                      text:
                          R.string.leaveTeamWarning),
                ],
              ),
            ))
      ],
    );
  }

  Widget _showSourceSelector(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 80,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: TXMediaSelectorWidget(
              icon: Icon(
                Icons.photo_library,
                color: R.color.grayColor,
              ),
              title: R.string.photoGallery,
              onTap: () {
                _launchMediaView(imageSource: ImageSource.gallery);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: TXMediaSelectorWidget(
              icon: Icon(
                Icons.photo_camera,
                color: R.color.grayColor,
              ),
              title: R.string.takePhoto,
              onTap: () {
                _launchMediaView(imageSource: ImageSource.camera);
              },
            ),
          )
        ],
      ),
    );
  }

  void _launchMediaView(
      {ImageSource? imageSource,
      bool lookForVideo = false,
      bool allFiles = false,
      ValueChanged<int>? onFileLoading}) async {
    try {
      NavigationUtils.pop(context);
      final file = await FileManager.getImageFromSource(
          source: imageSource,
          lookForVideo: lookForVideo,
          allFiles: allFiles,
          onFileLoading: onFileLoading);
      if (file != null && file.existsSync()) {
        bloc.uploadTeamIcon(file);
      }
    } catch (ex) {
      if (ex is PlatformException) {
        if (ex.code == "photo_access_denied" ||
            ex.code == "camera_access_denied") {
          _showDialogPermissions(
              context: context,
              onOkAction: () async {
                openAppSettings();
              });
        }
      }
    }
  }

  void _showDialogPermissions(
      {required BuildContext context, Function? onOkAction}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => TXCupertinoDialogWidget(
        title: R.string.permissionDenied,
        content: R.string.enablePermissions,
        onOK: () {
          Navigator.pop(context, R.string.ok);
          if (onOkAction != null) onOkAction();
        },
        onCancel: () {
          Navigator.pop(context, R.string.cancel);
        },
      ),
    );
  }

  Widget _getTeamUsageInfo(bool teamIsTrial) {
    return StreamBuilder<UsageModel>(
      initialData: null,
      stream: bloc.teamUsageResult,
      builder: (context, snapshot) {
        return snapshot.data == null
            ? Container()
            : TXInfoWidget(
                info: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TXTextWidget(
                      text: R.string.teamDataUsage,
                      fontWeight: FontWeight.bold,
                      size: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TXTextWidget(
                          text: "${R.string.sentMessages}: ",
                          color: R.color.grayDarkestColor,
                          fontWeight: FontWeight.bold,
                          size: 18,
                        ),
                        Expanded(
                            child: TXTextWidget(
                          text: teamIsTrial
                              ? R.string.sentMessagesCount(
                                  snapshot.data!.messages?.count.toString() ??
                                      "")
                              : snapshot.data!.messages?.count.toString() ?? "",
                          color: R.color.grayDarkestColor,
                          size: 18,
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TXTextWidget(
                          text: "${R.string.usedStorage}: ",
                          color: R.color.grayDarkestColor,
                          fontWeight: FontWeight.bold,
                          size: 18,
                        ),
                        Expanded(
                          child: TXTextWidget(
                            text: teamIsTrial
                                ? R.string.usedStorageText(
                                    FileManager.convertBytesToGigabytes(
                                            snapshot.data!.files?.size ?? 0)
                                        .toStringAsFixed(4))
                                : FileManager.convertBytesToGigabytes(
                                        snapshot.data!.files?.size ?? 0)
                                    .toStringAsFixed(4),
                            color: R.color.grayDarkestColor,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
      },
    );
  }

  void _showDeactivateAccountConfirmation() {
    txShowWarningDialogBlur(context,
        title: TXTextWidget(
          fontWeight: FontWeight.bold,
          size: 18,
          color: R.color.grayDarkestColor,
          text: R.string.leaveTeam,
        ),
        content: TXTextWidget(text: R.string.operationConfirmation),
        onAction: (value) {
      if (value) bloc.deactivateUser();
    });
  }
}
