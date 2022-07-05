import 'package:code/_res/R.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class TXFolderWidget extends StatelessWidget {
  final Widget? icon;
  final String text;
  final Function()? onTap;
  final Function()? onLongPress;

  const TXFolderWidget({
    Key? key,
    this.icon,
    required this.text,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Border.all(
        width: 1,
        color: R.color.grayLightColor,
      ),
      elevation: 1,
      child: Material(
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            color: R.color.grayLightestColor,
            padding: EdgeInsets.only(left: 10, right: 5),
            child: Row(
              children: <Widget>[
                icon ??
                    Icon(
                      Icons.folder_open,
                      color: R.color.grayLightColor,
                      size: 30,
                    ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TXTextWidget(
                    text: text,
                    color: R.color.blackColor,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
