import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:scriptkill/base/app_assets.dart';
import 'package:scriptkill/base/app_color.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scriptkill/base/app_layout.dart';
import 'package:scriptkill/base/app_routes.dart';
import 'package:scriptkill/base/app_user.dart';
import 'package:scriptkill/pages/login/page_login.dart';
import 'package:scriptkill/stores/user_store.dart';
import 'package:scriptkill/util/router/router.dart';
import 'package:scriptkill/util/util_storage.dart';
import 'package:scriptkill/widgets/app_guide_page.dart';

import 'base/app_tabbar.dart';
import 'util/util_router.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        child: MaterialApp(
      navigatorKey: navGK,
      debugShowCheckedModeBanner: false,
      title: '剧本杀',
      theme: ThemeData(
          primaryColor: AppColor.themeColor,
          accentColor: AppColor.themeColor,
          scaffoldBackgroundColor: AppColor.themeColor),
      onGenerateRoute: AppRouter().router.generator,
      home: SplashPage(),
    ));
  }
}

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(new Duration(seconds: 1), () {
      String key = "has_show_guide_5";
      var isGuide = AppStorage.getBool(key);
      var isInit = AppStorage.isInitialized();
      if ((isInit != false) && (isGuide == false)) {
        AppStorage.putBool(key, true);
        // routeFadePush(GuidePage());
        AppRouter().navigateTo(context, PageNames.guide.toString(),
            transition: TransitionType.fadeIn, clearStack: true);
      } else if (AppUser.isLogin() == true) {
        // routeFadePush(AppTabbar());
//  AppRouter().navigateTo(context, PageNames.tabbar.toString(),
//             transition: TransitionType.fadeIn, clearStack: true);
        AppUser.userLogin(context);
      } else {
        // routeFadePush(LoginPage());
        AppUser.userExit(context);
        // AppRouter().navigateTo(context, PageNames.login.toString(),
        //     transition: TransitionType.fadeIn, clearStack: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AppAsset.splash,
        fit: BoxFit.cover,
        width: AppLayout.screenWidth,
        height: AppLayout.screenHeight,
      ),
    );
  }
}
