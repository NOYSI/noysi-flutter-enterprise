import 'dart:ui';

class HexColor {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color? fromHex(String hexString) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (ex) {
      return null;
    }
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  static String toHex(Color c, {bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${c.alpha.toRadixString(16).padLeft(2, '0')}'
      '${c.red.toRadixString(16).padLeft(2, '0')}'
      '${c.green.toRadixString(16).padLeft(2, '0')}'
      '${c.blue.toRadixString(16).padLeft(2, '0')}';
}