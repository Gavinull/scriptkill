import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:scriptkill/base/app_color.dart';
import 'package:scriptkill/base/app_config.dart';
import 'package:scriptkill/base/app_layout.dart';
import 'package:scriptkill/base/app_user.dart';
import 'package:scriptkill/stores/user_store.dart';
import 'package:scriptkill/util/util_router.dart';
import 'package:scriptkill/base/app_routes.dart';

var userStore = AppUser.userStore;

class BasicInfo extends StatefulWidget {
  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) =>
            (Container(alignment: Alignment.center, child: style2(context))));
  }

  Widget style1(context) {
    return Card(
      margin: EdgeInsets.only(
          left: AppLayout.pageMargin, right: AppLayout.pageMargin),
      color: Colors.white,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      clipBehavior: Clip.antiAlias,
      semanticContainer: false,
      child: _mainWidget(context),
    );
  }

  Widget style2(context) {
    return new Container(
      margin: EdgeInsets.only(
          left: AppLayout.pageMargin, right: AppLayout.pageMargin),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
              color: AppColor.boderGrayColor,
              width: 0.2,
              style: BorderStyle.solid)),
      alignment: Alignment.center,
      child: _mainWidget(context),
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
    return Row(
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
                      color: AppColor.fontColor, fontSize: AppLayout.px(16.0))),
              Container(
                height: 5,
              ),
              Text(
                  "ID:${userStore.user.id.isNotEmpty ? userStore.user.id : '-'}",
                  style: TextStyle(
                      color: AppColor.fontColor, fontSize: AppLayout.px(12.0)))
            ],
          ),
        ),
        Expanded(child: Container()),
        Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              border: Border.all(
                  color: AppColor.boderGrayColor,
                  width: 0.2,
                  style: BorderStyle.solid)),
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
                            color: AppColor.fontColor,
                            fontSize: AppLayout.px(12.0))),
                    Container(
                      height: 3,
                    ),
                    Text(
                        "${userStore.user.level.isNotEmpty ? userStore.user.level : '-'}",
                        style: TextStyle(
                            color: AppColor.fontColor,
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
                            color: AppColor.fontColor,
                            fontSize: AppLayout.px(12.0))),
                    Container(
                      height: 3,
                    ),
                    Text(
                        "${userStore.user.honor.isNotEmpty ? userStore.user.honor : '-'}",
                        style: TextStyle(
                            color: AppColor.fontColor,
                            fontSize: AppLayout.px(12.0)))
                  ],
                ),
              ))
            ],
          ),
        )
      ],
    );
  }

  Widget _userSignWidget() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 10),
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
    return Container();
  }
}
