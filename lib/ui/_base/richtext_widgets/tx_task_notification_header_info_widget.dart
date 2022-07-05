import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/task/tx_label_widget.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:code/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show PlaceholderAlignment;

class TXTaskNotificationHeaderInfoWidget extends StatelessWidget {
  final MessageModel messageModel;

  const TXTaskNotificationHeaderInfoWidget({Key? key, required this.messageModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 10,
      text: TextSpan(children: [..._getSpans()]),
    );
  }

  List<InlineSpan> _getSpans() {
    List<InlineSpan> spanList = [];
    String? user = CommonUtils.getMemberUsername(Injector.instance.inMemoryData
        .getMember(messageModel.args?.uid ?? ""));
    spanList.add(_getTextSpan("@${user ?? ""}",
        textColor: R.color.secondaryColor, fontWeight: FontWeight.normal));

    switch (messageModel.args?.event) {
      case RemoteConstants.task_created:
        {
          final taskWithNoAssignees = messageModel.args?.assignees == null ||
              messageModel.args?.assignees.isEmpty == true;
          spanList.add(_getTextSpan(
              " ${taskWithNoAssignees ? "${R.string.hasCreatedTask.toLowerCase()}:" : R.string.hasCreatedTaskAssignedTo.toLowerCase()}"));
          if (!taskWithNoAssignees) {
            messageModel.args?.assignees.forEach((element) {
              final userName = CommonUtils.getMemberUsername(Injector.instance.inMemoryData
                  .getMember(element)) ?? "";

              spanList.add(_getTextSpan(" @$userName",
                  textColor: R.color.secondaryColor));
            });
          }
        }
        break;
      case RemoteConstants.task_closed:
        {
          spanList
              .add(_getTextSpan(" ${R.string.hasClosedTask.toLowerCase()}:"));
        }
        break;
      case RemoteConstants.task_reopened:
        {
          spanList
              .add(_getTextSpan(" ${R.string.hasReopenedTask.toLowerCase()}:"));
        }
        break;
      case RemoteConstants.task_title_edited:
        {
          spanList
              .add(_getTextSpan(" ${R.string.hasEditedTask.toLowerCase()}:"));
        }
        break;
      case RemoteConstants.task_due_updated:
        {
          if (messageModel.args?.newDue != null &&
              messageModel.args?.oldDue == null) {
            spanList.add(_getTextSpan(
                " ${R.string.hasAssignedNewDueDateFor.toLowerCase()}"));
            spanList.add(_getTextSpan(
                " ${CalendarUtils.showInFormat(R.string.dateFormat5, messageModel.args?.newDue)?.toLowerCase()}",
                textColor: R.color.blackColor,
                fontWeight: FontWeight.w500));
          } else {
            spanList.add(_getTextSpan(
                " ${messageModel.args?.newDue == null ? R.string.hasRemovedEndDateTask.toLowerCase() : R.string.hasUpdatedDateTask}:"));
            spanList.add(_getTextSpan(
                " ${CalendarUtils.showInFormat(R.string.dateFormat5, messageModel.args?.oldDue)?.toLowerCase()}",
                textColor: R.color.blackColor,
                fontWeight: FontWeight.w500));
            if (messageModel.args?.newDue != null) {
              spanList.add(_getTextSpan(" ${R.string.to.toLowerCase()}"));
              spanList.add(_getTextSpan(
                  " ${CalendarUtils.showInFormat(R.string.dateFormat5, messageModel.args?.newDue)?.toLowerCase()}",
                  textColor: R.color.blackColor,
                  fontWeight: FontWeight.w500));
            }
          }
          spanList.add(_getTextSpan(" ${R.string.inTheTask.toLowerCase()}:"));
        }
        break;
      case RemoteConstants.task_comment_added:
        {
          spanList
              .add(_getTextSpan(" ${R.string.hasCommentedTask.toLowerCase()}"));
          spanList.add(_getTextSpan(" ${R.string.inTheTask.toLowerCase()}:"));
        }
        break;
      case RemoteConstants.task_comment_deleted:
        {
          spanList.add(
              _getTextSpan(" ${R.string.hasDeletedCommentTask.toLowerCase()}"));
          spanList.add(_getTextSpan(" ${R.string.inTheTask.toLowerCase()}:"));
        }
        break;
      case RemoteConstants.task_comment_edited:
        {
          spanList.add(
              _getTextSpan(" ${R.string.hasEditedCommentTask.toLowerCase()}"));
          spanList.add(_getTextSpan(" ${R.string.inTheTask.toLowerCase()}:"));
        }
        break;

      case RemoteConstants.task_milestone_set:
        {
          spanList
              .add(_getTextSpan(" ${R.string.hasSetMilestone.toLowerCase()}"));
          spanList.add(
            _getTextSpan(" ${messageModel.args?.name}",
                textColor: R.color.secondaryColor, fontWeight: FontWeight.w500),
          );
          spanList.add(_getTextSpan(" ${R.string.inTheTask.toLowerCase()}:"));
        }
        break;

      case RemoteConstants.task_assignee_added:
        {
          spanList
              .add(_getTextSpan(" ${R.string.hasAssignedUser.toLowerCase()}"));
          spanList.add(_getTextSpan(" @${messageModel.args?.assigneeName}",
              textColor: R.color.secondaryColor, fontWeight: FontWeight.w500));
          spanList.add(_getTextSpan(" ${R.string.inTheTask.toLowerCase()}:"));
        }
        break;
      case RemoteConstants.task_assignee_deleted:
        {
          spanList.add(_getTextSpan(
            " ${R.string.hasUnAssignedUser.toLowerCase()}",
          ));
          spanList.add(_getTextSpan(" @${messageModel.args?.assigneeName}",
              textColor: R.color.secondaryColor, fontWeight: FontWeight.w500));
          spanList.add(_getTextSpan(" ${R.string.inTheTask.toLowerCase()}:"));
        }
        break;
      case RemoteConstants.task_label_deleted:
        {
          spanList.add(_getTextSpan(
            " ${R.string.hasDeleteTag.toLowerCase()}",
          ));
          spanList.add(_getTextSpan(
            " ",
          ));
          spanList.add(WidgetSpan(
              alignment: ui.PlaceholderAlignment.middle,
              child: TXLabelWidget(
                taskLabelModel: TaskLabelModel(
                    id: messageModel.args?.id ?? "",
                    name: messageModel.args?.name ?? "",
                    background: messageModel.args?.background ?? "",
                    text: messageModel.args?.color ?? ''),
              )));
          spanList.add(_getTextSpan(" ${R.string.inTheTask.toLowerCase()}:"));
        }
        break;
      case RemoteConstants.task_label_added:
        {
          spanList.add(_getTextSpan(
            " ${R.string.hasAddedTag.toLowerCase()}",
          ));
          spanList.add(_getTextSpan(
            " ",
          ));
          spanList.add(WidgetSpan(
              alignment: ui.PlaceholderAlignment.middle,
              child: Container(
                child: TXLabelWidget(
                  taskLabelModel: TaskLabelModel(
                      id: messageModel.args?.id ?? "",
                      name: messageModel.args?.name ?? "",
                      background: messageModel.args?.background ?? "",
                      text: messageModel.args?.color ?? ""),
                ),
              )));
          spanList.add(_getTextSpan(" ${R.string.inTheTask.toLowerCase()}:"));
        }
        break;
    }

    return spanList;
  }

  TextSpan _getTextSpan(String text,
      {Color? textColor, FontWeight? fontWeight, double? fontSize}) {
    return TextSpan(
        text: text,
        style: _getTextStyle(
            textColor: textColor,
            fontWeight: FontWeight.w500,
            fontSize: fontSize ?? 15));
  }

  TextStyle _getTextStyle(
      {Color? textColor, FontWeight? fontWeight, double? fontSize}) {
    return TextStyle(
        color: textColor ?? R.color.blackColor, fontSize: fontSize ?? 16, fontWeight: fontWeight);
  }
}
