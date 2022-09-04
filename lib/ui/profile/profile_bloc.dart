import 'dart:convert';
import 'dart:io';

import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/data/_shared_prefs.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/api/remote/result.dart';
import 'package:code/data/file_cache_manager.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/app_common_model.dart';
import 'package:code/domain/single_selection_model.dart';
import 'package:code/domain/user/i_user_repository.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rxdart/rxdart.dart';
import 'package:code/utils/extensions.dart';
import 'package:flutter/services.dart' show rootBundle;

class ProfileBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final IUserRepository _iUserRepository;
  final SharedPreferencesManager _prefs;
  final InMemoryData _inMemoryData;

  ProfileBloC(this._iUserRepository, this._prefs, this._inMemoryData);

  InMemoryData get inMemoryData => _inMemoryData;

  BehaviorSubject<int> _pageTabController = new BehaviorSubject();

  Stream<int> get pageTabResult => _pageTabController.stream;

  BehaviorSubject<MemberModel> _memberModelController = new BehaviorSubject();

  Stream<MemberModel> get memberModelResult => _memberModelController.stream;

  BehaviorSubject<MemberModel> _notificationConfigController =
      new BehaviorSubject();

  Stream<MemberModel> get notificationConfigResult =>
      _notificationConfigController.stream;

  BehaviorSubject<int> _passwordStrangeController = new BehaviorSubject();

  Stream<int> get passwordStrangeResult => _passwordStrangeController.stream;

  BehaviorSubject<MeetingOptions> _meetingOptionsController = BehaviorSubject();

  Stream<MeetingOptions> get meetingOptionsResult =>
      _meetingOptionsController.stream;

  BehaviorSubject<PhoneNumber> _phoneController = BehaviorSubject();

  Stream<PhoneNumber> get phoneResult => _phoneController.stream;

  @override
  void dispose() {
    _notificationConfigController.close();
    _passwordStrangeController.close();
    _pageTabController.close();
    _memberModelController.close();
    _meetingOptionsController.close();
    _phoneController.close();
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }

  String currentTeamId = "";
  String currentTeamName = "";
  String memberId = "";
  String newPassword = "";
  List<SingleSelectionModel> countries = [];

  MemberModel? member;

  TextEditingController userNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  //TextEditingController phoneController = TextEditingController();
  TextEditingController chargeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void changePageTab(int tab) async {
    _pageTabController.sinkAddSafe(tab);
  }

  void getProfile({MemberModel? memberModel}) async {
    currentTeamId = await _prefs.getStringValue(_prefs.currentTeamId);
    currentTeamName = await _prefs.getStringValue(_prefs.currentTeamName);
    memberId = await _prefs.getStringValue(_prefs.userId);
    member = memberModel;
    if (member == null) {
      isLoading = true;
      final res = await _iUserRepository.getTeamMember(currentTeamId, memberId);
      if (res is ResultSuccess<MemberModel>) {
        member = res.value;
      } else
        showErrorMessage(res);
    }
    userNameController.text = member?.profile?.name ?? "";
    firstNameController.text = member?.profile?.firstName ?? "";
    lastNameController.text = member?.profile?.lastName ?? "";
    chargeController.text = member?.profile?.position ?? "";
    //phoneController.text = "";
    descriptionController.text = member?.profile?.description ?? "";
    await _getPhone(member?.profile?.phone ?? "");
    await _loadCountries(member!);
    await _loadMeetingOptions(member!);
    isLoading = false;
  }

  TextEditingController meetingDisplayNameController = TextEditingController();

  Future<void> _loadMeetingOptions(MemberModel? currentMember) async {
    final audioMuted = await _prefs.getBoolValue(_prefs.audioMuted);
    final videoMuted = await _prefs.getBoolValue(_prefs.videoMuted);
    final dontShowAgain = await _prefs.getBoolValue(_prefs.dontShowAgain);
    final displayName = await _prefs.getStringValue(_prefs.displayName);
    final name = displayName.isNullOrEmpty()
        ? currentMember?.profile?.name
        : displayName;
    meetingDisplayNameController.text = name ?? '';

    _meetingOptionsController.sinkAddSafe(
      MeetingOptions(
          audioMuted: audioMuted,
          displayName: name ?? '',
          dontShowAgain: dontShowAgain,
          videoMuted: videoMuted),
    );
  }

  void updateMeetingOptions(MeetingOptions options) =>
      _meetingOptionsController.sinkAddSafe(options);

  void saveMeetingOptions() async {
    MeetingOptions? options = _meetingOptionsController.valueOrNull;
    if (options != null) {
      _prefs.setBoolValue(_prefs.videoMuted, options.videoMuted);
      _prefs.setBoolValue(_prefs.audioMuted, options.audioMuted);
      _prefs.setBoolValue(_prefs.dontShowAgain, options.dontShowAgain);
      _prefs.setStringValue(_prefs.displayName, options.displayName);
      Fluttertoast.showToast(msg: R.string.profileUpdatedSuccess);
    }
  }

  Future<void> _loadCountries(MemberModel member) async {
    String data = await rootBundle.loadString(
        member.profile?.language?.trim().toLowerCase() == 'es'
            ? 'lib/_res/assets/paises.json'
            : 'lib/_res/assets/countries.json');
    final Iterable countriesJsonIterable = jsonDecode(data);
    int index = 0;
    final list = countriesJsonIterable
        .map((json) => SingleSelectionModel(
            index: index++,
            displayName: json["printable_name"],
            id: json["iso"],
            isSelected: json["iso"].toLowerCase() ==
                member.profile?.country?.toLowerCase()))
        .toList();
    countries.clear();
    countries.addAll(list);
    setMemberData();
  }

  Future<void> _getPhone(String phoneText) async {
    if (phoneText.trim().isNotEmpty) {
      if (!phoneText.trim().startsWith('+')) phoneText = "+$phoneText";
      try {
        final phone = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneText);
        //phoneController.text = phone.parseNumber();
        _phoneController.sinkAddSafe(phone);
      } catch (ex) {
        _phoneController
            .sinkAddSafe(PhoneNumber(dialCode: "+1", isoCode: "US"));
      }
    }
  }

  void uploadAvatar(File file) async {
    isLoading = true;
    File? croppedFile = await cropImage(file);
    if (croppedFile != null) {
      final res = await _iUserRepository.putTeamMemberUpload(croppedFile);
      if (res is ResultSuccess<bool>) {
        await FileCacheManager.instance.removeFile(member?.photo ?? "");
        final res =
            await _iUserRepository.getTeamMember(currentTeamId, memberId);
        if (res is ResultSuccess<MemberModel>) {
          member?.photo = res.value.photo;
          setMemberData();
        } else
          showErrorMessage(res);
      } else {
        showErrorMessage(res);
      }
    }
    isLoading = false;
  }

  Future<File?> cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper()
        .cropImage(sourcePath: imageFile.path, aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ], uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        minimumAspectRatio: 1.0,
      )
    ]);
    if (croppedFile != null) return File(croppedFile.path);
    return null;
  }

  void updatePassword(String newPassword) async {
    isLoading = true;
    final res = await _iUserRepository.changePassword(newPassword);
    if (res is ResultSuccess<bool>) {
      Fluttertoast.showToast(
          msg: R.string.passwordUpdatedSuccess,
          toastLength: Toast.LENGTH_LONG,
          textColor: R.color.whiteColor,
          backgroundColor: R.color.primaryColor);
    } else
      showErrorMessage(res);
    isLoading = false;
  }

  void updateNotifications() async {
    isLoading = true;
    final res = await _iUserRepository
        .putTeamMemberNotifications(member!.notifications!);
    if (res is ResultSuccess<bool>) {
      Fluttertoast.showToast(
          msg: R.string.notificationUpdatedSuccess,
          toastLength: Toast.LENGTH_LONG,
          textColor: R.color.whiteColor,
          backgroundColor: R.color.primaryColor);
    } else
      showErrorMessage(res);
    isLoading = false;
  }

  Future<void> updateProfile() async {
    if (member?.profile != null &&
        member!.profile!.name.toLowerCase().trim() != RemoteConstants.noysiUsername && member!.profile!.name.toLowerCase().trim() != currentTeamName) {
      isLoading = true;
      final res = await _iUserRepository.updateProfile(member!.profile!);
      if (res is ResultSuccess<bool>) {
        _prefs.setStringValue(_prefs.language, member!.profile!.language ?? "");
        Fluttertoast.showToast(
            msg: R.string.profileUpdatedSuccess,
            toastLength: Toast.LENGTH_LONG,
            textColor: R.color.whiteColor,
            backgroundColor: R.color.primaryColor);
      } else
        showErrorMessageFromString(R.string.userInUse);
      isLoading = false;
    } else {
      showErrorMessageFromString(R.string.userInUse);
    }
  }

  void setMemberData() => _memberModelController.sinkAddSafe(member!);

  void changeLang(String code) {
    final res = languageCodeController.valueOrNull;
    String oldLang = '';
    if (res != null) {
      oldLang = res.languageCode;
      res.languageCode = code;
    }
    languageCodeController.sinkAddSafe(res ??
        AppSettingsModel(
          isDarkMode: false,
          languageCode: code,
        ));
    localeChangedController.sinkAddSafe(true);
    if (oldLang == 'es' || code == 'es') _loadCountries(member!);
  }

  void deactivateUserTeam({bool allTeams = false}) async {
    allTeams
        ? _iUserRepository.deactivateUserTeams(memberId)
        : _iUserRepository.deactivateUserTeam(currentTeamId, memberId);
  }

  Future<bool> deleteMyAccount() async {
    isLoading = true;
    final res = await _iUserRepository.deleteAccount(memberId);
    isLoading = false;
    if(res is ResultSuccess<bool> && res.value) {
      return true;
    }
    showErrorMessageFromString(R.string.errorFetchingData);
    return false;
  }
}

class MeetingOptions {
  String displayName;
  bool audioMuted, videoMuted, dontShowAgain;

  MeetingOptions(
      {this.displayName = "",
      this.videoMuted = false,
      this.audioMuted = false,
      this.dontShowAgain = false});
}
