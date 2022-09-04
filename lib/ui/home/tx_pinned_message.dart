import 'package:code/enums.dart';
import 'package:flutter/material.dart';
import '../../_res/R.dart';
import '../../domain/message/message_model.dart';
import '../_base/richtext_widgets/tx_task_notification_header_info_widget.dart';
import '../_tx_widget/tx_message_body_widget.dart';
import '../_tx_widget/tx_network_image.dart';
import '../_tx_widget/tx_text_widget.dart';

class TXPinnedMessage extends StatelessWidget {
  final MessageModel pinnedMessage;
  final Function()? onTap;
  final Function()? onLongPress;

  const TXPinnedMessage(
      {super.key, required this.pinnedMessage, this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    pinnedMessage.messageStatus = MessageStatus.Sent;
    final widget = pinnedMessage.parsedMessage.isNotEmpty
        ? TXMessageBodyWidget(
            message: pinnedMessage,
            showLinksPreview: false,
          )
        : pinnedMessage.isFile
            ? Row(
                children: [
                  TXNetworkImage(
                    forceLoad: true,
                    boxFitImage: BoxFit.cover,
                    mimeType: pinnedMessage.fileModel?.mimeType ?? "",
                    width: 20,
                    userBorderRadius: false,
                    height: 20,
                    imageUrl: pinnedMessage.fileModel?.link ?? "",
                    placeholderImage: Image.asset(
                      pinnedMessage.fileModel?.mimeType.startsWith("image") ==
                              true
                          ? R.image.imageDefaultIcon
                          : R.image.logo,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TXTextWidget(
                      text: pinnedMessage.fileModel?.titleFixed ?? "",
                      color: R.color.secondaryColor)
                ],
              )
            : pinnedMessage.isTaskNotification
                ? TXTaskNotificationHeaderInfoWidget(
                    messageModel: pinnedMessage,
                  )
                : pinnedMessage.isFolderShareMessage ||
                        pinnedMessage.isFolderUploadMessage
                    ? Row(
                        children: [
                          Image.asset(
                            R.image.folder,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TXTextWidget(
                              text:
                                  _getFixedPath(pinnedMessage.args?.path ?? "")
                                      .split('/')
                                      .last)
                        ],
                      )
                    : Container();
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        margin: EdgeInsets.zero,
        child: Container(
          constraints: const BoxConstraints(maxHeight: 52),
          padding: const EdgeInsets.all(5).copyWith(left: 10),
          child: IntrinsicHeight(
            child: Wrap(
              clipBehavior: Clip.antiAlias,
              direction: Axis.horizontal,
              runSpacing: 2,
              children: [
                TXTextWidget(
                  text: R.string.pinnedMessage,
                  color: R.color.secondaryHeaderColor,
                  size: 16,
                ),
                widget,
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getFixedPath(String path) => path.trim().endsWith('/')
      ? path.trim().replaceRange(path.length - 1, path.length, '')
      : path.trim();
}
