import 'package:scriptkill/base/app_config.dart';

String splashfunc(String name) => AppConfig.assetsSplash + name;

String tabfunc(String name) => AppConfig.assetsTabbar + name;

String logofunc(String name) => AppConfig.assetsLogo + name;

String guidefunc(String name) => AppConfig.assetsGuide + name;

String imagesfunc(String name) => AppConfig.assetsImages + name;

class AppAsset {
// splash
  static String splash = splashfunc("splash.jpg");

// logo
  static String logo = logofunc("logo.png");

// guide
  static String guide_1 = guidefunc("guide_1.jpg");
  static String guide_2 = guidefunc("guide_2.jpg");
  static String guide_3 = guidefunc("guide_3.jpg");

// tabbar
  static String tabbar_home = tabfunc("tabbar_home.svg");
  static String tabbar_script = tabfunc("tabbar_script.svg");
  static String tabbar_mine = tabfunc("tabbar_mine.svg");

//images
  //arrow
  static String arrow_right_list = imagesfunc("arrow_right_list.png");
  static String add_photo = imagesfunc("add_photo.png");
  static String default_headImage = imagesfunc("default_headImage.png");
  static String default_loading_image = imagesfunc("default_loading_image.png");
  static String waiting = imagesfunc("waiting.jpg");
  static String go_back = imagesfunc("go_back.png");
  static String favorite = imagesfunc("favorite.png");
  static String search = imagesfunc("search.png");
  static String xingbienv = imagesfunc("xingbienv.png");
  static String sexangle_1 = imagesfunc("sexangle_1.png");
  static String sexangle_2 = imagesfunc("sexangle_2.png");
  static String sexangle_3 = imagesfunc("sexangle_3.png");
  static String zan = imagesfunc("zan.png");
}
