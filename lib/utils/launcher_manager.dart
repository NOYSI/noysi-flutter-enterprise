
import 'package:url_launcher/url_launcher_string.dart';

class LauncherManager {
  static void launchApp(String scheme) async {
    try {
//      print('Trying to launch: $scheme');
      if (await canLaunchUrlString(scheme)) await launchUrlString(scheme);
    } catch (ex) {
      print('Launch App exception');
      print(ex);
    }
  }
}
