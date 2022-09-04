import 'package:code/_res/R.dart';
import 'package:code/domain/single_selection_model.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/_tx_widget/tx_textlink_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TXCupertinoPickerWidget extends StatelessWidget {
  final double? height;
  final List<SingleSelectionModel> list;
  final ValueChanged<SingleSelectionModel>? onItemSelected;
  final String? title;
  final int initialItem;
  final double itemTextSize;

  const TXCupertinoPickerWidget(
      {Key? key,
      this.height,
      required this.list,
      this.onItemSelected,
      this.title,
      this.initialItem = 0,
      this.itemTextSize = 16.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SingleSelectionModel currentItem = list[initialItem];
    return Container(
      height: height,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5).copyWith(left: 10, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: TXTextWidget(
                    text: title ?? '',
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                    size: 18,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: TXTextLinkWidget(
                    title: R.string.ok,
                    textColor: R.color.darkColor,
                    fontSize: 16,
                    onTap: () {
                      onItemSelected!(currentItem);
                      NavigationUtils.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              scrollController:
                  FixedExtentScrollController(initialItem: initialItem),
              itemExtent: 30,
              backgroundColor: Colors.white,
              onSelectedItemChanged: (int index) {
                currentItem = list[index];
              },
              children: List<Widget>.generate(list.length, (int index) {
                return Center(
                  child: TXTextWidget(
                    text: list[index].displayName,
                    color: Colors.black,
                    size: itemTextSize,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
