import 'package:code/_res/R.dart';
import 'package:code/_res/values/config.dart';
import 'package:code/domain/app_common_model.dart';
import 'package:code/domain/single_selection_model.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_alert_dialog.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_bottomsheet_selector_widget.dart';
import 'package:code/ui/_tx_widget/tx_button_widget.dart';
import 'package:code/ui/_tx_widget/tx_checkbox_widget.dart';
import 'package:code/ui/_tx_widget/tx_cupertino_dialog_widget.dart';
import 'package:code/ui/_tx_widget/tx_divider_widget.dart';
import 'package:code/ui/_tx_widget/tx_gesture_hide_key_board.dart';
import 'package:code/ui/_tx_widget/tx_info_widget.dart';
import 'package:code/ui/_tx_widget/tx_loading_widget.dart';
import 'package:code/ui/_tx_widget/tx_main_app_bar_widget.dart';
import 'package:code/ui/_tx_widget/tx_media_selector_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textfield_widget.dart';
import 'package:code/ui/_tx_widget/tx_user_role_widget.dart';
import 'package:code/ui/profile/profile_bloc.dart';
import 'package:code/ui/profile/tx_profile_selector_widget.dart';
import 'package:code/utils/common_utils.dart';
import 'package:code/utils/file_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilePage extends StatefulWidget {
  final MemberModel? memberModel;

  const ProfilePage({super .key, this.memberModel});

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends StateWithBloC<ProfilePage, ProfileBloC>
    with SingleTickerProviderStateMixin {
  PageController pageController = PageController(initialPage: 0);

  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  ScrollController profileScrollController = ScrollController();
  final _keyFormProfile = new GlobalKey<FormState>();
  final _keyFormPassword = new GlobalKey<FormState>();
  final _keyFormMeeting = new GlobalKey<FormState>();
  ScrollController _navBarController = new ScrollController();
  late AnimationController _animationController;
  bool navIsAtEnd = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1, // initially visible
    );
    _navBarController.addListener(_navBarListener);
    bloc.getProfile(memberModel: widget.memberModel);
  }

  void _navBarListener() {
    if (_navBarController.position.pixels >
        _navBarController.position.maxScrollExtent - 10) {
      if (!navIsAtEnd) {
        navIsAtEnd = true;
        _animationController.reverse();
      }
    } else if (navIsAtEnd) {
      navIsAtEnd = false;
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _navBarController.removeListener(_navBarListener);
    _animationController.dispose();
    _navBarController.dispose();
    profileScrollController.dispose();
    super.dispose();
  }

  Widget _getTab(int tabNumber, bool isActive, String title) {
    return InkWell(
      onTap: () {
        if (!isActive) bloc.changePageTab(tabNumber);
        pageController.jumpToPage(tabNumber - 1);
      },
      child: Container(
        height: double.infinity,
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
    return StreamBuilder(
      initialData: AppSettingsModel(
          languageCode: CommonUtils.getDefLang(), isDarkMode: false),
      stream: languageCodeResult,
      builder: (context, snapshotLang) {
        return Stack(
          children: <Widget>[
            TXGestureHideKeyBoard(
              child: TXMainAppBarWidget(
                title: R.string.myProfile,
                body: Container(
                  child: Column(
                    children: <Widget>[
                      StreamBuilder<int>(
                          stream: bloc.pageTabResult,
                          initialData: 1,
                          builder: (context, snapshotTab) {
                            return Container(
                              height: 50,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    controller: _navBarController,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          _getTab(1, snapshotTab.data == 1,
                                              R.string.myProfile),
                                          _getTab(2, snapshotTab.data == 2,
                                              R.string.notifications),
                                          _getTab(3, snapshotTab.data == 3,
                                              R.string.security),
                                          _getTab(4, snapshotTab.data == 4,
                                              R.string.meeting),
                                        ],
                                      ),
                                    ),
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    //padding: EdgeInsets.only(top: 4),
                                    child: ScaleTransition(
                                      scale: _animationController,
                                      child: Container(
                                        child: Icon(
                                          Icons.keyboard_arrow_right_sharp,
                                          color: R.color.grayColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                      Expanded(
                        child: StreamBuilder<MemberModel>(
                          stream: bloc.memberModelResult,
                          initialData: MemberModel(),
                          builder: (ctx, snapshotMember) {
                            return StreamBuilder<MeetingOptions>(
                              initialData: MeetingOptions(),
                              stream: bloc.meetingOptionsResult,
                              builder: (context, snapshotMeeting) {
                                return PageView.builder(
                                  physics: BouncingScrollPhysics(),
                                  controller: pageController,
                                  itemBuilder: (ctx, index) {
                                    return index == 3
                                        ? _getMeeting(snapshotMeeting.data!)
                                        : index == 2
                                            ? _getSecurity()
                                            : index == 1
                                                ? _getNotifications()
                                                : _getMyProfile();
                                  },
                                  onPageChanged: (page) {
                                    bloc.changePageTab(page + 1);
                                  },
                                  itemCount: 4,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TXLoadingWidget(
              loadingStream: bloc.isLoadingStream,
            )
          ],
        );
      },
    );
  }

  Widget _getMyProfile() {
    return bloc.member == null
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: profileScrollController,
              padding: EdgeInsets.only(bottom: 30),
              child: Form(
                key: _keyFormProfile,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border:
                              Border.all(color: R.color.grayColor, width: .5)),
                      child: bloc.member?.photo != null
                          ? TXNetworkImage(
                              width: 100,
                              height: 100,
                              forceLoad: true,
                              imageUrl: CommonUtils.getMemberPhoto(bloc.member),
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
                          border:
                              Border.all(color: R.color.grayColor, width: .5)),
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
                      height: 15,
                    ),
                    TXTextWidget(
                      text: R.string.photoSizeRestrictions,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    bloc.member?.role != null
                        ? TXUserRoleWidget(
                            memberModel: bloc.member!,
                          )
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: TXTextWidget(
                        text: R.string.yourUserName,
                        color: R.color.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    bloc.inMemoryData.currentTeam?.updateUsernameBlocked == true
                        ? Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            color: R.color.grayLightestColor,
                            child: TXTextWidget(
                              text: bloc.userNameController.text,
                              color: R.color.blackColor,
                            ),
                          )
                        : TXTextFieldWidget(
                            controller: bloc.userNameController,
                            validator: bloc.alphanumericRoomNameWithoutSpaces(),
                            onChanged: (text) {
                              bloc.member?.profile?.name = text;
                            },
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: TXTextWidget(
                        text: R.string.email,
                        color: R.color.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      color: R.color.grayLightestColor,
                      child: TXTextWidget(
                        text: bloc.member?.profile?.email ?? "",
                        color: R.color.blackColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TXTextWidget(
                      text: R.string.profileEmailUsesWarning,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: TXTextWidget(
                        text: R.string.name,
                        color: R.color.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    TXTextFieldWidget(
                      controller: bloc.firstNameController,
                      onChanged: (text) {
                        bloc.member?.profile?.firstName = text;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: TXTextWidget(
                        text: R.string.lastName,
                        color: R.color.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    TXTextFieldWidget(
                      controller: bloc.lastNameController,
                      onChanged: (text) {
                        bloc.member?.profile?.lastName = text;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: TXTextWidget(
                        text: R.string.charge,
                        color: R.color.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    TXTextFieldWidget(
                      controller: bloc.chargeController,
                      onChanged: (text) {
                        bloc.member?.profile?.position = text;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: TXTextWidget(
                        text: R.string.phoneNumber,
                        color: R.color.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    // TXTextFieldWidget(
                    //   controller: bloc.phoneController,
                    //   textInputType: TextInputType.phone,
                    //   onChanged: (text) {
                    //     bloc.member?.profile?.phone = text;
                    //   },
                    // ),
                    StreamBuilder<PhoneNumber>(
                      initialData: PhoneNumber(dialCode: "+1", isoCode: "US"),
                      stream: bloc.phoneResult,
                      builder: (context, phoneSnapshot) {
                        return InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber value) {
                            bloc.member?.profile?.phone = value.phoneNumber;
                          },
                          initialValue: phoneSnapshot.data,
                          //textFieldController: bloc.phoneController,
                          hintText: null,
                          keyboardType: TextInputType.number,
                          ignoreBlank: true,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          locale: AppConfig.localeCode,
                          scrollPadding: EdgeInsets.only(bottom: 30),
                          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: R.color.grayDarkColor),
                          inputDecoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                              isCollapsed: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: R.color.grayColor,
                                      width: .8),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(4))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: R.color.grayColor,
                                      width: .8),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(4))),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.redAccent,
                                      width: .8),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(4))),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: R.color.grayColor,
                                      width: .8),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(4)))
                          ),
                          errorMessage: R.string.invalidPhoneNumber,
                          formatInput: true,
                          selectorTextStyle: TextStyle(color: R.color.grayDarkColor, fontSize: 18, fontWeight: FontWeight.normal),
                          autoFocusSearch: false,
                          searchBoxDecoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                              hintText: R.string.searchByCountryName,
                              hintStyle: TextStyle(color: R.color.grayColor),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: R.color.grayColor,
                                      width: .8),),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: R.color.grayColor,
                                      width: .8)),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.redAccent,
                                      width: .8)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: R.color.grayColor,
                                      width: .8))
                          ),
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            leadingPadding: 7,
                            trailingSpace: false,
                            setSelectorButtonAsPrefixIcon: false,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: TXTextWidget(
                        text: R.string.aboutMe,
                        color: R.color.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    TXTextFieldWidget(
                      minLines: 8,
                      maxLines: 8,
                      controller: bloc.descriptionController,
                      onChanged: (text) {
                        bloc.member?.profile?.description = text;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: TXTextWidget(
                        text: R.string.language,
                        color: R.color.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    TXBottomSheetSelectorWidget(
                      list: SingleSelectionModel.getLanguagesNames(
                          bloc.member?.profile?.language),
                      onItemSelected: (value) async {
                        bloc.member?.profile?.language = value.id;
                        bloc.setMemberData();
                        if (AppConfig.localeCode != value.id) {
                          Future.delayed(Duration(milliseconds: 200), () {
                            bloc.changeLang(value.id);
                          });
                        }
                      },
                      title: R.string.invitationLanguageTitle,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: TXTextWidget(
                        text: R.string.country,
                        color: R.color.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    bloc.countries.isNotEmpty
                        ? TXBottomSheetSelectorWidget(
                            list: bloc.countries,
                            onItemSelected: (value) {
                              bloc.member?.profile?.country = value.id;
                              bloc.countries.forEach((element) =>
                                  element.isSelected = value.id == element.id);
                              bloc.setMemberData();
                            },
                            title: R.string.country,
                          )
                        : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: TXButtonWidget(
                        title: R.string.updateProfileInfo,
                        onPressed: () async {
                          if (_keyFormProfile.currentState!.validate()) {
                            await bloc.updateProfile();
                          } else {
                            profileScrollController.jumpTo(0);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 2,
                      color: R.color.grayLightColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: TextButton.icon(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  side: BorderSide(
                                      color: R.color.grayColor, width: .5)),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.redAccent),
                          ),
                          icon: Icon(
                            Icons.close,
                            size: 20,
                            color: R.color.whiteColor,
                          ),
                          label: TXTextWidget(
                            text: R.string.deactivateMyUserInThisTeam,
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
                                  text: R.string
                                      .deactivateMyUserInThisTeamWarning),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          );
  }

  Widget _getNotifications() {
    return bloc.member == null
        ? Container()
        : Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  TXTextWidget(
                    text: R.string.sounds.toUpperCase(),
                    color: R.color.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                  TXDividerWidget(),
                  TXProfileSelectorWidget(
                    isSelected: bloc.member?.notifications?.sounds ==
                        profileNotificationSound.all.toString().split('.').last,
                    title: R.string.allActive,
                    onTap: () {
                      bloc.member?.notifications?.sounds =
                          profileNotificationSound.all
                              .toString()
                              .split('.')
                              .last;
                      bloc.setMemberData();
                    },
                  ),
                  TXDividerWidget(),
                  TXProfileSelectorWidget(
                    isSelected: bloc.member?.notifications?.sounds ==
                        profileNotificationSound.mentions
                            .toString()
                            .split('.')
                            .last,
                    title: R.string.messages1x1AndMentions,
                    onTap: () {
                      bloc.member?.notifications?.sounds =
                          profileNotificationSound.mentions
                              .toString()
                              .split('.')
                              .last;
                      bloc.setMemberData();
                    },
                  ),
                  TXDividerWidget(),
                  TXProfileSelectorWidget(
                    isSelected: bloc.member?.notifications?.sounds ==
                        profileNotificationSound.never
                            .toString()
                            .split('.')
                            .last,
                    title: R.string.never,
                    onTap: () {
                      bloc.member?.notifications?.sounds =
                          profileNotificationSound.never
                              .toString()
                              .split('.')
                              .last;
                      bloc.setMemberData();
                    },
                  ),
                  TXDividerWidget(),
                  SizedBox(
                    height: 30,
                  ),
                  TXTextWidget(
                    text: R.string.newsLetters.toUpperCase(),
                    color: R.color.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                  TXDividerWidget(),
                  TXProfileSelectorWidget(
                    isSelected: bloc.member?.notifications?.newsLetters == true,
                    title: R.string.acceptNews,
                    onTap: () {
                      bloc.member?.notifications?.newsLetters = true;
                      bloc.setMemberData();
                    },
                  ),
                  TXDividerWidget(),
                  TXProfileSelectorWidget(
                    isSelected:
                        !(bloc.member?.notifications?.newsLetters == true),
                    title: R.string.notReceiveNews,
                    onTap: () {
                      bloc.member?.notifications?.newsLetters = false;
                      bloc.setMemberData();
                    },
                  ),
                  TXDividerWidget(),
                  SizedBox(
                    height: 30,
                  ),
                  TXTextWidget(
                    text: R.string.pushMobileNotifications.toUpperCase(),
                    color: R.color.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                  TXDividerWidget(),
                  TXProfileSelectorWidget(
                    isSelected: bloc.member?.notifications?.push == true,
                    title: R.string.all,
                    onTap: () {
                      bloc.member?.notifications?.push = true;
                      bloc.setMemberData();
                    },
                  ),
                  TXDividerWidget(),
                  TXProfileSelectorWidget(
                    isSelected: !(bloc.member?.notifications?.push == true),
                    title: R.string.disabled,
                    onTap: () {
                      bloc.member?.notifications?.push = false;
                      bloc.setMemberData();
                    },
                  ),
                  TXDividerWidget(),
                  SizedBox(
                    height: 30,
                  ),
                  // TXTextWidget(
                  //   text: R.string.emailNotification.toUpperCase(),
                  //   color: R.color.blackColor,
                  //   fontWeight: FontWeight.bold,
                  // ),
                  // TXDividerWidget(),
                  // TXProfileSelectorWidget(
                  //   isSelected: bloc.member?.notifications?.emails == 'hourly',
                  //   title: R.string.maxEveryHour,
                  //   onTap: () {
                  //     bloc.member?.notifications?.emails = 'hourly';
                  //     bloc.setMemberData();
                  //   },
                  // ),
                  // TXDividerWidget(),
                  // TXProfileSelectorWidget(
                  //   isSelected:
                  //       bloc.member?.notifications?.emails == 'each-12-hours',
                  //   title: R.string.maxHalfDay,
                  //   onTap: () {
                  //     bloc.member?.notifications?.emails = 'each-12-hours';
                  //     bloc.setMemberData();
                  //   },
                  // ),
                  // TXDividerWidget(),
                  // TXProfileSelectorWidget(
                  //   isSelected: bloc.member?.notifications?.emails == 'never',
                  //   title: R.string.disabled,
                  //   onTap: () {
                  //     bloc.member?.notifications?.emails = 'never';
                  //     bloc.setMemberData();
                  //   },
                  // ),
                  // TXDividerWidget(),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: TXButtonWidget(
                      title: R.string.saveNotificationChanges,
                      onPressed: () {
                        bloc.updateNotifications();
                      },
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Widget _getSecurity() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 30),
        child: Form(
          key: _keyFormPassword,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              TXTextWidget(
                text: R.string.changeYourPassword,
                color: R.color.blackColor,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 15,
              ),
              TXTextWidget(
                text: R.string.passwordRequirements,
              ),
              SizedBox(
                height: 15,
              ),
              TXTextWidget(
                text: R.string.newPassword,
                color: R.color.blackColor,
                fontWeight: FontWeight.bold,
              ),
              TXTextFieldWidget(
                controller: passwordController,
                validator: bloc.password(),
                obscureText: true,
                onChanged: (value) {
                  bloc.newPassword = value;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TXTextWidget(
                text: R.string.repeatNewPassword,
                color: R.color.blackColor,
                fontWeight: FontWeight.bold,
              ),
              TXTextFieldWidget(
                controller: repeatPasswordController,
                validator: (value) {
                  if (passwordController.text == value) return null;
                  return R.string.passwordMustMatch;
                },
                obscureText: true,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: TXInfoWidget(
                    type: InfoType.info,
                    info: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TXTextWidget(
                            color: R.color.grayDarkestColor,
                            size: 16,
                            textAlign: TextAlign.justify,
                            text: R.string.changeYourPasswordAdvice),
                      ],
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: TXButtonWidget(
                  title: R.string.updatePassword,
                  onPressed: () {
                    if (_keyFormPassword.currentState!.validate()) {
                      bloc.updatePassword(passwordController.text);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 2,
                color: R.color.grayLightColor,
              ),
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
                            side: BorderSide(
                                color: R.color.grayColor, width: .5)),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent),
                    ),
                    icon: Icon(
                      Icons.close,
                      size: 20,
                      color: R.color.whiteColor,
                    ),
                    label: Container(
                      child: TXTextWidget(
                        text: R.string.deactivateMyAccount,
                        maxLines: 1,
                        color: R.color.whiteColor,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    onPressed: () {
                      _showDeactivateAccountConfirmation(allTeams: true);
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
                            text: R.string.deactivateMyAccountWarning),
                      ],
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 2,
                color: R.color.grayLightColor,
              ),
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
                            side: BorderSide(
                                color: R.color.grayColor, width: .5)),
                      ),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.redAccent),
                    ),
                    icon: Icon(
                      Icons.delete_forever_outlined,
                      size: 20,
                      color: R.color.whiteColor,
                    ),
                    label: Container(
                      child: TXTextWidget(
                        text: R.string.deleteMyAccount,
                        maxLines: 1,
                        color: R.color.whiteColor,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    onPressed: () {
                      _showDeleteAccountConfirmation();
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
                            text: R.string.deleteMyAccountWarning),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMeeting(MeetingOptions options) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 30),
        child: Form(
          key: _keyFormMeeting,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TXTextWidget(
                      text: R.string.videoEnabled,
                      color: R.color.grayDarkestColor,
                    ),
                  ),
                  Switch(
                      value: !options.videoMuted,
                      onChanged: (value) {
                        bloc.updateMeetingOptions(options..videoMuted = !value);
                      }),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TXTextWidget(
                      text: R.string.audioEnabled,
                      color: R.color.grayDarkestColor,
                    ),
                  ),
                  Switch(
                      value: !options.audioMuted,
                      onChanged: (value) {
                        bloc.updateMeetingOptions(options..audioMuted = !value);
                      }),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: TXTextFieldWidget(
                  controller: bloc.meetingDisplayNameController,
                  label: R.string.name,
                  validator: bloc.required(),
                  onChanged: (text) {
                    bloc.updateMeetingOptions(options..displayName = text);
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: TXCheckBoxWidget(
                  leading: true,
                  value: !options.dontShowAgain,
                  onChange: (value) {
                    bloc.updateMeetingOptions(options..dontShowAgain = !value);
                  },
                  text: R.string.showDialogEveryTime,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: TXButtonWidget(
                  title: R.string.savePreferences,
                  onPressed: () {
                    if (_keyFormMeeting.currentState!.validate()) {
                      bloc.saveMeetingOptions();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
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
        bloc.uploadAvatar(file);
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

  void _showDeleteAccountConfirmation() {
    txShowWarningDialogBlur(context,
        title: TXTextWidget(
          fontWeight: FontWeight.bold,
          size: 18,
          color: R.color.grayDarkestColor,
          text: R.string.deleteMyAccount
        ),
        content: TXTextWidget(text: R.string.operationConfirmation),
        onAction: (value) {
          if (value) {
            bloc.deleteMyAccount().then((value) {
              if(value) {

              }
            });
          }
        });
  }

  void _showDeactivateAccountConfirmation({bool allTeams = false}) {
    txShowWarningDialogBlur(context,
        title: TXTextWidget(
          fontWeight: FontWeight.bold,
          size: 18,
          color: R.color.grayDarkestColor,
          text: allTeams
              ? R.string.deactivateMyAccount
              : R.string.deactivateMyUserInThisTeam,
        ),
        content: TXTextWidget(text: R.string.operationConfirmation),
        onAction: (value) {
      if (value) bloc.deactivateUserTeam(allTeams: allTeams);
    });
  }
}
