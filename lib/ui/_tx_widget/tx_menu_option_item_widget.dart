import 'package:code/_res/R.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class TXMenuOptionItemWidget extends StatelessWidget {
  final Widget? icon;
  final String text;
  final Function()? onTap;
  final EdgeInsets? padding;
  final Color? textColor;
  final Widget? trailing;

  const TXMenuOptionItemWidget({
    Key? key,
    this.icon,
    this.text = '',
    this.onTap,
    this.padding,
    this.textColor,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            icon ?? Container(),
            SizedBox(
              width: 5,
            ),
            TXTextWidget(
              text: text,
              color: textColor ?? R.color.blackColor,
            ),
            Expanded(
              child: Container(),
            ),
            trailing ?? Container(),
          ],
        ),
      ),
    );
  }
}
