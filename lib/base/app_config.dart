class AppConfig {
  static const bool isDebug = true;
  static const String baseHost = 'http://212.64.95.5:8080/hrlweibo/';
  static const String debugHost =
      'http://rap2.taobao.org:38080/app/mock/264390';
  // assets
  static const String assetsLogo = 'assets/logo/';
  static const String assetsSplash = 'assets/splash/';
  static const String assetsGuide = 'assets/guide/';
  static const String assetsTabbar = 'assets/tabbar/';
  static const String assetsImages = 'assets/images/';

  //微信
  static const String key_wechat_appid = 'wx88b4bb53bcd4405d';
  static const String key_wechat_secret = 'efbb6ecdd93d9e5f9fcc1fd678b87b6e';
  static const String key_wechat_universalLink = 'https://ssl.ehomecare.cn/';

  // user store
  static const String userCacheHeadKey = 'app_user';

  // 网络图
  static imageUrl(String imagename) {
    return (isDebug ? debugHost : baseHost) + imagename;
  }

  // 本地图
  static assetPath(String imagename) {
    return assetsImages + imagename;
  }
}
