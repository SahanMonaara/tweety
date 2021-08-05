

import 'package:package_info/package_info.dart';

import 'app_constants.dart';

class StringUtils {
  static String enumName(String enumToString) {
    List<String> paths = enumToString.split(".");
    return paths[paths.length - 1];
  }

  static void getApplicationVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionName = packageInfo.version;
    String versionCode = packageInfo.buildNumber;
    AppConstants.appVersion = versionName;

    ///if needed for check
    // print('[App Version $versionName]');
    print('[App Version $versionCode]');
  }
}
