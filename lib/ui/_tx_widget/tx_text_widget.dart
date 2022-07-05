import 'package:code/_res/R.dart';
import 'package:flutter/material.dart';

import '../../data/api/remote/remote_constants.dart';

class TXTextWidget extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final FontWeight fontWeight;
  final int? maxLines;
  final TextOverflow textOverflow;
  final TextAlign textAlign;
  final String fontFamily;
  final FontStyle? fontStyle;

  TXTextWidget({
    required this.text,
    this.size = 18,
    this.color,
    this.fontFamily = RemoteConstants.fontFamily,
    this.fontWeight = FontWeight.normal,
    this.maxLines,
    this.textOverflow = TextOverflow.clip,
    this.textAlign = TextAlign.start,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: fontFamily,
          color: color ?? R.color.grayDarkColor,
          fontSize: size,
          fontWeight: fontWeight,
          fontStyle: fontStyle),
      maxLines: maxLines,
      overflow: textOverflow,
    );
  }
}
