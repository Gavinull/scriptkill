import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:scriptkill/base/app_assets.dart';

import 'package:scriptkill/pages/script/rank/page_all_rank_list.dart';
import 'package:scriptkill/pages/mine/mine/page_mine.dart';
import 'package:scriptkill/base/app_color.dart';
import 'package:scriptkill/base/app_layout.dart';
import 'package:scriptkill/pages/script/script_home/page_script_home.dart';
import 'package:scriptkill/stores/user_store.dart';

class AppTabbar extends StatefulWidget {
  @override
  _AppTabbarState createState() => _AppTabbarState();
}

class _AppTabbarState extends State<AppTabbar> {
  int _lastClickTime = 0;
  int _activeIndex = 0;
  final _pageData = [
    {
      "activeIndex": 0,
      "page": AllRankListPage(),
      "barImage": AppAsset.tabbar_home,
      "title": "排名"
    },
    {
      "activeIndex": 1,
      "page": ScriptHomePage(),
      "barImage": AppAsset.tabbar_script,
      "title": "记录"
    },
    {
      "activeIndex": 2,
      "page": MinePage(),
      "barImage": AppAsset.tabbar_mine,
      "title": "我的"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);

    return WillPopScope(
        onWillPop: _doubleExit,
        child: Scaffold(
          // appBar: PreferredSize(
          //   preferredSize: Size.fromHeight(0.0),
          //   child: Container(),
          // ),
          body: IndexedStack(
            index: _activeIndex,
            children: List<Widget>.from(_pageData.map((e) => e["page"])),
          ),
          bottomNavigationBar: CupertinoTabBar(
            activeColor: AppColor.mainColor,
            inactiveColor: AppColor.lightGray,
            backgroundColor: AppColor.themeColor,
            items: List<BottomNavigationBarItem>.from(
                _pageData.map((page) => _barItem(page))).toList(),
            currentIndex: _activeIndex,
            onTap: (int index) {
              setState(() {
                _activeIndex = index;
              });
            },
          ),
        ));
  }

  BottomNavigationBarItem _barItem(Map<Object, Object> page) {
    int index = page['activeIndex'];
    String image = page['barImage'];
    String title = page['title'];

    return new BottomNavigationBarItem(
        title: Text("$title"),
        icon: SvgPicture.asset(image,
            width: AppLayout.width(AppLayout.bottomIconWidth),
            height: AppLayout.height(AppLayout.bottomIconHeight),
            color: _activeIndex == index
                ? AppColor.mainColor
                : AppColor.lightGray));
  }

  // 双击返回键退出应用
  Future<bool> _doubleExit() {
    print("1");
    int nowTime = DateTime.now().microsecondsSinceEpoch;
    if (_lastClickTime != 0 && nowTime - _lastClickTime > 1500) {
      return Future.value(true);
    } else {
      _lastClickTime = DateTime.now().microsecondsSinceEpoch;
      Future.delayed(const Duration(milliseconds: 1500), () {
        _lastClickTime = 0;
      });
      return Future.value(false);
    }
  }
}
