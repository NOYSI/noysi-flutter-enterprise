import 'package:code/_res/R.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class UserDetailCellWidget extends StatelessWidget {
  final String title;
  final String data;

  const UserDetailCellWidget({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: TXTextWidget(
            textAlign: TextAlign.end,
            text: title,
            color: R.color.secondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 3,
          child: TXTextWidget(
            textAlign: TextAlign.start,
            text: data,
          ),
        )
      ],
    );
  }

}