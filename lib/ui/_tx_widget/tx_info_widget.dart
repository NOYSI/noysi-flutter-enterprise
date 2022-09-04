import 'package:code/_res/R.dart';
import 'package:flutter/material.dart';

enum InfoType { warning, info }

class TXInfoWidget extends StatelessWidget {
  final InfoType type;
  final Widget info;

  TXInfoWidget({this.type = InfoType.info, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: type == InfoType.info
                ? Color.fromRGBO(51, 51, 204, 0.2)
                : Color.fromRGBO(246, 177, 63, .2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: type == InfoType.info
                      ? R.color.secondaryColor
                      : R.color.warning),
              child: Icon(
                type == InfoType.info
                    ? Icons.info_outline
                    : Icons.warning_amber_outlined,
                color: R.color.whiteColor,
                size: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: info
            )
          ],
        ),
      ),
    );
  }
}
