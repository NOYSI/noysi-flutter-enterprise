

import 'package:flutter_emoji/flutter_emoji.dart';

import '../global_regexp.dart';

class TextUtilsParser {
  static String getRichTexts(String text,
      {bool useHtmlTags = false, bool antiPattern = false}) {
    String resultText = text;

    resultText = text.replaceAllMapped(GlobalRegexp.strikeExp, (match) {
      final part1 = useHtmlTags
          ? "<strike>"
          : "<span class = \"partial-message-strike-text\">";
      final part2 = match.input.substring(match.start + 1, match.end - 1);
      final part3 = useHtmlTags ? "</strike>" : "</span>";
      return antiPattern ? part2 : "$part1$part2$part3";
    });

    resultText =
        resultText.replaceAllMapped(GlobalRegexp.preformattedExp, (match) {
      final part1 = useHtmlTags
          ? "<code>"
          : "<span class = \"partial-message-preformatted-text\">";
      final part2 = match.input.substring(match.start + 3, match.end - 3);
      final part3 = useHtmlTags ? "</code>" : "</span>";
      return antiPattern ? part2 : "$part1$part2$part3";
    });

    resultText = resultText.replaceAllMapped(GlobalRegexp.codeExp, (match) {
      final part1 = useHtmlTags
          ? "<code>"
          : "<span class = \"partial-message-code-text\">";
      final part2 = match.input.substring(match.start + 1, match.end - 1);
      final part3 = useHtmlTags ? "</code>" : "</span>";
      return antiPattern ? part2 : "$part1$part2$part3";
    });

    resultText = resultText.replaceAllMapped(GlobalRegexp.boldExp, (match) {
      final part1 =
          useHtmlTags ? "<b>" : "<span class = \"partial-message-bold-text\">";
      final part2 = match.input.substring(match.start + 1, match.end - 1);
      final part3 = useHtmlTags ? "</b>" : "</span>";
      return antiPattern ? part2 : "$part1$part2$part3";
    });

    resultText = resultText.replaceAllMapped(GlobalRegexp.italicsExp, (match) {
      final part1 = useHtmlTags
          ? "<i>"
          : "<span class = \"partial-message-italics-text\">";
      final part2 = match.input.substring(match.start + 1, match.end - 1);
      final part3 = useHtmlTags ? "</i>" : "</span>";
      return antiPattern ? part2 : "$part1$part2$part3";
    });

    return resultText;
  }

  static String emojiParser(String text, {bool removeUploadedFilesExpression = true}) {
    var emojiParser = EmojiParser();
    return removeUploadedFilesExpression ? emojiParser.emojify(text).replaceAllMapped(
        GlobalRegexp.uploadedFile, (match) => match.group(1)!) : emojiParser.emojify(text);
  }

  static String emojiParserFromHex(List<String> chain) {
    try {
      return String.fromCharCodes(
          chain.map((e) => int.tryParse(e, radix: 16)!).toList());
    } catch (ex) {
      return chain.join();
    }
  }
}
