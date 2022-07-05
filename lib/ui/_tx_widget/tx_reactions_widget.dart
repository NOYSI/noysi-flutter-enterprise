import 'package:code/domain/message/message_model.dart';
import 'package:flutter/material.dart';

class TXReactionsWidget extends StatelessWidget {
  final ValueChanged<String>? onReactionSelected;

  const TXReactionsWidget({
    Key? key,
    this.onReactionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Wrap(
          children: <Widget>[..._getReactions()],
        ),
      ),
    );
  }

  List<Widget> _getReactions() {
    List<Widget> reactionWidgets = [];

    List<ReactionsModel> reactions = ReactionsModel.getReactions();
    reactions.forEach((element) {
      final w = Container(
        padding: EdgeInsets.all(2),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Material(
            child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          onTap: onReactionSelected != null
              ? () {
                  onReactionSelected!(
                      element.reactionKey.split("/").last.split(".").first);
                }
              : null,
          child: Image.asset(
            element.reactionKey,
            width: 40,
            height: 40,
          ),
        )),
      );
      reactionWidgets.add(w);
    });
    return reactionWidgets;
  }
}
