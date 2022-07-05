import 'package:code/_res/R.dart';
import 'package:code/domain/single_selection_model.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';

class TXBreadCrumbItemWidget extends StatelessWidget {
  final SingleSelectionModel? singleSelectionModel;
  final Function()? onTap;

  const TXBreadCrumbItemWidget({
    Key? key,
    this.singleSelectionModel,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minWidth: 50),
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: TXTextWidget(
                text: singleSelectionModel!.displayName,
                color: singleSelectionModel!.isSelected
                    ? Colors.black
                    : R.color.grayColor,
              ),
            ),
            !singleSelectionModel!.isSelected
                ? Icon(
                    Icons.arrow_right,
                    color: R.color.grayColor,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
