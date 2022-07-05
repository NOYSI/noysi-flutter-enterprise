import 'package:code/_res/R.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TXBadgeWidget extends StatelessWidget {
  final int count;

  const TXBadgeWidget({
    Key? key,
    this.count = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TeamTheme>(
      initialData: R.color.defaultTheme,
      stream: teamThemeController.stream,
      builder: (context, snapshot) {
        return Container(
          padding:
              EdgeInsets.symmetric(horizontal: count < 10 ? 7 : 5, vertical: 3),
          decoration: BoxDecoration(
              color: snapshot.data?.colors.notificationBadgeBackground,
              borderRadius: BorderRadius.all(Radius.circular(45))),
          child: Center(
            child: TXTextWidget(
              text: count.toString(),
              size: 12,
              fontWeight: FontWeight.w500,
              color: snapshot.data?.colors.notificationBadgeText,
            ),
          ),
        );
      },
    );
  }
}