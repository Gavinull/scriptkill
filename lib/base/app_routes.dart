import 'package:fluro/fluro.dart';
import 'package:scriptkill/base/app_tabbar.dart';
import 'package:scriptkill/pages/login/page_login.dart';

import 'package:scriptkill/pages/mine/mine/page_certification.dart';
import 'package:scriptkill/pages/mine/my_Info/page_editor_my_Info.dart';
import 'package:scriptkill/pages/mine/my_Info/page_my_Info.dart';
import 'package:scriptkill/pages/mine/mine/page_my_followers.dart';
import 'package:scriptkill/pages/mine/mine/page_user_headImage_edit.dart';
import 'package:scriptkill/pages/mine/setting/page_about_us.dart';
import 'package:scriptkill/pages/mine/setting/page_setting.dart';
import 'package:scriptkill/pages/script/person/page_person_details.dart';
import 'package:scriptkill/pages/script/rank/page_store_rank_list.dart';
import 'package:scriptkill/pages/script/script_add/script_add.dart';
import 'package:scriptkill/pages/script/script_details/page_script_details.dart';
import 'package:scriptkill/pages/script/script_evaluation/page_script_evaluation.dart';
import 'package:scriptkill/pages/script/script_home/page_script_home.dart';
import 'package:scriptkill/pages/script/script_list/script_list.dart';
import 'package:scriptkill/util/util_router.dart';
import 'package:scriptkill/widgets/app_guide_page.dart';

// 初始化路由
var router = AppRouter().router;
initRoutes() {
  pages.forEach((name, handler) {
    router.define(name.toString(),
        handler: handler, transitionType: TransitionType.native);
  });
}

// 生成 Handler
Handler handler(Function(Map<String, String> data) f) {
  return Handler(handlerFunc: (context, params) {
    Map<String, String> m = {};
    params.forEach((key, value) {
      m[key] = value?.first;
    });
    return f(m);
  });
}

enum PageNames {
  //guide
  guide,
  //tabbar
  tabbar,
  //登录
  login,

  //我的
  mine_setting,
  mine_aboutUs,
  mine_certification,
  mine_myinfo,
  mine_myfollowers,
  mine_myheadimage,
  mine_editor_myinfo,

  //排行
  rank_store_list,

  //剧本
  script_home,
  script_details,
  script_list,
  script_add,
  script_evaluation,

  //个人
  person_details
}

final Map<PageNames, Handler> pages = {
  // guide
  PageNames.guide: handler((data) => GuidePage()),
  // tabbar
  PageNames.tabbar: handler((data) => AppTabbar()),

  // 登录
  PageNames.login: handler((data) => LoginPage()),

  // 我的
  PageNames.mine_setting: handler((data) => SettingPage()),
  PageNames.mine_aboutUs: handler((data) => AboutUsPage()),
  PageNames.mine_certification:
      AppRouter.handler((data) => CertificationPage()),
  PageNames.mine_myinfo: handler((data) => MyInfoPage()),
  PageNames.mine_myfollowers: handler((data) => MyFollowersPage()),
  PageNames.mine_myheadimage: handler((data) => MyHeadImageEdit(
        avatarUrl: data["avatarUrl"],
      )),
  PageNames.mine_editor_myinfo: handler(
      (data) => EditorMyInfoPage(type: data["type"], title: data["title"])),

  //排行

  PageNames.rank_store_list: handler((data) => StoreRankListPage()),

  //剧本
  PageNames.script_home: handler((data) => ScriptHomePage()),
  PageNames.script_list: handler((data) => ScriptListPage(
      maxCanSelectedNum: int.parse(data['maxNum']), title: data['title'])),
  PageNames.script_add: handler((data) => ScriptAddPage()),
  PageNames.script_evaluation: handler((data) => ScriptEvaluationPage()),
  PageNames.script_details: handler((data) => ScriptDetailsPage()),

  //个人
  PageNames.person_details: handler((data) => PersonDetailsPage()),
};
