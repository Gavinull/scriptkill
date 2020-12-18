import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scriptkill/base/app_assets.dart';
import 'package:scriptkill/base/app_color.dart';
import 'package:scriptkill/base/app_layout.dart';
import 'package:scriptkill/base/app_url.dart';
import 'package:scriptkill/widgets/refresh/app_bezier_bounce_footer.dart';
import 'package:scriptkill/widgets/refresh/app_bezier_circle_header.dart';
import 'package:scriptkill/widgets/refresh/app_page_first_refresh_animation.dart';
import 'package:scriptkill/widgets/refresh/app_refresh_empty_widget.dart';
import 'package:scriptkill/widgets/refresh/app_refresh_header.dart';

class MyFollowersPage extends StatefulWidget {
  @override
  _MyFollowersPageState createState() => _MyFollowersPageState();
}

class _MyFollowersPageState extends State<MyFollowersPage> {
  EasyRefreshController _controller = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Scaffold(
              backgroundColor: AppColor.lightBlueColorBgColor,
              appBar: AppBar(
                title: Text("我支持的DM",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.fontColor,
                        fontSize: AppLayout.px(16.0),
                        fontWeight: FontWeight.bold)),
                centerTitle: true,
                elevation: 0,
                actions: <Widget>[
                  IconButton(
                      // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                      icon: FaIcon(FontAwesomeIcons.search, size: 18),
                      onPressed: () {
                        print("Pressed");
                      }),
                ],
              ),
              body: buildMainView(),
            ));
  }
}

/// UI
extension on _MyFollowersPageState {
  buildMainView() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.lightGreyColorBgColor, width: 0.5),
        color: Colors.white,
        borderRadius: new BorderRadius.circular((8.0)),
      ),
      margin: EdgeInsets.all(AppLayout.pageMargin),
      padding: EdgeInsets.only(
          left: AppLayout.pageMargin,
          right: AppLayout.pageMargin,
          top: 16,
          bottom: AppLayout.pageMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              // color: Colors.amber,
              child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.fontColor,
                        fontSize: AppLayout.px(14.0),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "昵称",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.fontColor,
                        fontSize: AppLayout.px(14.0),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "得分",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.fontColor,
                        fontSize: AppLayout.px(14.0),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "排名",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.fontColor,
                        fontSize: AppLayout.px(14.0),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "玩本数",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.fontColor,
                        fontSize: AppLayout.px(14.0),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              )
            ],
          )),
          Divider(),
          Expanded(
              child: EasyRefresh.custom(
            // emptyWidget: AppRefreshEmptyWidget(),
            enableControlFinishRefresh: false,
            enableControlFinishLoad: false,
            controller: _controller,
            firstRefresh: false,
            firstRefreshWidget: AppFirstRefreshAnimation(),
            header: AppRefreshHeader(backgroundColor: Colors.white),
            footer: AppBezierBounceFooter(backgroundColor: Colors.white),
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _buildListItems(index);
                  },
                  childCount: 30,
                ),
              )
            ],
            onRefresh: () async {
              print("onRefresh");
            },
            onLoad: () async {
              print("onLoad");
            },
          ))
        ],
      ),
    );
  }

  _buildListItems(int index) {
    return Container(
        height: 60,
        // color: Colors.amber,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "${(index + 1)}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.fontColor,
                      fontSize: AppLayout.px(14.0),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: 30,
                          width: 30,
                          imageUrl:
                              "https://dss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3256100974,305075936&fm=26&gp=0.jpg",
                          placeholder: (context, url) => Image.asset(
                            AppAsset.default_headImage,
                            fit: BoxFit.cover,
                            height: 30,
                            width: 30,
                          ),
                        )),
                    Expanded(
                        child: Container(
                            color: Colors.red,
                            child: Text(
                              " 小猫HDHJDEK",
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: AppColor.fontColor,
                                  fontSize: AppLayout.px(12.0),
                                  fontWeight: FontWeight.normal),
                            )))
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "100",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.mainColor,
                      fontSize: AppLayout.px(14.0),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "3",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.fontColor,
                      fontSize: AppLayout.px(14.0),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "10",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.fontColor,
                      fontSize: AppLayout.px(14.0),
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ));
  }
}
