import 'package:scriptkill/base/app_config.dart';

class AppUrl {
  static apiUrl(String path) {
    return (AppConfig.isDebug
            ? AppConfig.debugHost + "/get"
            : AppConfig.baseHost) +
        path;
  }

  static String login = apiUrl('/login');
  static String userInfo = apiUrl('/userInfo');
}
