import 'package:code/_res/R.dart';
import 'package:flutter/material.dart';

class TXDividerWidget extends StatelessWidget {
  final double height;

  const TXDividerWidget({
    Key? key,
    this.height = .5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: R.color.grayLightColor,
    );
  }
}
