import 'package:code/_res/R.dart';
import 'package:code/domain/single_selection_model.dart';
import 'package:code/ui/_tx_widget/tx_bottom_sheet.dart';
import 'package:code/ui/_tx_widget/tx_cupertino_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TXBottomSheetSelectorWidget extends StatelessWidget {
  final List<SingleSelectionModel> list;
  final ValueChanged<SingleSelectionModel>? onItemSelected;
  final double bottomSheetHeight;
  final String title;
  final double itemTextSize;

  const TXBottomSheetSelectorWidget({
    Key? key,
    required this.list,
    this.onItemSelected,
    this.bottomSheetHeight = 300,
    this.title = '',
    this.itemTextSize = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SingleSelectionModel currentSelected =
        list.firstWhere((element) => element.isSelected, orElse: () {
      return list[0];
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _TXBoxCellDataWidget(
          value: currentSelected.displayName,
          onTap: () {
            if (list.isEmpty)
              Fluttertoast.showToast(
                  msg: R.string.emptyList,
                  toastLength: Toast.LENGTH_LONG,
                  textColor: R.color.whiteColor,
                  backgroundColor: R.color.primaryColor);
            else
              showTXModalBottomSheet(
                  context: context,
                  builder: (ctx) {
                    return TXCupertinoPickerWidget(
                      height: bottomSheetHeight,
                      list: list,
                      onItemSelected: onItemSelected,
                      title: title,
                      initialItem: currentSelected.index,
                      itemTextSize: itemTextSize,
                    );
                  });
          },
        )
      ],
    );
  }
}

class _TXBoxCellDataWidget extends StatelessWidget {
  final String value;
  final Function()? onTap;

  const _TXBoxCellDataWidget({
    Key? key,
    required this.value,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(width: .5, color: R.color.grayColor),
            color: Colors.white),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TXTextWidget(
                text: value,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
