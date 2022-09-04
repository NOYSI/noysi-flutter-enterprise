import 'dart:io';

import 'package:code/data/api/remote/result.dart';
import 'package:code/domain/team/i_team_repository.dart';
import 'package:code/domain/user/i_user_repository.dart';
import 'package:code/ui/_base/bloc_base.dart';
import 'package:code/ui/_base/bloc_error_handler.dart';
import 'package:code/ui/_base/bloc_form_validator.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/_base/bloc_loading.dart';
import 'package:code/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:rxdart/subjects.dart';
import '../../_res/R.dart';
import '../../data/_shared_prefs.dart';
import '../../data/api/remote/remote_constants.dart';
import '../../data/file_cache_manager.dart';
import '../../domain/team/team_model.dart';
import '../../domain/usage/usage_model.dart';
import '../../rtc/rtc_model.dart';

class EditTeamBloC extends BaseBloC
    with LoadingBloC, ErrorHandlerBloC, FormValidatorBloC {
  final ITeamRepository _iTeamRepository;
  final IUserRepository _iUserRepository;
  final SharedPreferencesManager _prefs;

  EditTeamBloC(this._iTeamRepository, this._iUserRepository, this._prefs);

  @override
  void dispose() {
    disposeErrorHandlerBloC();
    disposeLoadingBloC();
    _teamController.close();
    _pageTabController.close();
    _teamUsageController.close();
    _saveButtonSettingsController.close();
    _saveButtonThemeController.close();
    teamEditThemeController.close();
  }

  final BehaviorSubject<int> _pageTabController = BehaviorSubject.seeded(0);
  Stream<int> get pageTabResult => _pageTabController.stream;

  final BehaviorSubject<TeamModel> _teamController = BehaviorSubject();
  Stream<TeamModel> get teamResult => _teamController.stream;

  final BehaviorSubject<UsageModel> _teamUsageController = BehaviorSubject();
  Stream<UsageModel> get teamUsageResult => _teamUsageController.stream;

  final BehaviorSubject<bool> _saveButtonSettingsController =
      BehaviorSubject.seeded(false);
  Stream<bool> get saveButtonSettingsResult =>
      _saveButtonSettingsController.stream;

  final BehaviorSubject<bool> _saveButtonThemeController =
      BehaviorSubject.seeded(false);
  Stream<bool> get saveButtonThemeResult => _saveButtonThemeController.stream;

  BehaviorSubject<TeamTheme> teamEditThemeController = BehaviorSubject();

  late TeamModel teamModel;

  late bool adminsCanDelete;
  late bool allMentionProtected;
  late bool channelMentionProtected;
  late bool taskUpdateProtected;
  late bool updateUsernameBlocked;
  late bool onlyAdminInvitesAllowed;
  late bool alwaysPush;
  late bool showEmails;
  late bool showPhoneNumbers;

  TextEditingController teamNameController = TextEditingController(text: "");

  void init(TeamModel? teamModel) async {
    final tid = await _prefs.getStringValue(_prefs.currentTeamId);
    _loadTeamUsageData(tid);
    if (teamModel != null) {
      this.teamModel = teamModel;
    } else {
      isLoading = true;
      final res = await _iTeamRepository.getTeam(tid);
      if (res is ResultSuccess<TeamModel>) {
        teamModel = res.value;
      }
      isLoading = false;
    }
    teamNameController.text = this.teamModel.title ?? "";
    adminsCanDelete = this.teamModel.adminsCanDelete ?? false;
    allMentionProtected = this.teamModel.allMentionProtected ?? false;
    channelMentionProtected = this.teamModel.channelMentionProtected ?? false;
    taskUpdateProtected = this.teamModel.taskUpdateProtected ?? false;
    updateUsernameBlocked = this.teamModel.updateUsernameBlocked ?? false;
    onlyAdminInvitesAllowed = this.teamModel.onlyAdminInvitesAllowed ?? false;
    alwaysPush = this.teamModel.alwaysPush ?? false;
    showEmails = this.teamModel.showEmails;
    showPhoneNumbers = this.teamModel.showPhoneNumbers;
    _teamController.sinkAddSafe(this.teamModel);
    sinkTheme(this.teamModel.theme);
  }

  void sinkTheme(TeamTheme theme) {
    final originalTheme = theme.themeName == RemoteConstants.defaultTheme
        ? R.color.defaultTheme
        : theme.themeName == RemoteConstants.bluejeansTheme
            ? R.color.bluejeansTheme
            : theme.themeName == RemoteConstants.blackboardTheme
                ? R.color.blackboardTheme
                : theme.themeName == RemoteConstants.lightTheme
                    ? R.color.lightTheme
                    : R.color.greenbeansTheme;

    final sidebarColor =
        originalTheme.colors.sidebarColor == theme.colors.sidebarColor
            ? null
            : theme.colors.sidebarColor;
    final activeItemBackgroundColor =
        originalTheme.colors.activeItemBackground ==
                theme.colors.activeItemBackground
            ? null
            : theme.colors.activeItemBackground;
    final activeItemTextColor =
        originalTheme.colors.activeItemText == theme.colors.activeItemText
            ? null
            : theme.colors.activeItemText;
    final textColor = originalTheme.colors.textColor == theme.colors.textColor
        ? null
        : theme.colors.textColor;
    final activePresenceColor =
        originalTheme.colors.activePresence == theme.colors.activePresence
            ? null
            : theme.colors.activePresence;
    final inactivePresence =
        originalTheme.colors.inactivePresence == theme.colors.inactivePresence
            ? null
            : theme.colors.inactivePresence;
    final badgeBackgroundColor =
        originalTheme.colors.notificationBadgeBackground ==
                theme.colors.notificationBadgeBackground
            ? null
            : theme.colors.notificationBadgeBackground;
    final badgeTextColor = originalTheme.colors.notificationBadgeText ==
            theme.colors.notificationBadgeText
        ? null
        : theme.colors.notificationBadgeText;

    teamEditThemeController.sinkAddSafe(TeamTheme(
        theme.themeName,
        TeamColors(
            sidebarColor: sidebarColor,
            notificationBadgeText: badgeTextColor,
            notificationBadgeBackground: badgeBackgroundColor,
            inactivePresence: inactivePresence,
            activePresence: activePresenceColor,
            activeItemText: activeItemTextColor,
            activeItemBackground: activeItemBackgroundColor,
            textColor: textColor)));
    _checkSaveButtonTheme();
  }

  void doOnThemeUpdated(RTCTeamThemeUpdated model) {
    if (model.tid == teamModel.id) {
      teamModel.theme = model.theme;
      _teamController.sinkAddSafe(teamModel);
      sinkTheme(teamModel.theme);
      _checkSaveButtonTheme();
    }
  }

  void doOnTeamPhotoUpdated(RTCTeamPhotoUpdated model) async {
    if (model.tid == teamModel.id) {
      if (teamModel.photo?.isNotEmpty == true) {
        await FileCacheManager.instance.removeFile(teamModel.photo!);
      }
      teamModel.photo = model.photo;
      checkSaveButtonSettings();
    }
  }

  void doOnTeamUpdated(RTCTeamUpdated model) {
    if (model.tid == teamModel.id) {
      if (model.title?.isNotEmpty == true) {
        teamModel.title = model.title;
        teamNameController.text = model.title!;
      }
      if (model.name?.isNotEmpty == true) teamModel.name = model.name!;
      teamModel.adminsCanDelete = model.adminsCanDelete;
      teamModel.allMentionProtected = model.allMentionProtected;
      teamModel.channelMentionProtected = model.channelMentionProtected;
      teamModel.taskUpdateProtected = model.taskUpdateProtected;
      teamModel.updateUsernameBlocked = model.updateUsernameBlocked;
      teamModel.onlyAdminInvitesAllowed = model.onlyAdminInvitesAllowed;
      teamModel.alwaysPush = model.alwaysPush;
      teamModel.showPhoneNumbers = model.showPhoneNumbers;
      teamModel.showEmails = model.showEmails;

      adminsCanDelete = teamModel.adminsCanDelete ?? false;
      allMentionProtected = teamModel.allMentionProtected ?? false;
      channelMentionProtected = teamModel.channelMentionProtected ?? false;
      taskUpdateProtected = teamModel.taskUpdateProtected ?? false;
      updateUsernameBlocked = teamModel.updateUsernameBlocked ?? false;
      onlyAdminInvitesAllowed = teamModel.onlyAdminInvitesAllowed ?? false;
      alwaysPush = teamModel.alwaysPush ?? false;
      showEmails = teamModel.showEmails;
      showPhoneNumbers = teamModel.showPhoneNumbers;

      checkSaveButtonSettings();
    }
  }

  Future<File?> _cropImage(File imageFile) async {
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

  void updateTheme() async {
    isLoading = true;
    await _iTeamRepository.updateTeamTheme(teamModel.id, teamEditThemeController.value);
    isLoading = false;
  }

  void uploadTeamIcon(File file) async {
    isLoading = true;
    File? croppedFile = await _cropImage(file);
    if (croppedFile != null) {
      await _iTeamRepository.updateAvatar(teamModel.id, croppedFile);
    }
    isLoading = false;
  }

  Future<void> _updateTeam() async {
    await _iTeamRepository.updateTeam(teamModel,
        newTitle: teamNameController.text.trim() != teamModel.title?.trim()
            ? teamNameController.text.trim()
            : "");
  }

  void checkTeamNameAndUpdate() async {
    isLoading = true;
    if (teamNameController.text.trim() != teamModel.title?.trim()) {
      final res = await _iTeamRepository
          .checkTeamNameInUse(Uri.encodeFull(teamNameController.text.trim()));
      if ((res is ResultSuccess<bool> && res.value) ||
          (res is ResultError &&
              (res as ResultError).code == RemoteConstants.code_not_found)) {
        await _updateTeam();
      } else if (res is ResultError &&
          (res as ResultError).code == RemoteConstants.code_conflict) {
        showErrorMessageFromString(R.string.thisNameAlreadyExist);
      } else {
        showErrorMessage(res);
      }
    } else {
      await _updateTeam();
    }
    isLoading = false;
  }

  void _checkSaveButtonTheme() {
    final currentTheme = teamEditThemeController.value;
    if (currentTheme.themeName != teamModel.theme.themeName ||
        (currentTheme.colors.activeItemBackground ?? teamModel.theme.colors.activeItemBackground) !=
            teamModel.theme.colors.activeItemBackground ||
        (currentTheme.colors.activeItemText ?? teamModel.theme.colors.activeItemText) !=
            teamModel.theme.colors.activeItemText ||
        (currentTheme.colors.activePresence ?? teamModel.theme.colors.activePresence) !=
            teamModel.theme.colors.activePresence ||
        (currentTheme.colors.inactivePresence ?? teamModel.theme.colors.inactivePresence) !=
            teamModel.theme.colors.inactivePresence ||
        (currentTheme.colors.notificationBadgeBackground ?? teamModel.theme.colors.notificationBadgeBackground) !=
            teamModel.theme.colors.notificationBadgeBackground ||
        (currentTheme.colors.notificationBadgeText ?? teamModel.theme.colors.notificationBadgeText) !=
            teamModel.theme.colors.notificationBadgeText ||
        (currentTheme.colors.sidebarColor ?? teamModel.theme.colors.sidebarColor) !=
            teamModel.theme.colors.sidebarColor ||
        (currentTheme.colors.textColor ?? teamModel.theme.colors.textColor) != teamModel.theme.colors.textColor) {
      _saveButtonThemeController.sinkAddSafe(true);
    } else {
      _saveButtonThemeController.sinkAddSafe(false);
    }
  }

  void checkSaveButtonSettings() {
    if (teamNameController.text.trim() != teamModel.title?.trim() ||
        teamModel.alwaysPush != alwaysPush ||
        teamModel.showPhoneNumbers != showPhoneNumbers ||
        teamModel.showEmails != showEmails ||
        teamModel.onlyAdminInvitesAllowed != onlyAdminInvitesAllowed ||
        teamModel.updateUsernameBlocked != updateUsernameBlocked ||
        teamModel.taskUpdateProtected != taskUpdateProtected ||
        teamModel.channelMentionProtected != channelMentionProtected ||
        teamModel.allMentionProtected != allMentionProtected ||
        teamModel.adminsCanDelete != adminsCanDelete) {
      _saveButtonSettingsController.sinkAddSafe(true);
    } else {
      _saveButtonSettingsController.sinkAddSafe(false);
    }
    _teamController.sinkAddSafe(teamModel);
  }

  void changePageTab(int index) {
    _pageTabController.sinkAddSafe(index);
  }

  void _loadTeamUsageData(String tid) async {
    final res = await _iTeamRepository.teamUsage(tid);
    if (res is ResultSuccess<UsageModel>) {
      _teamUsageController.sinkAddSafe(res.value);
    }
  }

  void deactivateUser() async {
    _iUserRepository.deactivateUserTeam(
        teamModel.id, await _prefs.getStringValue(_prefs.userId));
  }
}
