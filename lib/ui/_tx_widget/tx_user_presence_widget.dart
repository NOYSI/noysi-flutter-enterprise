import 'package:code/_res/R.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';

class TXUserPresenceWidget extends StatelessWidget {
  final UserPresence userPresence;
  final isUserEnabled;

  const TXUserPresenceWidget({
    Key? key,
    required this.userPresence,
    this.isUserEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TeamTheme>(
      stream: teamThemeController.stream,
      initialData: R.color.defaultTheme,
      builder: (context, snapshot) {
        return isUserEnabled
            ? CircleAvatar(
                backgroundColor: userPresence == UserPresence.online
                    ? snapshot.data?.colors.activePresence
                    : userPresence == UserPresence.offline
                        ? R.color.grayColor
                        : snapshot.data?.colors.inactivePresence,
                radius: 5,
              )
            : Container(
                padding: EdgeInsets.all(3.7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  border: Border.all(color: R.color.darkColor, width: 1.3),
                ));
      },
    );
  }
}
