import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:scriptkill/base/app_assets.dart';
import 'package:scriptkill/base/app_color.dart';
import 'package:scriptkill/base/app_routes.dart';
import 'package:scriptkill/base/app_tabbar.dart';
import 'package:scriptkill/base/app_user.dart';
import 'package:scriptkill/base/app_wechat.dart';
import 'package:scriptkill/util/router/router.dart';
import 'package:scriptkill/util/util_router.dart';
import 'package:scriptkill/util/util_storage.dart';
import 'package:scriptkill/util/util_toast.dart';
import 'package:scriptkill/widgets/AnimatedLoginButton.dart';
import 'package:rxdart/rxdart.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();
  final LoginErrorMessageController loginErrorMessageController =
      LoginErrorMessageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 150.0),
                child: new ClipRRect(
                  borderRadius: BorderRadius.circular(75.0),
                  child: Image.asset(
                    AppAsset.logo,
                    width: 150,
                    height: 150,
                  ),
                )),
            // Container(
            //   width: 200.0,
            //   height: 40.0,
            //   decoration: BoxDecoration(
            //       color: AppColor.buttonBGGrayColor,
            //       borderRadius: BorderRadius.circular(24.0)),
            //   child: Material(
            //     color: Colors.transparent,
            //     child: InkWell(
            //       onTap: () {
            //         // AppUser.userLogin(context);
            //         AppWechat.loginWechat((userInfo) async {
            //           await AppUser.saveUserInfo(userInfo);
            //           AppUser.userLogin(context);
            //         }, (errStr) {
            //           AppToast.show(errStr);
            //         });
            //       },
            //       child: Center(
            //         child: Text("微信登录",
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 fontFamily: "Poppins-Bold",
            //                 fontSize: 18,
            //                 letterSpacing: 1.0)),
            //       ),
            //     ),
            //   ),
            // ),
            AnimatedLoginButton(
              // width: 100,
              loginTip: "微信登录",
              buttonColorNormal: AppColor.buttonBGGrayColor,
              loginErrorMessageController: loginErrorMessageController,
              onTap: () async {
                AppWechat.loginWechat((userInfo) async {
                  await AppUser.saveUserInfo(userInfo);
                  AppUser.userLogin(context);
                }, (errStr) {
                  AppToast.show(errStr);
                });
              },
            ),
            Container(
              height: 10.0,
            ),
            Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "注册即同意 ",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Poppins-Medium",
                          color: AppColor.fontColorGray),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text("用户协议",
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColor.mainColor,
                              fontFamily: "Poppins-Bold")),
                    ),
                    Text(
                      " 和 ",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Poppins-Medium",
                          color: AppColor.fontColorGray),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text("隐私政策",
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColor.mainColor,
                              fontFamily: "Poppins-Bold")),
                    ),
                  ],
                ))
          ])),
    );
  }
}
