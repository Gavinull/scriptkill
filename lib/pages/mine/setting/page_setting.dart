import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scriptkill/base/app_assets.dart';
import 'package:scriptkill/base/app_color.dart';
import 'package:scriptkill/base/app_layout.dart';
import 'package:scriptkill/base/app_routes.dart';
import 'package:scriptkill/base/app_user.dart';
import 'package:scriptkill/util/util_router.dart';
import 'package:scriptkill/widgets/app_alert.dart';
import 'package:scriptkill/widgets/app_list_title_item.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final List<Map<String, dynamic>> _listItem = const [
    {'title': '关于我们', 'type': 'aboutUs'},
  ];
  bool _value = true;
  // 右边显示的信息
  Widget _rightWidget(String tip, Map<String, dynamic> data) {
    switch (tip) {
      case 'info':
        return Switch(
          value: _value,
          onChanged: (newValue) {
            setState(() {
              _value = newValue;
            });
          },
          activeColor: AppColor.fontColor,
          activeTrackColor: AppColor.mainColor,
          inactiveThumbColor: AppColor.mainColor,
          inactiveTrackColor: Colors.black,
        );
      case 'cache':
        return Row(
          children: <Widget>[
            Text(
              data['subTitle'],
              style: TextStyle(
                  color: AppColor.fontColor, fontSize: AppLayout.px(12.0)),
            ),
            Icon(
              Icons.chevron_right,
              size: AppLayout.width(24.0),
              color: AppColor.fontColor,
            )
          ],
        );
      default:
        return Image.asset(
          AppAsset.arrow_right_list,
          width: 15,
          height: 15,
          color: AppColor.fontColor,
        );
    }
  }

  // 列表到操作
  void _onTap(String type) {
    switch (type) {
      case 'aboutUs':
        AppRouter().navigateTo(context, PageNames.mine_aboutUs.toString());
        break;
      case 'logout':
        showAlert();
        break;
      default:
        break;
    }
  }

  showAlert() {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, anim1, anim2) {},
        barrierColor: Colors.black.withOpacity(.6),
        barrierDismissible: true,
        barrierLabel: "",
        transitionDuration: Duration(milliseconds: 125),
        transitionBuilder: (context, anim1, anim2, child) {
          return Transform.scale(
              scale: anim1.value,
              child: Opacity(
                  opacity: anim1.value,
                  child: AlertWidget(
                    title: '温馨提示',
                    message: '您确定要退出登录吗?',
                    confirm: '退出',
                    confirmCallback: () async {
                      AppUser.userExit(context);
                    },
                  )));
        });
  }

  showCustomAlert() {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(color: Colors.black, fontSize: 15.0),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide.none,
      ),
      titleStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.none,
      title: "温馨提示",
      desc: "您确定要退出登录吗?",
      buttons: [
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(0, 179, 134, 1.0),
            Color.fromRGBO(0, 179, 134, 0.6),
          ]),
        ),
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () {
            Navigator.pop(context);
            AppUser.userExit(context);
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.lightBlueColorBgColor,
        appBar: AppBar(
          title: Text("设置"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColor.lightGreyColorBgColor, width: 0.5),
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular((8.0)),
                ),
                margin: EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: _listItem.map((Map<String, dynamic> data) {
                      return AppListTitleItem(
                        height: AppLayout.height(50.0),
                        title: data['title'],
                        rightWidget: _rightWidget(data['tip'], data),
                        borderBottomSideColor: Colors.transparent,
                        onTap: () {
                          _onTap(data['type']);
                        },
                      );
                    }).toList()),
              ),
              GestureDetector(
                onTap: () {
                  showCustomAlert();
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: 30, right: 30, bottom: AppLayout.height(50.0)),
                  padding:
                      EdgeInsets.symmetric(vertical: AppLayout.height(10.0)),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.buttonBGGrayColor,
                    borderRadius: new BorderRadius.circular((8.0)),
                  ),
                  child: Text(
                    "退出",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: AppLayout.px(15.0),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ]));
  }
}
