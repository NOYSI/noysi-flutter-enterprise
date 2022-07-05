import 'package:code/_res/R.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class TXCellItemHeaderWidget extends StatelessWidget {
  final String? text;
  final Widget? leading;
  final Widget? trailing;
  final int childCount;
  final Function()? onTap;

  const TXCellItemHeaderWidget(
      {Key? key,
      this.text,
      this.leading,
      this.trailing,
      this.childCount = 0,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: R.color.grayDarkestColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 45,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              leading ?? Container(),
              SizedBox(
                width: leading != null ? 5 : 0,
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    TXTextWidget(
                      text: text ?? '',
                      color: R.color.grayLightestColor,
                      fontWeight: FontWeight.w500,
                    ),
                    TXTextWidget(
                      text: "($childCount)",
                      color: R.color.grayColor,
                    ),
                  ],
                ),
              ),
              trailing ?? Container()
            ],
          ),
        ),
      ),
    );
  }
}
