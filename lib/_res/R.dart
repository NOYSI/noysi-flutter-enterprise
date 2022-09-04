import 'package:code/_res/values/colors.dart';
import 'package:code/_res/values/constants.dart';
import 'package:code/_res/values/dimens.dart';
import 'package:code/_res/values/images.dart';
import 'package:code/_res/values/sounds.dart';
import 'package:code/_res/values/text/custom_localizations_delegate.dart';
import 'package:code/_res/values/text/strings_base.dart';

class R {
  static StringsBase get string => CustomLocalizationsDelegate.stringsBase;
  static final AppImage image = AppImage();
  static final AppDimens dim = AppDimens();
  static final AppColor color = AppColor();
  static final Constants cons = Constants();
  static final AppSounds sound = AppSounds();
}
