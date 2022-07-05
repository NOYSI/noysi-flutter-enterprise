import 'package:code/_res/R.dart';
import 'package:code/_res/values/config.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/enums.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/task/tx_label_widget.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class TXTaskTimelineWidget extends StatelessWidget {
  final TaskTimeLineModel taskTimeLineModel;
  final List<TaskParticipantsModel> participants;
  final Function()? onCommentTapped;
  final InMemoryData inMemoryData;

  const TXTaskTimelineWidget(
      {Key? key,
      required this.taskTimeLineModel,
      this.participants = const [],
      this.onCommentTapped,
      required this.inMemoryData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget w;
    if (taskTimeLineModel.type == 'label:added' ||
        taskTimeLineModel.type == 'label:removed') {
      w = _getLabelWidget();
    } else if (taskTimeLineModel.type == 'task:reopen' ||
        taskTimeLineModel.type == 'task:closed') {
      w = _getStatusWidget();
    } else if (taskTimeLineModel.type == 'title:updated') {
      w = _getUpdatedWidget();
    } else if (taskTimeLineModel.type == 'assignee:added') {
      w = _getAssigneeWidget();
    } else if (taskTimeLineModel.type == 'task:due:updated') {
      w = _getDueDateWidget();
    } else if (taskTimeLineModel.type == 'comment:added') {
      w = _getCommentWidget();
    } else if (taskTimeLineModel.type == 'milestone:set') {
      w = _getMilestoneWidget();
    } else {
      w = Container();
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: w,
    );
  }

  Widget _getLabelWidget() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5,
      runSpacing: 3,
      children: <Widget>[
        Icon(
          Icons.label_outline,
          color: R.color.grayColor,
          size: 15,
        ),
        TXTextWidget(
          text: "@${taskTimeLineModel.creator?.name ?? ""}",
          color: R.color.blackColor,
        ),
        TXTextWidget(
          text: taskTimeLineModel.type == 'label:added'
              ? R.string.tagAdded.toLowerCase()
              : R.string.tagRemoved.toLowerCase(),
        ),
        TXLabelWidget(
          taskLabelModel: TaskLabelModel(
              id: taskTimeLineModel.label?.id ?? "",
              name: taskTimeLineModel.label?.name ?? "",
              background: taskTimeLineModel.label?.background ?? "",
              text: taskTimeLineModel.label?.text ?? ""),
        )
      ],
    );
  }

  Widget _getStatusWidget() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5,
      children: <Widget>[
        Icon(
          taskTimeLineModel.type == 'task:reopen'
              ? Icons.autorenew
              : Icons.check_circle_outline,
          color: R.color.grayColor,
          size: 15,
        ),
        TXTextWidget(
          text: "@${taskTimeLineModel.creator?.name ?? ''}",
          color: R.color.blackColor,
        ),
        TXTextWidget(
          text: taskTimeLineModel.type == 'task:reopen'
              ? R.string.reopen.toLowerCase()
              : R.string.closed.toLowerCase(),
        ),
      ],
    );
  }

  Widget _getUpdatedWidget() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5,
      children: <Widget>[
        Icon(
          Icons.edit,
          color: R.color.grayColor,
          size: 15,
        ),
        TXTextWidget(
          text: "@${taskTimeLineModel.creator?.name ?? ""}",
          color: R.color.blackColor,
        ),
        TXTextWidget(
          text: "${taskTimeLineModel.oldTitle} > ${taskTimeLineModel.newTitle}",
        ),
      ],
    );
  }

  Widget _getAssigneeWidget() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5,
      children: <Widget>[
        Icon(
          Icons.account_circle,
          color: R.color.grayColor,
          size: 15,
        ),
        TXTextWidget(
          text: "@${taskTimeLineModel.assignee?.name ?? ""}",
          color: R.color.blackColor,
        ),
        TXTextWidget(
          text: R.string.assigneeBy.toLowerCase(),
        ),
        TXTextWidget(
          text: "@${taskTimeLineModel.creator?.name ?? ""}",
          color: R.color.blackColor,
        ),
      ],
    );
  }

  Widget _getDueDateWidget() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5,
      children: <Widget>[
        Icon(
          Icons.update,
          color: R.color.grayColor,
          size: 15,
        ),
        TXTextWidget(
          text: "@${taskTimeLineModel.creator?.name ?? ""}",
          color: R.color.blackColor,
        ),
        TXTextWidget(
          text: R.string.dueDateUpdated.toLowerCase(),
        ),
        TXTextWidget(
          text:
              "${taskTimeLineModel.oldDue != null ? "${CalendarUtils.showInFormat('MMM, d', taskTimeLineModel.oldDue)} >" : ""} ${CalendarUtils.showInFormat('MMM, dd', taskTimeLineModel.newDue)}",
        ),
      ],
    );
  }

  Widget _getCommentWidget() {
    final userUrl = participants.firstWhereOrNull(
        (element) => element.uid == taskTimeLineModel.creator?.uid)?.photo;
    return  InkWell(
            onTap:  taskTimeLineModel.creator?.uid == inMemoryData.currentMember!.id ||
                inMemoryData.currentMember!.userRol == UserRol.Admin
                ? onCommentTapped : null,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TXNetworkImage(
                  height: 35,
                  width: 35,
                  forceLoad: true,
                  imageUrl: userUrl ?? "",
                  placeholderImage: Image.asset(R.image.logo),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 5,
                        children: <Widget>[
                          TXTextWidget(
                            text: "@${taskTimeLineModel.creator?.name ?? ""}",
                            color: R.color.blackColor,
                          ),
                          TXTextWidget(
                            text: "${R.string.commented.toLowerCase()}",
                          ),
                          TXTextWidget(
                            text:
                                AppConfig.localeCode == "es" ? "${R.string.ago.toLowerCase()} ${CalendarUtils.getFancyTime(taskTimeLineModel.created!)}" : "${CalendarUtils.getFancyTime(taskTimeLineModel.created!)} ${R.string.ago.toLowerCase()}",
                            color: R.color.blackColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TXTextWidget(
                        color: R.color.grayDarkestColor,
                        text: taskTimeLineModel.parsedComment,
                        textOverflow: TextOverflow.clip,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }

  Widget _getMilestoneWidget() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5,
      children: <Widget>[
        Icon(
          Icons.flag,
          color: R.color.grayColor,
          size: 15,
        ),
        TXTextWidget(
          text: "@${taskTimeLineModel.creator?.name ?? ""}",
          color: R.color.blackColor,
        ),
        TXTextWidget(
          text: R.string.milestoneAdded.toLowerCase(),
        ),
        TXTextWidget(
          text: taskTimeLineModel.milestone?.title ?? "",
          color: R.color.blackColor,
        ),
      ],
    );
  }
}
