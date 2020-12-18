import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:scriptkill/base/app_assets.dart';
import 'package:scriptkill/base/app_color.dart';
import 'package:scriptkill/base/app_config.dart';
import 'package:scriptkill/base/app_layout.dart';
import 'package:scriptkill/base/app_user.dart';
import 'package:scriptkill/pages/mine/mine/BasicInfo.dart';
import 'package:scriptkill/util/util_router.dart';
import 'package:scriptkill/base/app_routes.dart';
import 'package:scriptkill/widgets/app_custom_bar.dart';
import 'package:scriptkill/widgets/app_list_photo_view.dart';
import 'package:scriptkill/widgets/app_list_title_item.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  final List<Map<String, dynamic>> _list = const [
    {'title': '认证DM', 'tip': ''},
    {'title': '我支持的DM', 'tip': ''},
    {'title': '设置', 'tip': ''},
  ];

  List albumList = [
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1599633839321&di=b44861fa8c4d6d0d16af8621b2a39426&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201105%2F17%2F113554rnu40q7nbgnn3lgq.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1599633868327&di=057bdb3d799159dc33d2f759924c06be&imgtype=0&src=http%3A%2F%2Fattachments.gfan.com%2Fforum%2F201503%2F19%2F211608ztcq7higicydxhsy.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1599633879553&di=c7a163c3b188cdb15d1fd68cf846092f&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1307%2F10%2Fc3%2F23153395_1373426315898.jpg"
  ];

  List scriptList = [
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1599633839321&di=b44861fa8c4d6d0d16af8621b2a39426&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201105%2F17%2F113554rnu40q7nbgnn3lgq.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1599633868327&di=057bdb3d799159dc33d2f759924c06be&imgtype=0&src=http%3A%2F%2Fattachments.gfan.com%2Fforum%2F201503%2F19%2F211608ztcq7higicydxhsy.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1599633879553&di=c7a163c3b188cdb15d1fd68cf846092f&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1307%2F10%2Fc3%2F23153395_1373426315898.jpg"
  ];

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    AppUser.syncNetworkUserInfo();
  }

  @override
  dispose() {
    super.dispose();
    print("${this.toStringShort()}-dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBlueColorBgColor,
      appBar: buildAppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              style2(context, _mainWidget(context)),
              style2(context, buildCertificationView()),
              style2(context, buildListView(), bottom: 30.0),
            ],
          ),
        ),
      ),
    );
  }

  buildAppBar() {
    return AppCustomBar(
      context: context,
      backgroundColor: Colors.white,
      bottomLineHeight: 1,
      rightActionsFlex: 2,
      isBack: false,
      rightActions: [
        Container(
            alignment: Alignment.centerRight,
            child: new FlatButton(
                onPressed: () {
                  AppRouter()
                      .navigateTo(context, PageNames.mine_myinfo.toString());
                },
                child: Text("编辑",
                    style: TextStyle(
                        color: AppColor.fontColor,
                        fontSize: AppLayout.px(15.0)))))
      ],
    );
  }
}

// Action
extension on _MinePageState {
  // 点击 cell
  void _handleClick(context, String title) {
    if (title == "设置") {
      AppRouter().navigateTo(context, PageNames.mine_setting.toString());
      return;
    }

    if (title == "我支持的DM") {
      AppRouter().navigateTo(context, PageNames.mine_myfollowers.toString());
      return;
    }

    if (title == "认证DM") {
      AppRouter().navigateTo(context, PageNames.mine_certification.toString());
      return;
    }
  }
}

// user info
extension on _MinePageState {
  style1(context, child, {bottom = 0.0}) {
    return Card(
        margin: EdgeInsets.only(
            bottom: bottom,
            top: AppLayout.pageMargin,
            left: AppLayout.pageMargin,
            right: AppLayout.pageMargin),
        color: Colors.white,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        clipBehavior: Clip.antiAlias,
        semanticContainer: false,
        child: child);
  }

  Widget style2(context, child, {bottom = 0.0}) {
    return Container(
      margin: EdgeInsets.only(
          bottom: bottom,
          top: AppLayout.pageMargin,
          left: AppLayout.pageMargin,
          right: AppLayout.pageMargin),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(
            color: AppColor.boderGrayColor,
            width: 0.1,
          ),
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: AppColor.lightGreyColorBgColor,
              blurRadius: 10,
              spreadRadius: 3,
            )
          ]),
      alignment: Alignment.center,
      child: child,
    );
  }

  Widget _mainWidget(context) {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          _userinfoWidget(context),
          _userSignWidget(),
          _userAlbumWidget()
        ],
      ),
    );
  }

  Widget _userinfoWidget(context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
              child: Container(
                  child: new ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.network(
                  "${userStore.user.headimgurl}",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              )),
              onTap: () {
                String avatarUrl = userStore.user.headimgurl;
                AppRouter().navigateTo(
                    context, PageNames.mine_myheadimage.toString(),
                    params: {"avatarUrl": "$avatarUrl"},
                    transition: TransitionType.nativeModal);
              }),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    "${userStore.user.nickname.isNotEmpty ? userStore.user.nickname : '昵称'}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: AppColor.fontColor,
                        fontSize: AppLayout.px(16.0))),
                Container(
                  height: 5,
                ),
                Text(
                    "ID ${userStore.user.id.isNotEmpty ? userStore.user.id : '-'}",
                    style: TextStyle(
                        color: AppColor.fontColorGray,
                        fontSize: AppLayout.px(12.0)))
              ],
            ),
          ),
          Expanded(child: Container()),
          Container(
            width: 130,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              border: Border.all(
                  color: AppColor.boderGrayColor,
                  width: 0.00001,
                  style: BorderStyle.solid),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(250, 254, 254, 1.0),
                    Color.fromRGBO(250, 224, 254, 1.0),
                  ]),
            ),
            child: new Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("段位",
                          style: TextStyle(
                              color: AppColor.fontColorGray,
                              fontSize: AppLayout.px(12.0))),
                      Container(
                        height: 3,
                      ),
                      Text(
                          "${userStore.user.level.isNotEmpty ? userStore.user.level : '-'}",
                          style: TextStyle(
                              color: AppColor.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: AppLayout.px(12.0)))
                    ],
                  ),
                )),
                Container(
                  width: 0.3,
                  height: 30,
                  color: AppColor.boderGrayColor,
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("荣誉值",
                          style: TextStyle(
                              color: AppColor.fontColorGray,
                              fontSize: AppLayout.px(12.0))),
                      Container(
                        height: 3,
                      ),
                      Text(
                          "${userStore.user.honor.isNotEmpty ? userStore.user.honor : '-'}",
                          style: TextStyle(
                              color: AppColor.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: AppLayout.px(12.0)))
                    ],
                  ),
                ))
              ],
            ),
          )
        ],
      ),
      Container(
        margin: EdgeInsets.only(top: 10),
        child: Divider(),
      )
    ]);
  }

  Widget _userSignWidget() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 3),
      child: Observer(
          builder: (_) => (Text(
              "${userStore.user.decs.isNotEmpty ? userStore.user.decs : '请设置个性签名'}",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColor.fontColorGray,
                  fontSize: AppLayout.px(14.0))))),
    );
  }

  Widget _userAlbumWidget() {
    return Container(
      alignment: Alignment.centerLeft,

      height: 120,
      // color: AppColor.lightGreyColorBgColor,
      // margin: EdgeInsets.only(left: 16, right: 16),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: false,
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Row(
              children: albumList.map((url) {
                return GestureDetector(
                  onTap: () async {
                    Navigator.of(context).push(new PhotoViewFadeRoute(
                        page: PhotoViewGalleryScreen(
                      images: albumList.map((e) => e).toList(),
                      index: albumList.indexOf(url),
                      heroTag: "${albumList.indexOf(url)}",
                    )));
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Hero(
                        tag: "${albumList.indexOf(url)}",
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                              imageUrl: "$url",
                              placeholder: (context, url) => Image.asset(
                                AppAsset.default_headImage,
                                fit: BoxFit.cover,
                                height: 30,
                                width: 30,
                              ),
                            ))),
                  ),
                );
              }).toList(),
            ),
          )),
    );
  }
}

// List
extension on _MinePageState {
  // buildListViewstyle1() {
  //   return Card(
  //       margin: EdgeInsets.only(
  //           bottom: 30,
  //           top: AppLayout.pageMargin,
  //           left: AppLayout.pageMargin,
  //           right: AppLayout.pageMargin),
  //       color: Colors.white,
  //       elevation: 5.0,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(4.0)),
  //       ),
  //       clipBehavior: Clip.antiAlias,
  //       semanticContainer: false,
  //       child: Column(
  //         children: _list.map((Map<String, dynamic> data) {
  //           return AppListTitleItem(
  //             title: data['title'],
  //             subTitle: data['subTitle'],
  //             rightWidget: _rightWidget(data['tip']),
  //             onTap: () => {_handleClick(context, data['title'])},
  //           );
  //         }).toList(),
  //       ));
  // }

  // buildListViewstyle2() {
  //   return Container(
  //       margin: EdgeInsets.only(
  //           bottom: AppLayout.pageMargin,
  //           top: AppLayout.pageMargin,
  //           left: AppLayout.pageMargin,
  //           right: AppLayout.pageMargin),
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.all(Radius.circular(4.0)),
  //           border: Border.all(
  //             color: AppColor.boderGrayColor,
  //             width: 0.1,
  //           ),
  //           boxShadow: [
  //             BoxShadow(
  //               color: AppColor.lightGreyColorBgColor,
  //               blurRadius: 1,
  //               spreadRadius: 3,
  //             )
  //           ]),
  //       alignment: Alignment.center,
  //       child: );
  // }

  buildListView() {
    return Column(
      children: _list.map((Map<String, dynamic> data) {
        return AppListTitleItem(
          title: data['title'],
          subTitle: data['subTitle'],
          rightWidget: _rightWidget(data['tip']),
          onTap: () => {_handleClick(context, data['title'])},
        );
      }).toList(),
    );
  }

  // 右边显示的信息
  Widget _rightWidget(String tip) {
    switch (tip) {
      case 'info':
        return Container(
          width: AppLayout.width(8.0),
          height: AppLayout.height(8.0),
          decoration: BoxDecoration(
              color: AppColor.colorBlue2,
              borderRadius: BorderRadius.circular(AppLayout.width(8.0))),
        );
      default:
        return new Container(
            margin: EdgeInsets.only(right: 0),
            child: Image.asset(
              AppAsset.arrow_right_list,
              width: 15,
              height: 15,
              color: AppColor.fontColor,
            ));
    }
  }
}

// Certification
extension on _MinePageState {
  buildCertificationView() {
    return Container(
        padding: EdgeInsets.all(AppLayout.pageMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                alignment: Alignment.centerLeft,
                // padding: EdgeInsets.only(left: 16),
                // height: 0,
                child: Text(
                  "DM资料",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.fontColor,
                      fontSize: AppLayout.px(16.0),
                      fontWeight: FontWeight.bold),
                )),
            Divider(
                // height: 3,
                // indent: AppLayout.pageMargin,
                // endIndent: AppLayout.pageMargin,
                ),
            Container(
                height: 30,
                // margin: EdgeInsets.only(right: 0),
                alignment: Alignment.centerLeft,
                child: Row(children: [
                  Text("认证门店: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: AppColor.fontColor,
                          fontSize: AppLayout.px(14.0),
                          fontWeight: FontWeight.bold)),
                  Expanded(
                      child: Text("深圳市南山区艺术学院市南山区艺术市南山区艺术市南山区艺术市南山区艺术",
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColor.fontColorGray,
                              fontSize: AppLayout.px(14.0),
                              fontWeight: FontWeight.normal)))
                ])),
            Container(
                height: 30,
                // margin: EdgeInsets.only(right: 0),
                alignment: Alignment.centerLeft,
                child: Row(children: [
                  Text("带本类型: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: AppColor.fontColor,
                          fontSize: AppLayout.px(14.0),
                          fontWeight: FontWeight.bold)),
                  Expanded(
                      child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <InlineSpan>[
                          TextSpan(
                              text: '#沉溺',
                              children: [TextSpan(text: "   ")],
                              style: TextStyle(color: Colors.red)),
                          TextSpan(
                              text: '#对抗',
                              children: [TextSpan(text: "   ")],
                              style: TextStyle(color: Colors.blue)),
                          TextSpan(
                              text: '#寂寞',
                              children: [TextSpan(text: "   ")],
                              style: TextStyle(color: Colors.orange)),
                        ]),
                  ))
                ])),
            Container(
                height: 30,
                // margin: EdgeInsets.only(right: 0),
                alignment: Alignment.centerLeft,
                child: Row(children: [
                  Text("擅长剧本: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: AppColor.fontColor,
                          fontSize: AppLayout.px(14.0),
                          fontWeight: FontWeight.bold)),
                  Expanded(child: Container())
                ])),
            buildSciptListView()
          ],
        ));
  }

  buildSciptListView() {
    // double w = (AppLayout.screenWidth - 16 * 4 - 10 * 2 - 3.3) / 3;
    // double h = 100 * AppLayout.scaleHeight;

    return Container(
      // height: h + 40,
      // color: AppColor.lightGreyColorBgColor,
      // margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: false,
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Row(
              children: scriptList.map((d) {
                return GestureDetector(
                  onTap: () {
                    AppRouter().navigateTo(
                        context, PageNames.script_details.toString());
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(right: 10),
                    child: Column(children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image.asset(
                            AppAsset.logo,
                            width: 60,
                            height: 90,
                            fit: BoxFit.cover,
                          )),
                      Container(
                        height: 30,
                        alignment: Alignment.center,
                        // margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          "得分妹子",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColor.fontColor,
                              fontSize: AppLayout.px(12.0),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          // alignment: Alignment.center,
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "90",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: AppLayout.px(12.0),
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 1,
                          ),
                          Image.asset(
                            AppAsset.zan,
                            width: 16,
                            height: 13,
                          ),
                        ],
                      ))
                    ]),
                  ),
                );
              }).toList(),
            ),
          )),
    );
  }
}
