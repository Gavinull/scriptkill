import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scriptkill/base/app_routes.dart';
import 'package:scriptkill/app.dart';
import 'package:scriptkill/base/app_user.dart';
import 'package:scriptkill/base/app_wechat.dart';
import 'package:scriptkill/stores/user_store.dart';
import 'package:scriptkill/util/util_storage.dart';

import 'base/app_color.dart';
import 'base/app_config.dart';
import 'util/util_api.dart';
// * Store
// import 'package:scriptkill/stores/findStore.dart';
// import 'package:scriptkill/stores/loginStore.dart';
// import 'package:scriptkill/stores/homeStore.dart';

void main() {
  // 修改系统状态栏颜色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: AppColor.themeColor,
    statusBarColor: Colors.transparent,
  ));
  // 提前初始化
  WidgetsFlutterBinding.ensureInitialized();
  AppStorage.getInstance();
  // 微信
  AppWechat.setup();

  //网络 baseUrl
  String baseUrl = AppConfig.isDebug ? AppConfig.debugHost : AppConfig.baseHost;
  AppApi().client.options.baseUrl = baseUrl;

  // 路由初始化
  initRoutes();

  // 启动App
  final providers = [
    Provider<UserStore>(create: (_) => AppUser.userStore),
  ];
  runApp(MultiProvider(providers: providers, child: App()));
}
