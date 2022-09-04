import 'package:code/_res/R.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TXMilestoneProgressWidget extends StatelessWidget {
  final TaskMileStoneModel model;

  const TXMilestoneProgressWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percent = ((model.statistics?.closed.toDouble() ?? 0.0) +
        (model.statistics?.open.toDouble() ?? 0.0) ==
            0)
        ? 0.0
        : model.statistics!.closed.toDouble() *
            100 /
            (model.statistics!.closed.toDouble() +
                model.statistics!.open.toDouble());
    return Container(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: LinearPercentIndicator(
              lineHeight: 10,
              percent: (percent / 100),
              backgroundColor: R.color.grayLightestColor,
              progressColor: R.color.primaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: TXTextWidget(
                    text:
                        "${percent.toStringAsPrecision(2)}% ${R.string.completed}",
                    size: 12,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: TXTextWidget(
                    text: "${model.statistics?.open ?? ""} ${R.string.opened}",
                    size: 12,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: TXTextWidget(
                    text: "${model.statistics?.closed ?? ""} ${R.string.closedMilestone}",
                    size: 12,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
