import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class TXLabelWidget extends StatelessWidget {
  final TaskLabelModel? taskLabelModel;
  final Function()? onTap;

  const TXLabelWidget({
    Key? key,
    this.taskLabelModel,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String backgroundColor = taskLabelModel?.background.split("#").last ?? "";
    String textColor = taskLabelModel?.text.split("#").last ?? "";
    return Chip(
      padding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      backgroundColor: Color(
          int.tryParse('0xFF$backgroundColor') ?? int.parse('0xFF9A2FAE')),
      deleteIcon: onTap != null
          ? Icon(
              Icons.remove_circle,
              size: 15,
              color: Color(textColor.toLowerCase() == "fff"
                  ? int.parse('0xFFFFFFFF')
                  : int.tryParse('0xFF$textColor') ?? int.parse('0xFFFFFFFF')),
            )
          : null,
      onDeleted: onTap,
      elevation: 1,
      label: TXTextWidget(
        fontWeight: FontWeight.bold,
        text: taskLabelModel?.name ?? '',
        color: Color(textColor.toLowerCase() == "fff"
            ? int.parse('0xFFFFFFFF')
            : int.tryParse('0xFF$textColor') ?? int.parse('0xFFFFFFFF')),
      ),
    );
  }
}
