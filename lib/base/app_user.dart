import 'package:fluro/fluro.dart';
import 'package:scriptkill/base/app_routes.dart';
import 'package:scriptkill/base/app_url.dart';
import 'package:scriptkill/stores/user_store.dart';
import 'package:scriptkill/util/util_api.dart';
import 'package:scriptkill/util/util_router.dart';
import 'package:scriptkill/util/util_storage.dart';
import 'package:scriptkill/model/UserModel.dart';

// 全局的 user store

// 硬盘和内存用户数据缓存的管理类
class AppUser {
  static UserStore userStore = UserStore();
  // other
  static const String key_userinfo_storage = "userinfo_storage";
  // sys
  static const String key_is_login = "is_login";
  // user Info key
  static const String key_openid = "openid";
  static const String key_unionid = "unionid";

  static const String key_headimgurl = "headimgurl";
  static const String key_nickname = "nickname";
  static const String key_decs = "decs";
  static const String key_sex = "sex";
  static const String key_age = "age";

  static const String key_id = "id";
  static const String key_level = "level";
  static const String key_honor = "honor";

  // address
  static const String key_country = "country";
  static const String key_province = "province";
  static const String key_city = "city";

  // 保存用户个人信息
  static Future<User> saveUserInfo(Map data) async {
    if (data != null) {
      User userInfo = User.fromJson(data);
      await AppStorage.putObject(key_userinfo_storage, userInfo);
      await AppStorage.putBool(key_is_login, true);
      userStore.updataUser(userInfo);
      return userInfo;
    }
    return null;
  }

  /// 获取用户本地个人信息
  static User getUserLocalInfo() {
    bool isLogin = AppStorage.getBool(key_is_login);
    if (isLogin == null || !isLogin) {
      return User();
    }
    Map data = AppStorage.getObject(key_userinfo_storage);
    User userInfo = User.fromJson(data);
    return userInfo;
  }

  /// 同步及获取用户后台个人信息
  static User syncNetworkUserInfo() {
    // AppApi().get(AppUrl.userInfo, {"token": ""}, (data) {
    //   print(data);
    //   Map userinfo = data["result"]["userInfo"];
    //   return saveUserInfo(userinfo);
    // });
    return null;
  }

  /// 用户是否已登录
  static bool isLogin() {
    bool b = AppStorage.getBool(key_is_login);
    return b != null && b;
  }

  /// 用户登录 App
  static userLogin(context) {
    AppRouter().navigateTo(context, PageNames.tabbar.toString(),
        transition: TransitionType.fadeIn, clearStack: true);
    // syncNetworkUserInfo();
  }

  /// 用户退出 App
  static userExit(context) {
    AppStorage.putBool(key_is_login, false);
    AppStorage.putObject(key_userinfo_storage, null);
    AppUser.userStore.updataUser(User());
    AppRouter().navigateTo(context, PageNames.login.toString(),
        transition: TransitionType.fadeIn, clearStack: true);
  }

  // 保存用户头像
  static saveUserHeadUrl(String mUrl) async {
    await AppStorage.putString(key_headimgurl, mUrl);
  }

  static saveUserNick(String mUrl) async {
    await AppStorage.putString(key_nickname, mUrl);
  }

  static saveUserDesc(String mUrl) async {
    await AppStorage.putString(key_decs, mUrl);
  }
}
