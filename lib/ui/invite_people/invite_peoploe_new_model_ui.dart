import 'package:code/_res/R.dart';
import 'package:code/domain/channel/channel_model.dart';
import 'package:code/domain/single_selection_model.dart';
import 'package:flutter/cupertino.dart';

class InvitePeopleModelUI {
  List<SingleSelectionModel>? groups;
  SingleSelectionModel? selectedGroup;
  bool singleInvitation;
  bool? groupRequired;
  SingleSelectionModel? languageInvitationSelected;
  List<SingleSelectionModel> languageInvitations;
  String invitationMessage;
  bool inviteMany;
  List<InvitePeopleEmailNameModelUI> invitePeopleEmailNameList;

  InvitePeopleModelUI({
    this.groups,
    this.groupRequired,
    this.inviteMany = false,
    this.singleInvitation = true,
    this.languageInvitationSelected,
    this.languageInvitations = const [],
    this.selectedGroup,
    this.invitationMessage = '',
    this.invitePeopleEmailNameList = const [],
  });

  List<SingleSelectionModel> groupsToSingleSelectionModel(
      List<ChannelModel> groups, int selectedIndex) {
    List<SingleSelectionModel> list = [];
    int index = 0;
    list.add(SingleSelectionModel(
        index: 0,
        id: "$index",
        displayName: R.string.chooseTitle,
        isSelected: selectedIndex == index));

    index += 1;
    groups.forEach((g) {
      list.add(SingleSelectionModel(
          index: index,
          id: g.id,
          displayName: g.titleFixed.toLowerCase().trim(),
          isSelected: index == selectedIndex));
      index += 1;
    });

    return list;
  }
}

class InvitePeopleEmailNameModelUI {
  TextEditingController emailController;
  TextEditingController nameController;

  InvitePeopleEmailNameModelUI({
    required this.emailController,
    required this.nameController,
  });
}
