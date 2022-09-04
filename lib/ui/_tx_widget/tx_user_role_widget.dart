import 'package:code/_res/R.dart';
import 'package:code/domain/user/user_model.dart';
import 'package:code/enums.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class TXUserRoleWidget extends StatelessWidget {
  final MemberModel memberModel;

  const TXUserRoleWidget({
    Key? key,
    required this.memberModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: R.color.grayDarkColor),
      child: TXTextWidget(
        size: 14,
        text: memberModel.userRol == UserRol.Admin
            ? R.string.administrator
            : memberModel.userRol == UserRol.Member
                ? R.string.member
                : memberModel.userRol == UserRol.Robot
                    ? R.string.robot
                    : R.string.guest,
        color: R.color.whiteColor,
      ),
    );
  }
}
