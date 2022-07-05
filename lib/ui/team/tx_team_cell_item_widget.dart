import 'package:code/_res/R.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class TXTeamCellItemWidget extends StatelessWidget {
  final GestureTapCallback? onTap;
  final TeamModel team;

  const TXTeamCellItemWidget(
      {Key? key, required this.team, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      onTap: onTap,
      leading: TXNetworkImage(
        forceLoad: true,
        imageUrl: team.photo ?? '',
        placeholderImage: Image.asset(R.image.logo),
      ),
      title: TXTextWidget(
        text: team.titleFixed,
        color: R.color.blackColor,
        fontWeight: FontWeight.bold,
      ),
      subtitle: TXTextWidget(
        text: "${team.unreadMessagesCount} ${R.string.unReadMessages.toLowerCase()}",
        color: R.color.secondaryColor,
        size: 14,
      ),

      trailing: Icon(team.isSelected ? Icons.check_circle_outline : Icons.arrow_forward_ios, size: 20,
      color: team.isSelected ? R.color.secondaryColor : R.color.grayColor,),
    );
  }
}
