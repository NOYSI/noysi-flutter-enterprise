import 'package:code/_res/R.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class TXMediaSelectorWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final Function()? onTap;
  final bool showVertically;
  final Color? titleColor;

  const TXMediaSelectorWidget({
    Key? key,
    required this.icon,
    this.title = '',
    this.onTap,
    this.showVertically = true,
    this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: showVertically ? 60 : 40,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: showVertically
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[icon, TXTextWidget(text: title)],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    icon,
                    SizedBox(
                      width: 3,
                    ),
                    TXTextWidget(
                      text: title,
                      color: titleColor ?? R.color.grayColor,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
