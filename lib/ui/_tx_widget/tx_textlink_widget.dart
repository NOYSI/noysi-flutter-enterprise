import 'package:code/_res/R.dart';
import 'package:flutter/material.dart';

class TXTextLinkWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color? splashColor;
  final Color? textColor;
  final FontWeight fontWeight;
  final double fontSize;
  final Color? backgroundColor;
  final TextDecoration? textDecoration;

  const TXTextLinkWidget({
    super .key,
    required this.onTap,
    required this.title,
    this.splashColor,
    this.fontWeight = FontWeight.normal,
    this.textColor = Colors.grey,
    this.fontSize = 18,
    this.backgroundColor,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: splashColor,
      child: Text(
        title,
        style: TextStyle(
            color: textColor ?? R.color.primaryLightColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            decoration: textDecoration ?? TextDecoration.underline),
      ),
    );
  }
}
