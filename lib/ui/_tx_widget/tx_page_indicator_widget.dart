import 'package:code/_res/R.dart';
import 'package:flutter/material.dart';

class TXPageIndicatorWidget extends StatelessWidget {
  final int count;
  final int currentIndex;

  const TXPageIndicatorWidget({
    Key? key,
    required this.count,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[..._getIndicators()],
    );
  }

  List<Widget> _getIndicators() {
    List<Widget> list = [];
    for (int i = 0; i < count; i++) {
      final w = CircleAvatar(
        radius: 7,
        backgroundColor:
            currentIndex == i ? R.color.darkColor : R.color.grayLightColor,
      );
      list.add(Container(
        padding: EdgeInsets.symmetric(horizontal: 3),
        child: w,
      ));
    }
    return list;
  }
}
