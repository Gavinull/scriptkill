import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:scriptkill/base/app_assets.dart';
import 'package:scriptkill/base/app_color.dart';
import 'package:scriptkill/base/app_layout.dart';
import 'package:scriptkill/base/app_routes.dart';
import 'package:scriptkill/base/app_user.dart';
import 'package:scriptkill/model/UserModel.dart';
import 'package:scriptkill/stores/user_store.dart';
import 'package:scriptkill/util/util_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:scriptkill/util/util_router.dart';
import 'package:scriptkill/util/util_select_picker.dart';
import 'package:scriptkill/util/util_storage.dart';
import 'package:scriptkill/util/util_toast.dart';
import 'package:scriptkill/widgets/app_list_photo_view.dart';
import 'package:scriptkill/widgets/app_list_title_item.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:flutter/services.dart';

var userStore = AppUser.userStore;

enum EditorMyInfoPageType { name, intro }

class EditorMyInfoPage extends StatefulWidget {
  final String title;
  final String type;

  EditorMyInfoPage({this.type, this.title = ""});
  @override
  _EditorMyInfoPageState createState() => _EditorMyInfoPageState();
}

class _EditorMyInfoPageState extends State<EditorMyInfoPage> {
  EditorMyInfoPageType _type;

  TextEditingController _textEditingController = new TextEditingController();
  bool _isCanSave = true;

  @override
  void initState() {
    super.initState();
    if (widget.type == "1") {
      _type = EditorMyInfoPageType.name;
      _textEditingController.text = userStore.user.nickname;
      return buildMyName();
    }

    if (widget.type == "2") {
      _type = EditorMyInfoPageType.intro;
      _textEditingController.text = userStore.user.decs;
      return buildMyName();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.lightBlueColorBgColor,
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  saveAction();
                },
                child: Text("保存",
                    style: TextStyle(
                        color: _isCanSave
                            ? AppColor.fontColor
                            : AppColor.fontColorGray,
                        fontSize: AppLayout.px(15.0))))
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: AppColor.lightGreyColorBgColor, width: 0.5),
              color: Colors.white,
              borderRadius: new BorderRadius.circular((8.0)),
            ),
            margin: EdgeInsets.all(16),
            child: buildView()));
  }
}

// UI
extension on _EditorMyInfoPageState {
  buildView() {
    if (_type == EditorMyInfoPageType.name) {
      return buildMyName();
    }
    if (_type == EditorMyInfoPageType.intro) {
      return buildMyIntro();
    }
    return Container();
  }

  buildMyName() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        onChanged: (t) {
          setState(() {
            _isCanSave = t.isNotEmpty;
          });
          print(t);
        },
        controller: _textEditingController,
        textInputAction: TextInputAction.done,
        style:
            TextStyle(color: AppColor.fontColor, fontSize: AppLayout.px(15.0)),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '输入您的昵称',
          hintStyle: TextStyle(color: AppColor.fontColorGray, fontSize: 15.0),
        ),
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(20)
        ],
      ),
    );
  }

  buildMyIntro() {
    return Container(
      height: 200,
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: TextField(
        onChanged: (t) {
          setState(() {
            _isCanSave = t.isNotEmpty;
          });
          print(t);
        },
        maxLines: 10,
        maxLength: 250,
        controller: _textEditingController,
        textInputAction: TextInputAction.done,
        style:
            TextStyle(color: AppColor.fontColor, fontSize: AppLayout.px(15.0)),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '添加个人简介',
            hintStyle:
                TextStyle(color: AppColor.fontColorGray, fontSize: 15.0)),
      ),
    );
  }
}

// Action
extension on _EditorMyInfoPageState {
  saveAction() {
    if (_type == EditorMyInfoPageType.name) {
      String name = _textEditingController.text;
      if (name.isEmpty) {
        AppToast.show("昵称不能为空");
        return;
      } else {
        userStore.setName(name);
        AppRouter().goBack(context);
      }
    }

    if (_type == EditorMyInfoPageType.intro) {
      String intro = _textEditingController.text;
      userStore.setIntro(intro);
      AppRouter().goBack(context);
    }
  }
}
