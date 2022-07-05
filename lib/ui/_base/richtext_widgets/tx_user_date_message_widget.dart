import 'package:code/_res/R.dart';
import 'package:flutter/material.dart';

class TXUserDateMessageWidget extends StatelessWidget {
  final String userText;
  final String dateText;
  final GestureTapCallback? onTap;

  const TXUserDateMessageWidget({Key? key, this.userText = '', this.dateText = '', this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
            text: userText.trim(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: R.color.blackColor),
            children: [
              TextSpan(text: " "),
              TextSpan(
                  text: dateText,
                  style: TextStyle(
                      color: R.color.grayColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14))
            ]),
      ),
    );
  }
}
