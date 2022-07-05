import 'package:code/_res/R.dart';
import 'package:code/_res/values/config.dart';
import 'package:code/domain/task/task_model.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/task/tx_label_widget.dart';
import 'package:code/utils/calendar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:collection/collection.dart';

class TXTaskItemWidget extends StatelessWidget {
  final TaskModel taskModel;
  final Function()? onTap;

  const TXTaskItemWidget({
    Key? key,
    required this.taskModel,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isOpen = taskModel.isOpen;
    return InkWell(
      onTap: onTap,
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: taskModel.title));
        Fluttertoast.showToast(
            msg: R.string.copiedToClipboard,
            toastLength: Toast.LENGTH_LONG,
            textColor: R.color.whiteColor,
            backgroundColor: R.color.primaryColor);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              isOpen ? Icons.warning : Icons.check_circle_outline,
              color: isOpen ? Colors.orangeAccent : R.color.secondaryColor,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            TXNetworkImage(
              width: 40,
              height: 40,
              forceLoad: true,
              boxFitImage: BoxFit.cover,
              shape: BoxShape.rectangle,
              placeholderImage: Image.asset(R.image.logo),
              imageUrl: taskModel.participants.firstWhereOrNull(
                  (element) => element.uid == taskModel.uid)?.photo ?? '',
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TXTextWidget(
                          text: taskModel.title,
                          color: R.color.blackColor,
                          maxLines: 3,
                        ),
                      ),
                      taskModel.comments > 0
                          ? Row(
                              children: <Widget>[
                                Icon(
                                  Icons.comment,
                                  size: 14,
                                  color: R.color.grayColor,
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                                TXTextWidget(
                                  text: taskModel.comments.toString(),
                                  color: R.color.grayColor,
                                  size: 14,
                                )
                              ],
                            )
                          : Container()
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      TXTextWidget(
                        fontWeight: FontWeight.w300,
                        size: 14,
                        text: AppConfig.locale == AppLocale.ES
                            ? "${R.string.taskOpened} ${R.string.ago} ${CalendarUtils.getFancyTime(taskModel.created!)} ${R.string.by}"
                            : "${R.string.taskOpened} ${CalendarUtils.getFancyTime(taskModel.created!)} ${R.string.ago} ${R.string.by}",
                      ),
                      TXTextWidget(
                        text:
                            " @${taskModel.participants.firstWhereOrNull((element) => element.uid == taskModel.uid)?.name}",
                        color: R.color.secondaryColor,
                        fontWeight: FontWeight.w300,
                        size: 14,
                      )
                    ],
                  ),
                  _getDeliveryDate(),
                  _getMilestone(),
                  _getLabels()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDeliveryDate() {
    return taskModel.due == null
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.today,
                    color: R.color.grayColor,
                    size: 15,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  TXTextWidget(
                    text:
                        "${R.string.deliveryDateIn} ${CalendarUtils.getFancyTime(taskModel.due!.toLocal())}",
                    fontWeight: FontWeight.w300,
                    size: 14,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  CircleAvatar(
                    backgroundColor: R.color.grayLightColor,
                    radius: 2,
                  )
                ],
              ),
            ],
          );
  }

  Widget _getMilestone() {
    return (taskModel.milestone == null)
        ? Container()
        : Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.flag,
                    color: R.color.primaryColor,
                    size: 15,
                  ),
                  TXTextWidget(
                    text: taskModel.milestone?.title ?? '',
                    fontWeight: FontWeight.w500,
                    color: R.color.primaryColor,
                    size: 14,
                  )
                ],
              ),
            ],
          );
  }

  Widget _getLabels() {
    if (taskModel.labels.isNotEmpty == true) {
      List<Widget> list = [];
      taskModel.labels.forEach((element) {
        final w = TXLabelWidget(
          taskLabelModel: element,
        );
        list.add(w);
      });
      return Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: <Widget>[...list],
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
