import 'package:code/utils/text_parser_utils.dart';
import 'package:flutter/material.dart';

import '../data/api/remote/remote_constants.dart';

class EmojiRichText extends StatelessWidget {
  const EmojiRichText({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    required this.maxLines,
    this.locale,
    this.emojiChainText = const [],
    this.strutStyle,
    //this.emojiFontFamily = 'EmojiOne',
    this.fontSize = 15,
    this.fontWeight = FontWeight.normal,
    this.color,
  })  : assert(text != null),
        assert(maxLines == null || maxLines > 0),
        super(key: key);

  final bool softWrap;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final String? text;
  final double textScaleFactor;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  //final String emojiFontFamily;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      locale: locale,
      strutStyle: strutStyle,
      text: _buildText(this.text!),
    );
  }

  static String getText(String text) {
    final children = <String>[];
    final runes = text.runes;
    for (int i = 0; i < runes.length; /* empty */) {
      int current = runes.elementAt(i);
      final isEmoji = current > 255;
      final shouldBreak = isEmoji ? (x) => x <= 255 : (x) => x > 255;

      final chunk = <int>[];
      while (!shouldBreak(current)) {
        chunk.add(current);
        if (++i >= runes.length) break;
        current = runes.elementAt(i);
      }
      children.add(String.fromCharCodes(chunk));
      return children.join();
    }
    return text;
  }

  TextSpan _buildText(String text) {
    final children = <TextSpan>[];
    final runes = text.runes;
    for (int i = 0; i < runes.length; /* empty */) {
      int current = runes.elementAt(i);
      final isEmoji = current > 255;
      final shouldBreak = isEmoji ? (x) => x <= 255 : (x) => x > 255;

      final chunk = <int>[];
      while (!shouldBreak(current)) {
        chunk.add(current);
        if (++i >= runes.length) break;
        current = runes.elementAt(i);
      }
      children.add(
        TextSpan(
          text: String.fromCharCodes(chunk),
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: RemoteConstants.fontFamily//isEmoji ? emojiFontFamily : RemoteConstants.fontFamily,
          ),
        ),
      );
    }
    if (emojiChainText?.isNotEmpty == true) {
      children.add(TextSpan(
        text: TextUtilsParser.emojiParserFromHex(emojiChainText!),
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: RemoteConstants.fontFamily//emojiFontFamily,
        ),
      ));
    }
    return TextSpan(children: children);
  }

  final List<String>? emojiChainText;

  EmojiRichText.withEmojiChain(
      {Key? key,
      required this.text,
      required this.emojiChainText,
      this.textAlign = TextAlign.start,
      this.softWrap = true,
      this.overflow = TextOverflow.clip,
      this.textScaleFactor = 1.0,
      this.maxLines,
      this.locale,
      this.strutStyle,
      //this.emojiFontFamily = 'EmojiOne',
      this.fontSize = 15,
      this.fontWeight = FontWeight.normal,
      this.color})
      : assert(text != null),
        assert(emojiChainText != null && emojiChainText.length > 0),
        assert(maxLines == null || maxLines > 0),
        super(key: key);
}
