import 'package:code/domain/message/message_model.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

import '../../_res/R.dart';

class TXReactionsWidget extends StatelessWidget {
  final ValueChanged<String>? onReactionSelected;

  const TXReactionsWidget({
    Key? key,
    this.onReactionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 290,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: R.color.grayLightestColor,
            ),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TXTextWidget(text: R.string.addReaction, fontWeight: FontWeight.bold,)
              ],
            ),
          ),
          Container(
            height: 1,
            color: R.color.grayLightColor,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 10),
              physics: const BouncingScrollPhysics(),
              child: Wrap(
                children: <Widget>[
                  ...ReactionsModel.getReactions().map((element) => Container(
                    padding: const EdgeInsets.all(2),
                    decoration:
                    const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Material(
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          onTap: onReactionSelected != null
                              ? () {
                            onReactionSelected!(element.reactionKey);
                          }
                              : null,
                          child: Image.asset(
                            "${R.image.reactionBase}${element.reactionKey}.gif",
                            width: 40,
                            height: 40,
                          ),
                        )),
                  )).toList()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
