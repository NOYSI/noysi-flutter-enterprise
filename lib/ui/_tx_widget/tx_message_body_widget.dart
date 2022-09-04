import 'package:cached_network_image/cached_network_image.dart';
import 'package:code/_di/injector.dart';
import 'package:code/_res/R.dart';
import 'package:code/data/file_cache_manager.dart';
import 'package:code/domain/message/message_model.dart';
import 'package:code/domain/team/team_model.dart';
import 'package:code/global_regexp.dart';
import 'package:code/ui/_tx_widget/tx_html_widget.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/home/tx_anwer_message_widget.dart';
import 'package:code/utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../data/api/remote/endpoints.dart';
import '../../domain/meet/meeting_model.dart';
import '../../enums.dart';
import '../_base/bloc_global.dart';

class TXMessageBodyWidget extends StatelessWidget {
  final MessageModel message;
  final ValueChanged<String>? onLinkTap;
  final Function()? onTapAnswerInMessage;
  final bool showLinksPreview;

  const TXMessageBodyWidget({
    Key? key,
    required this.message,
    this.onLinkTap,
    this.onTapAnswerInMessage,
    this.showLinksPreview = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getMessageHtmlContent(message);
  }

  Widget _getMessageHtmlContent(MessageModel messageModel) {
    String msg = messageModel.text.isNotEmpty == true
        ? messageModel.text
        : messageModel.html ?? "";

    //Iterable<RegExpMatch> matches = GlobalRegexp.urlExp.allMatches(msg.toLowerCase());
    final linksData = messageModel.extra
        .where((element) =>
            element.type.trim().toLowerCase() == MessageExtraTypes.link.name)
        .toList();
    return (msg.trim().isEmpty)
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              messageModel.hasAnswerMessage
                  ? TXAnswerMessageWidget(
                      fromMessageBody: true,
                      answerInMessageModel: messageModel.answerMessage,
                      onTap: onTapAnswerInMessage,
                    )
                  : Container(),
              TXHtmlWidget(
                key: ObjectKey(messageModel),
                onLinkTap: (link) {
                  if (kDebugMode) {
                    print(link);
                  }
                  if (onLinkTap != null && link.trim().isNotEmpty) {
                    onLinkTap!(link);
                  }
                },
                shrinkWrap: true,
                style: {
                  "div.body-local-mobile": Style(
                      color:
                          (messageModel.messageStatus == MessageStatus.Sent ||
                                  messageModel.messageStatus ==
                                      MessageStatus.Updated)
                              ? R.color.primaryDarkColor
                              : R.color.grayLightColor,
                      fontSize: const FontSize(20)),
                  ".link-mention": Style(
                      color: R.color.secondaryColor,
                      fontWeight: FontWeight.bold,
                      textDecoration: TextDecoration.none),
                  "a": Style(
                      color: R.color.secondaryColor,
                      textDecoration: TextDecoration.none),
                  ".file-new-comment": Style(
                      color: R.color.grayColor,
                      textDecoration: TextDecoration.none,
                      fontSize: FontSize.large),
                  ".file-new-comment-title": Style(
                      color: R.color.secondaryColor,
                      textDecoration: TextDecoration.none,
                      fontSize: FontSize.large),
                  ".mention-generic": Style(
                      color: R.color.secondaryColor,
                      fontWeight: FontWeight.bold,
                      textDecoration: TextDecoration.none),
                  ".message-edited-local-mobile": Style(
                      color: R.color.grayDarkColor,
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.medium),
                  ".partial-message-bold-text": Style(
                    fontWeight: FontWeight.bold,
                  ),
                  ".partial-message-italics-text":
                      Style(fontStyle: FontStyle.italic),
                  ".partial-message-code-text": Style(
                    backgroundColor: R.color.grayLightestColor,
                    border: Border.all(
                      color: R.color.grayLightColor,
                      width: .5,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    margin: const EdgeInsets.only(bottom: 5),
                    display: Display.BLOCK,
                  ),
                  ".partial-message-preformatted-text": Style(
                    backgroundColor: R.color.grayLightestColor,
                    margin: const EdgeInsets.only(bottom: 5),
                    border: Border.all(
                      color: R.color.grayLightColor,
                      width: .5,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    display: Display.BLOCK,
                  ),
                  ".partial-message-strike-text": Style(
                    textDecoration: TextDecoration.lineThrough,
                  ),
                  "p, body": Style(margin: EdgeInsets.zero)
                },
                body: _getMessageText(messageModel),
              ),
              messageModel.hasYoutubeVideos
                ? _getYoutubePreview(messageModel.getYoutubeLinks.first)
                : Container(),
              linksData.isNotEmpty && showLinksPreview
                  ? _getLinkPreviewWidget(linksData)
                  : Container()
            ],
          );
  }

  String _getMessageText(MessageModel messageModel) {
    String part1 = "<div class =\"body-local-mobile\">";
    String part2 = messageModel.parsedMessage;
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
    } else if (messageModel.hasAnswerMessage) {
      part2 = messageModel.getAnswerMessageContent;
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
          "<div class =\"file-new-comment\">${R.string.newFileComment}</div> <a href=\"#file-comment\" class =\"file-new-comment-title\">${messageModel.args?.title ?? ""}</a> ${messageModel.html}";
    }
    part2 = _getRichTexts(part2);
    return "$part1$part2${_getMessageEditedText(messageModel)}$part3";
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

  String _getMessageEditedText(MessageModel messageModel) {
    return messageModel.isThreadDeletedMessage
        ? "<span class =\"message-edited-local-mobile\">${" (${R.string.removed}) "}</span>"
        : (messageModel.edited?.millisecondsSinceEpoch != null &&
                messageModel.edited!.millisecondsSinceEpoch > 0 == true)
            ? "<span class =\"message-edited-local-mobile\">${" (${R.string.edited}) "}</span>"
            : "";
  }

  Widget _getYoutubePreview(String link) {
    final id = link.toLowerCase().contains("youtu.be") ? link.split("/").last.trim() : link.split("v=").last.split("&").first;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: YoutubePlayerIFrame(
        controller: YoutubePlayerController(
          initialVideoId: id,
          params: const YoutubePlayerParams(
            showControls: true,
            showFullscreenButton: true,
          ),
        ),
        aspectRatio: 16 / 9,
      ),
    );
  }

  Widget _getLinkPreviewWidget(List<MessageExtraModel> extras) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...extras
            .map((e) => InkWell(
                  onTap: () async {
                    if (e.type.trim().toLowerCase() ==
                        MessageExtraTypes.link.name) {
                      if (e.url?.isNotEmpty == true) {
                        appLinksContentController.sinkAddSafe(AppLinksNavigationModel(link: e.url!));
                      } else if (e.providerUrl?.isNotEmpty == true &&
                          (await canLaunchUrlString(e.providerUrl!))) {
                        launchUrlString(e.providerUrl!);
                      }
                    } else if (e.type.trim().toLowerCase() ==
                        MessageExtraTypes.rich.name) {}
                  },
                  child: Card(
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    margin: const EdgeInsets.only(top: 8),
                    elevation: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              e.thumbnailUrl?.isNotEmpty == true
                                  ? CachedNetworkImage(
                                      imageUrl: e.thumbnailUrl!,
                                      cacheManager: FileCacheManager.instance,
                                      memCacheWidth: 80,
                                      width: 80,
                                    )
                                  : Container(),
                              e.thumbnailUrl?.isNotEmpty == true
                                  ? const SizedBox(
                                      width: 5,
                                    )
                                  : Container(),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TXTextWidget(
                                        text: e.providerName?.isNotEmpty == true
                                            ? e.providerName!
                                            : R.string.noTitle,
                                        color: R.color.secondaryColor,
                                        fontWeight: FontWeight.bold),
                                    TXTextWidget(
                                      text: e.title?.isNotEmpty == true
                                          ? e.title!
                                          : R.string.noTitle,
                                      color: R.color.blackColor,
                                      fontWeight: FontWeight.bold,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          e.description?.isNotEmpty == true
                              ? const Divider()
                              : Container(),
                          e.description?.isNotEmpty == true
                              ? TXTextWidget(
                                  text: e.description!,
                                  color: R.color.blackColor,
                                  maxLines: 4,
                                  size: 14,
                                  textOverflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify)
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ))
            .toList()
      ],
    );
  }

// Widget _getLinkPreviewWidget(String msg) {
//   Iterable<RegExpMatch> matches = GlobalRegexp.urlExp.allMatches(msg.toLowerCase());
//
//   return Column(
//     children: [
//       ...matches.map((e) => Container(
//         margin: EdgeInsets.only(top: 8),
//         child: InkWell(
//           onTap: () {
//             launch(e.group(0).toLowerCase());
//           },
//           child: FlutterLinkPreview(
//             url: e.group(0)
//                 .toLowerCase(),
//             bodyStyle: TextStyle(
//               color: R.color.blackColor,
//             ),
//             titleStyle: TextStyle(
//               color: R.color.secondaryColor,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       )).toList()
//     ],
//   );
// }

// Widget _getMessageContent() {
//   String text = message?.edited?.millisecondsSinceEpoch != null &&
//           message.edited.millisecondsSinceEpoch > 0 == true
//       ? "${message.text} ${R.string.edited}"
//       : message.text;
//
//   String strNum = "This string has numbers 123456 and 78910";
//   final iReg = RegExp(r'(\^d+)');
//   print(iReg.allMatches(strNum).map((m) => m.group(0)).join(' '));
//
//   return ParsedText(
//     text: text,
//     parse: [
//       MatchText(
//           type: ParsedType.EMAIL,
//           style: TextStyle(
//             color: Colors.red,
//             fontSize: 24,
//           ),
//           onTap: (url) {
//             launch("mailto:" + url);
//           }),
//       MatchText(
//           type: ParsedType.URL,
//           style: TextStyle(
//             color: Colors.blue,
//             fontSize: 24,
//           ),
//           onTap: (url) async {
//             launch(url);
//             // print("can launch $url");
//             // var a = await canLaunch(url);
//             // print("can launch $a");
//             // if (a) {
//             //   launch(url);
//             // }
//           }),
//       MatchText(
//           type: ParsedType.PHONE,
//           style: TextStyle(
//             color: Colors.purple,
//             fontSize: 24,
//           ),
//           onTap: (url) {
//             launch("tel:" + url);
//           }),
//       MatchText(
//           pattern: r"^(?:[+0]9)?[0-9]{10}$",
//           style: TextStyle(
//             color: Colors.green,
//             fontSize: 24,
//           ),
//           renderText: ({String str, String pattern}) {
//             Map<String, String> map = Map<String, String>();
//             RegExp customRegExp = RegExp(pattern);
//             Match match = customRegExp.firstMatch(str);
//             map['display'] = match.group(1);
//             map['value'] = match.group(2);
//             return map;
//           },
//           onTap: (url) {
//             launch("tel:" + url);
//           })
//     ],
//     style: TextStyle(
//         color: (message.messageStatus == MessageStatus.Sent ||
//                 message.messageStatus == MessageStatus.Updated)
//             ? R.color.darkColor
//             : R.color.grayLightColor,
//         fontSize: 17),
//   );
// }
}
