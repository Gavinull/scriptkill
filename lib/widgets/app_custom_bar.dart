import 'package:flutter/material.dart';
import 'package:scriptkill/base/app_assets.dart';
import 'package:scriptkill/base/app_color.dart';
import 'package:scriptkill/base/app_layout.dart';
import 'package:scriptkill/util/util_router.dart';

/// 这是一个可以指定SafeArea区域背景色的AppBar
/// PreferredSizeWidget提供指定高度的方法
/// 如果没有约束其高度，则会使用PreferredSizeWidget指定的高度

class AppCustomBar extends StatefulWidget implements PreferredSizeWidget {
  BuildContext context;
  final double contentHeight;
  Color backgroundColor;
  String title;
  Widget titleBody;
  bool isBack;
  double bottomLineHeight;

  List<Widget> leftActions = [];
  List<Widget> rightActions = [];
  int rightActionsFlex;
  int leftActionsFlex;

  AppCustomBar({
    @required this.context,
    this.title = "",
    this.isBack = true,
    this.titleBody,
    this.leftActions,
    this.rightActions,
    this.contentHeight = 44,
    this.bottomLineHeight = 1,
    this.backgroundColor = Colors.white,
    this.leftActionsFlex = 1,
    this.rightActionsFlex = 1,
  }) : super() {
    assert(context != null);
    if (leftActions == null) leftActions = [];
    if (rightActions == null) rightActions = [];

    if (isBack == true) {
      leftActions.insert(
          0,
          GestureDetector(
              onTap: () {
                AppRouter().router.pop(context);
              },
              child: Container(
                  width: 60,
                  height: 30,
                  child: Image.asset(
                    AppAsset.go_back,
                    // width: 12,
                    // height: 12,
                  ))));
    }

    if (titleBody == null) {
      titleBody = Container(
        alignment: Alignment.center,
        child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.fontColor,
                fontSize: AppLayout.px(16.0),
                fontWeight: FontWeight.bold)),
      );
    }
  }

  @override
  State<StatefulWidget> createState() {
    return new _AppCustomBarState();
  }

  @override
  Size get preferredSize => new Size.fromHeight(contentHeight);
}

class _AppCustomBarState extends State<AppCustomBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: widget.backgroundColor,
      child: new SafeArea(
        top: true,
        child: new Container(
            decoration: new UnderlineTabIndicator(
              borderSide: BorderSide(
                  width: widget.bottomLineHeight, color: Color(0xFFeeeeee)),
            ),
            height: widget.contentHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: widget.leftActionsFlex,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: widget.leftActions.map((e) => e).toList(),
                    )),
                widget.titleBody,
                Expanded(
                    flex: widget.rightActionsFlex,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: widget.rightActions.map((e) => e).toList(),
                    )),
              ],
            )),
      ),
    );
  }
}
