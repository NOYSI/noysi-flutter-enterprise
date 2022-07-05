import 'package:code/_res/R.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class OnboardingPageIndicatorWidget extends StatelessWidget {
  final int count;
  final int currentIndex;
  final List<String> labels;

  const OnboardingPageIndicatorWidget(
      {Key? key, required this.count, required this.currentIndex, this.labels = const []})
      : assert(count == labels.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double lineWidth =
        (MediaQuery.of(context).size.width - 80 - count * 8.0) / count - 1;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[..._getIndicators(lineWidth)],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ...List.generate(
                count,
                (index) => TXTextWidget(
                      text: labels[index],
                      color: R.color.grayLightestColor,
                      size: 14,
                  textOverflow: TextOverflow.clip,
                    )),
          ],
        )
      ],
    );
  }

  List<Widget> _getIndicators(double lineWidth) {
    List<Widget> list = [];
    for (int i = 0; i < count; i++) {
      final w = i == 0
          ? CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundColor: currentIndex == i
                    ? Colors.yellow
                    : currentIndex > i
                        ? R.color.secondaryColor
                        : R.color.grayLightColor,
                radius: 7,
              ),
            )
          : Row(
              children: [
                Container(
                  height: 3,
                  width: lineWidth,
                  color: R.color.grayLightColor,
                ),
                CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundColor: currentIndex == i
                        ? Colors.yellow
                        : currentIndex > i
                            ? R.color.secondaryColor
                            : R.color.grayLightColor,
                    radius: 7,
                  ),
                ),
              ],
            );
      list.add(Container(
        //padding: EdgeInsets.symmetric(horizontal: 3),
        child: w,
      ));
    }
    return list;
  }
}
