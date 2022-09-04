import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/ui/_tx_widget/tx_html_widget.dart';
import 'package:code/ui/_tx_widget/tx_network_image.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/home/tx_folder_notification_widget.dart';
import 'package:code/ui/home/tx_task_notification_widget.dart';
import 'package:code/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

import '../../global_regexp.dart';

class TXAnswerMessageWidget extends StatelessWidget {
  final bool showCloseOption;
  final Function()? onCloseAnswerInMessage;
  final MessageModel? answerInMessageModel;
  final bool fromMessageBody;
  final GestureTapCallback? onTap;

  const TXAnswerMessageWidget(
      {Key? key,
      this.showCloseOption = false,
      this.fromMessageBody = false,
      this.onCloseAnswerInMessage,
      this.answerInMessageModel,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageAvailable = answerInMessageModel?.tid == Injector.instance.inMemoryData.currentTeam!.id;
    return answerInMessageModel == null
        ? Container()
        : Material(
            child: InkWell(
              onTap: () {
                if(messageAvailable && onTap != null) {
                  onTap!();
                }
              },
              child: Container(
                constraints: const BoxConstraints(maxHeight: 200),
                padding: fromMessageBody
                    ? const EdgeInsets.only(bottom: 5, top: 5)
                    : const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 5),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    decoration: BoxDecoration(
                        color: R.color.secondaryColor,
                        borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      color: R.color.grayLightestColor,
                      child: messageAvailable ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: TXTextWidget(
                                    text: CommonUtils.getMemberUsername(
                                            Injector.instance.inMemoryData
                                                .getMember(answerInMessageModel!
                                                    .uid)) ??
                                        '',
                                    color: R.color.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              showCloseOption
                                  ? InkWell(
                                      onTap: onCloseAnswerInMessage,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(right: 5, top: 5),
                                        child: Icon(
                                          Icons.close,
                                          color: R.color.blackColor,
                                          size: 15,
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          Container(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 5, right: 5),
                              child: Row(
                                children: [
                                  answerInMessageModel!.isFile
                                      ? TXNetworkImage(
                                          forceLoad: true,
                                          boxFitImage: BoxFit.cover,
                                          mimeType: answerInMessageModel!
                                              .fileModel!.mimeType,
                                          width: 40,
                                          height: 60,
                                          imageUrl: answerInMessageModel!
                                                  .fileModel!.link ??
                                              "",
                                          placeholderImage: Image.asset(
                                            R.image.imageDefaultIcon,
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(
                                    width:
                                        answerInMessageModel!.isFile ? 5 : 0,
                                  ),
                                  Expanded(
                                    child: answerInMessageModel!
                                            .isTaskNotification
                                        ? TXTaskNotificationWidget(
                                            messageModel:
                                                answerInMessageModel!,
                                          )
                                        : answerInMessageModel!
                                                    .isFolderShareMessage ||
                                                answerInMessageModel!
                                                    .isFolderUploadMessage
                                            ? TXFolderNotificationWidget(
                                                message:
                                                    answerInMessageModel!)
                                            : TXHtmlWidget(
                                                shrinkWrap: true,
                                                style: {
                                                  "div.body-local-mobile":
                                                      Style(
                                                          color: R.color
                                                              .grayDarkColor,
                                                          fontSize:
                                                              const FontSize(16)),
                                                  ".link-mention": Style(
                                                      color: R.color
                                                          .secondaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      textDecoration:
                                                          TextDecoration
                                                              .none),
                                                  "a": Style(
                                                      color: R.color
                                                          .secondaryColor,
                                                      textDecoration:
                                                          TextDecoration
                                                              .none),
                                                  ".file-new-comment": Style(
                                                      color:
                                                          R.color.grayColor,
                                                      textDecoration:
                                                          TextDecoration.none,
                                                      fontSize:
                                                          FontSize.medium),
                                                  ".file-new-comment-title":
                                                      Style(
                                                          color: R.color
                                                              .secondaryColor,
                                                          textDecoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: FontSize
                                                              .medium),
                                                  ".mention-generic": Style(
                                                      color: R.color
                                                          .secondaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      textDecoration:
                                                          TextDecoration
                                                              .none),
                                                  ".message-edited-local-mobile":
                                                      Style(
                                                          color: R.color
                                                              .grayColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              FontSize.small),
                                                  ".partial-message-bold-text":
                                                      Style(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                                  ".partial-message-italics-text":
                                                      Style(
                                                          fontStyle: FontStyle
                                                              .italic),
                                                  ".partial-message-code-text":
                                                      Style(
                                                    backgroundColor: R.color
                                                        .grayLightestColor,
                                                    border: Border.all(
                                                      color: R.color
                                                          .grayLightColor,
                                                      width: .5,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    margin: const EdgeInsets.only(
                                                        bottom: 5),
                                                    display: Display.BLOCK,
                                                  ),
                                                  ".partial-message-preformatted-text":
                                                      Style(
                                                    backgroundColor: R.color
                                                        .grayLightestColor,
                                                    margin: const EdgeInsets.only(
                                                        bottom: 5),
                                                    border: Border.all(
                                                      color: R.color
                                                          .grayLightColor,
                                                      width: .5,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                    display: Display.BLOCK,
                                                  ),
                                                  ".partial-message-strike-text":
                                                      Style(
                                                    textDecoration:
                                                        TextDecoration
                                                            .lineThrough,
                                                  ),
                                                  "p, body": Style(
                                                      margin: EdgeInsets.zero)
                                                },
                                                body: _getMessageText(
                                                    answerInMessageModel!),
                                              ),
                                  )
                                ],
                              ))
                        ],
                      ) : Padding(
                        padding: EdgeInsets.all(5),
                        child: TXTextWidget(text: R.string.messageNotFound),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  String _getMessageText(MessageModel messageModel) {
    String part1 = "<div class =\"body-local-mobile\">";
    String part2 = answerInMessageModel == null
        ? ""
        : answerInMessageModel!.isFile
            ? answerInMessageModel!.fileModel!.titleFixed
            : answerInMessageModel!.getAnswerMessageContent;
    String part3 = "</div>";

    if (messageModel.isNoysiWelcomeMessageFirstName) {
      part2 = messageModel.getNoysiWelcomeMessageFirstName;
    } else if (messageModel.isNoysiWelcomeMessageLastName) {
      part2 = messageModel.getNoysiWelcomeMessageLastName;
    } else if (messageModel.isNoysiWelcomeMessageDescription) {
      part2 = messageModel.getNoysiWelcomeMessageDescription;
    } else if (messageModel.isNoysiWelcomeMessageInvite) {
      part2 = messageModel.getNoysiWelcomeMessageInvite;
    } else if (messageModel.isNoysiWelcomeMessageDownloads) {
      part2 = messageModel.getNoysiWelcomeMessageDownloads;
    } else if (messageModel.isNoysiWelcomeMessageTimeOut) {
      part2 = messageModel.getNoysiWelcomeMessageTimeoutContent;
    } else if (messageModel.isIntegrationMessage) {
      part2 = messageModel.getIntegrationMessageContent;
    } else if (messageModel.isChannelsMemberJoined) {
      part2 = messageModel.getChannelsMemberJoinedContent(
          Injector.instance.inMemoryData.getMember(messageModel.uid));
    } else if (messageModel.isChannelsMemberLeft) {
      part2 = messageModel.getChannelsMemberLeftContent(
          Injector.instance.inMemoryData.getMember(messageModel.uid));
    } else if (messageModel.isPinnedMessageNotification) {
      part2 = messageModel.getChannelMessagePinned(Injector.instance.inMemoryData.getMember(messageModel.uid));
    } else if (messageModel.isUnpinnedMessageNotification) {
      part2 = messageModel.getChannelMessageUnpinned(Injector.instance.inMemoryData.getMember(messageModel.uid));
    } else if (messageModel.isFileComment) {
      part2 =
          "<div class =\"file-new-comment\">${R.string.newFileComment}</div> <div class =\"file-new-comment-title\">${messageModel.args?.title ?? ""}</div> ${messageModel.html}";
    }
    part2 = _getRichTexts(part2);
    return "$part1$part2${_getMessageEditedText(messageModel)}$part3";
  }

  String _getMessageEditedText(MessageModel messageModel) {
    return (messageModel.edited?.millisecondsSinceEpoch != null &&
            (messageModel.edited!.millisecondsSinceEpoch > 0) == true)
        ? "<span class =\"message-edited-local-mobile\">${" (${R.string.edited}) "}</span>"
        : messageModel.isThreadDeletedMessage
            ? "<span class =\"message-edited-local-mobile\">${" (${R.string.removed}) "}</span>"
            : "";
  }

  String _getRichTexts(String text) {
    String resultText = text;

    resultText = text.replaceAllMapped(GlobalRegexp.strikeExp, (match) {
      const part1 = "<span class = \"partial-message-strike-text\">";
      final part2 = match.input.substring(match.start + 1, match.end - 1);
      const part3 = "</span>";
      return "$part1$part2$part3";
    });

    resultText =
        resultText.replaceAllMapped(GlobalRegexp.preformattedExp, (match) {
      const part1 = "<span class = \"partial-message-preformatted-text\">";
      final part2 = match.input.substring(match.start + 3, match.end - 3);
      const part3 = "</span>";
      return "$part1$part2$part3";
    });

    resultText = resultText.replaceAllMapped(GlobalRegexp.codeExp, (match) {
      const part1 = "<span class = \"partial-message-code-text\">";
      final part2 = match.input.substring(match.start + 1, match.end - 1);
      const part3 = "</span>";
      return "$part1$part2$part3";
    });

    resultText = resultText.replaceAllMapped(GlobalRegexp.boldExp, (match) {
      const part1 = "<span class = \"partial-message-bold-text\">";
      final part2 = match.input.substring(match.start + 1, match.end - 1);
      const part3 = "</span>";
      return "$part1$part2$part3";
    });

    resultText = resultText.replaceAllMapped(GlobalRegexp.italicsExp, (match) {
      const part1 = "<span class = \"partial-message-italics-text\">";
      final part2 = match.input.substring(match.start + 1, match.end - 1);
      const part3 = "</span>";
      return "$part1$part2$part3";
    });

    return resultText;
  }
}
