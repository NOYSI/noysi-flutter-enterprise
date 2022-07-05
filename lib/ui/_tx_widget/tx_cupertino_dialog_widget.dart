import 'package:code/_res/R.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/cupertino.dart';

class TXCupertinoDialogWidget extends StatelessWidget {
  final Function()? onOK;
  final Function()? onCancel;
  final String? title;
  final String? content;
  final Widget? contentWidget;
  final Color? confirmActionColor;
  final String? confirmText;

  const TXCupertinoDialogWidget({
    Key? key,
    this.onOK,
    this.onCancel,
    this.title,
    this.content,
    this.contentWidget,
    this.confirmActionColor,
    this.confirmText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: TXTextWidget(
        text: title ?? '',
        fontWeight: FontWeight.bold,
        maxLines: null,
        color: R.color.blackColor,
      ),
      content: Container(
        margin: EdgeInsets.only(top: 10),
        child: contentWidget ??
            TXTextWidget(
              text: content ?? '',
              textOverflow: TextOverflow.ellipsis,
              maxLines: 4,
              color: R.color.blackColor,
            ),
      ),
      actions: <Widget>[
        if (onCancel != null)
          CupertinoDialogAction(
            child: TXTextWidget(
              text: R.string.cancel,
              color: R.color.blackColor,
            ),
            onPressed: onCancel,
          ),
        CupertinoDialogAction(
          child: TXTextWidget(
            text: confirmText ?? R.string.ok,
            color: confirmActionColor ?? R.color.blackColor,
          ),
          onPressed: onOK,
        ),
      ],
    );
  }
}
