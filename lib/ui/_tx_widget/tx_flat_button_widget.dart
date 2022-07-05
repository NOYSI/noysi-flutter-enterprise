import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class TXFlatButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;

  const TXFlatButtonWidget({
    required this.onPressed,
    required this.title,
    this.fontWeight = FontWeight.normal,
    this.textColor = Colors.white,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: TXTextWidget(
        text: title,
        color: textColor,
        fontWeight: fontWeight,
        size: fontSize,
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
