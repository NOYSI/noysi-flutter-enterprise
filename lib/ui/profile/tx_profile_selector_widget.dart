import 'package:code/_res/R.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class TXProfileSelectorWidget extends StatelessWidget {
  final bool isSelected;
  final GestureTapCallback? onTap;
  final String title;

  const TXProfileSelectorWidget(
      {Key? key, this.isSelected = false, this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TXTextWidget(
                text: title,
              ),
            ),
            Container(
              width: 50,
              child: isSelected
                  ? Icon(
                      Icons.check_circle,
                      color: R.color.secondaryColor,
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
