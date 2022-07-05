
import 'package:code/_res/R.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_base/richtext_widgets/tx_task_notification_body_info_widget.dart';
import 'package:code/ui/_base/richtext_widgets/tx_task_notification_header_info_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/task/tx_label_widget.dart';
import 'package:code/ui/task_detail/task_detail_page.dart';
import 'package:flutter/material.dart';

class TXTaskNotificationWidget extends StatelessWidget {
  final MessageModel messageModel;
  final GestureLongPressCallback? onLongPress;

  const TXTaskNotificationWidget({Key? key, required this.messageModel, this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color iconColor = messageModel.args?.event == RemoteConstants.task_closed
        ? R.color.secondaryColor
        : (messageModel.args?.event == RemoteConstants.task_assignee_added ||
                messageModel.args?.event == RemoteConstants.task_created ||
                messageModel.args?.event == RemoteConstants.task_milestone_set ||
                messageModel.args?.event == RemoteConstants.task_reopened ||
                messageModel.args?.event == RemoteConstants.task_comment_added)
            ? R.color.orange
            : R.color.blueLink;
    return Container(
      //margin: EdgeInsets.only(top: 10, left: 10),
      decoration: BoxDecoration(
          border: Border.all(color: R.color.grayLightestColor, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: InkWell(
        onTap: () async {
          NavigationUtils.push(
              context,
              TaskDetailPage(
                taskId: messageModel.args?.taskId ?? "",
              ));
        },
        onLongPress: onLongPress,
        child: Container(
          padding: EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: iconColor, width: 2)),
                child: Center(
                  child: Icon(
                    Icons.border_outer,
                    color: iconColor,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TXTaskNotificationHeaderInfoWidget(
                      messageModel: messageModel,
                    ),
                    TXTextWidget(
                      text: messageModel.args?.title ?? "",
                      color: R.color.secondaryColor,
                      size: 16,
                    ),
                    TXTaskNotificationBodyInfoWidget(
                      messageModel: messageModel,
                    ),
                    messageModel.args?.comment.trim().isNotEmpty == true
                        ? _getComments()
                        : Container(),
                    _getLabels(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getLabels() {
    List<Widget> list = [];
    messageModel.args?.labels.forEach((element) {
      final w = TXLabelWidget(
        taskLabelModel: element,
      );
      list.add(w);
    });
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: <Widget>[...list],
    );
  }

  Widget _getComments() {
    return RichText(
      text: TextSpan(children: [
        WidgetSpan(
            child: Icon(
          Icons.comment,
          size: 16,
          color: R.color.blackColor,
        )),
        TextSpan(text: " "),
        TextSpan(
            text: messageModel.args?.parsedComment,
            style: TextStyle(
                color: R.color.blackColor,
                fontSize: 16,
                fontStyle: FontStyle.italic))
      ]),
    );

    // Row(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Icon(
    //       Icons.comment,
    //       size: 15,
    //       color: R.color.blackColor,
    //     ),
    //     SizedBox(
    //       width: 5,
    //     ),
    //     Expanded(
    //         child: TXTextWidget(
    //       text: messageModel.args.comment,
    //       size: 14,
    //       fontStyle: FontStyle.italic,
    //     ))
    //   ],
    // );
  }
}
