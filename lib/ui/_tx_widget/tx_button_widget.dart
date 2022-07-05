import 'package:code/_res/R.dart';
import 'package:flutter/material.dart';

class TXButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? mainColor;
  final Color? splashColor;
  final Color? textColor;
  final FontWeight fontWeight;
  final double fontSize;
  final OutlinedBorder? shapeBorder;

  const TXButtonWidget({
    required this.onPressed,
    required this.title,
    this.mainColor,
    this.splashColor,
    this.fontWeight = FontWeight.normal,
    this.textColor = Colors.white,
    this.fontSize = 18,
    this.shapeBorder,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.pressed)
              ? splashColor ?? R.color.secondaryHeaderColor
              : null;
        }),
        backgroundColor:
            MaterialStateProperty.all(mainColor ?? R.color.secondaryColor),
        shape: MaterialStateProperty.all(
          shapeBorder ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
        ),
      ),
    );
  }
}
