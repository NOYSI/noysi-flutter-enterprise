import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/remote_constants.dart';

import 'activity/activity_model.dart';

class SingleSelectionModel {
  int index;
  String id;
  String displayName;
  bool isSelected;

  SingleSelectionModel(
      {this.index = 0, this.id = '', this.displayName = '', this.isSelected = false});

  static List<SingleSelectionModel> getLanguagesNames(String? idSelected) {
    if (idSelected == null) idSelected = RemoteConstants.defLang;
    List<SingleSelectionModel> list = [
      SingleSelectionModel(
          index: 0,
          id: "es",
          displayName: "Español",
          isSelected: idSelected == "es"),
      SingleSelectionModel(
          index: 1,
          id: "en",
          displayName: "English",
          isSelected: idSelected == "en"),
      SingleSelectionModel(
          index: 2,
          id: "de",
          displayName: "Deutsch",
          isSelected: idSelected == "de"),
      SingleSelectionModel(
          index: 3,
          id: "fr",
          displayName: "Français",
          isSelected: idSelected == "fr"),
      SingleSelectionModel(
          index: 4,
          id: "pt",
          displayName: "Português",
          isSelected: idSelected == "pt"),
      SingleSelectionModel(
          index: 5,
          id: "ar",
          displayName: "عرب",
          isSelected: idSelected == "ar"),
      SingleSelectionModel(
          index: 6,
          id: "ja",
          displayName: "日本人",
          isSelected: idSelected == "ja"),
      SingleSelectionModel(
          index: 7,
          id: "sc",
          displayName: "简体中文",
          isSelected: idSelected == "sc"),
      SingleSelectionModel(
          index: 8,
          id: "tc",
          displayName: "繁體中文",
          isSelected: idSelected == "tc"),
      SingleSelectionModel(
          index: 9,
          id: "eu",
          displayName: "Euskal",
          isSelected: idSelected == "eu"),
      SingleSelectionModel(
          index: 10,
          id: "gl",
          displayName: "Galego",
          isSelected: idSelected == "gl"),
      SingleSelectionModel(
          index: 11,
          id: "ca",
          displayName: "Català",
          isSelected: idSelected == "ca"),
      // SingleSelectionModel(
      //     index: 12,
      //     id: "ru",
      //     displayName: "русский",
      //     isSelected: idSelected == "ru"),
      // SingleSelectionModel(
      //     index: 13,
      //     id: "it",
      //     displayName: "Italiano",
      //     isSelected: idSelected == "it"),
      // SingleSelectionModel(
      //     index: 14,
      //     id: "vi",
      //     displayName: "Tiếng Việt",
      //     isSelected: idSelected == "vi"),
    ];

    return list;
  }

  static List<SingleSelectionModel> getActivityCategories(
      ACTIVITY_TYPE? selectedType) {
    List<SingleSelectionModel> list = [];
    ACTIVITY_TYPE.values.forEach((element) {
      list.add(SingleSelectionModel(
        id: ACTIVITY_TYPE.values[element.index].toString().split('.').last,
        index: element.index,
        isSelected: selectedType == ACTIVITY_TYPE.values[element.index],
        displayName: getActivityNameByType(ACTIVITY_TYPE.values[element.index],
            isForFilter: true),
      ));
    });
    return list;
  }

  static String getActivityNameByType(ACTIVITY_TYPE selectedType,
      {isForFilter = false, isFolder = false}) {
    switch (selectedType) {
      case ACTIVITY_TYPE.task_created:
        return R.string.createdTask;
      case ACTIVITY_TYPE.task_assigned:
        return R.string.taskAssigned;
      case ACTIVITY_TYPE.task_assigned_deleted:
        return R.string.taskUnassigned;
      case ACTIVITY_TYPE.mentioned:
        return R.string.mention;
      case ACTIVITY_TYPE.message_sent:
        return R.string.messageSent;
      case ACTIVITY_TYPE.signed_in:
        return R.string.loggedIn;
      default:
        return selectedType == ACTIVITY_TYPE.file_uploaded
            ? isForFilter
                ? R.string.uploadedFileFolder
                : isFolder
                    ? R.string.uploadedFolder
                    : R.string.uploadedFile
            : isForFilter
                ? R.string.downloadedFileFolder
                : isFolder
                    ? R.string.downloadedFolder
                    : R.string.downloadedFile;
    }
  }
}
