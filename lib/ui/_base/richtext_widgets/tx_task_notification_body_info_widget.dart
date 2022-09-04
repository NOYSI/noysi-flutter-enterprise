
import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show PlaceholderAlignment;

class TXTaskNotificationBodyInfoWidget extends StatelessWidget {
  final MessageModel messageModel;

  const TXTaskNotificationBodyInfoWidget({Key? key, required this.messageModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasContentToShow =
        messageModel.args?.event == RemoteConstants.task_created ||
            messageModel.args?.event == RemoteConstants.task_due_updated;
    return !hasContentToShow
        ? Container(
            height: 5,
          )
        : RichText(
            text: TextSpan(children: [..._getSpans()]),
          );
  }

  List<InlineSpan> _getSpans() {
    List<InlineSpan> spanList = [];
    switch (messageModel.args?.event) {
      case RemoteConstants.task_created:
        {
          if (messageModel.args?.newDue != null) {
            spanList.add(WidgetSpan(
                alignment: ui.PlaceholderAlignment.middle,
                child: Icon(
                  Icons.calendar_today,
                  size: 12,
                  color: R.color.blackColor,
                )));
            spanList.add(_getTextSpan(
              " ${CalendarUtils.showInFormat(R.string.dateFormat5, messageModel.args?.newDue)?.toLowerCase()}",
            ));
          }
        }
        break;
      case RemoteConstants.task_due_updated:
        {
          if (messageModel.args?.newDue != null) {
            spanList.add(WidgetSpan(
                alignment: ui.PlaceholderAlignment.middle,
                child: Icon(
                  Icons.calendar_today,
                  size: 12,
                  color: R.color.blackColor,
                )));

            spanList.add(_getTextSpan(
              " ${CalendarUtils.showInFormat(R.string.dateFormat5, messageModel.args?.newDue)?.toLowerCase()}",
            ));
          }
        }
        break;
    }
    return spanList;
  }

  TextSpan _getTextSpan(String text,
      {Color? textColor, FontWeight? fontWeight, double fontSize = 16}) {
    return TextSpan(
        text: text,
        style: _getTextStyle(
            textColor: textColor,
            fontWeight: fontWeight ?? FontWeight.normal,
            fontSize: fontSize));
  }

  TextStyle _getTextStyle(
      {Color? textColor, FontWeight? fontWeight, double? fontSize}) {
    return TextStyle(
        color: textColor ?? R.color.blackColor,
        fontSize: fontSize ?? 18,
        fontWeight: fontWeight);
  }
}
