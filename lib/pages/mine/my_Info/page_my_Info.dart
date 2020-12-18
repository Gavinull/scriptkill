import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

var userStore = AppUser.userStore;

class MyInfoPage extends StatefulWidget {
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  File imageFile;
  List<File> albumFileList = List();

  String title_name = "昵称";
  String title_age = "年龄";
  String title_sex = "性别";
  String title_intro = "个人简介";

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => (Scaffold(
            backgroundColor: AppColor.lightBlueColorBgColor,
            appBar: AppBar(
              title: Text("编辑资料"),
              centerTitle: true,
              elevation: 0,
            ),
            body: Container(
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
                children: <Widget>[
                  buildHeadImage(),
                  buildGallery(),
                  buildInfo()
                ],
              ),
            ))));
  }
}

// UI
extension on _MyInfoPageState {
  buildHeadImage() {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
          child: Container(
              margin: EdgeInsets.all(20),
              child: new ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: imageFile == null
                      ? Image.network(
                          "${userStore.user.headimgurl}",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          imageFile,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ))),
          onTap: () async {
            selectHeadImage();
          }),
    );
  }

  buildGallery() {
    return Container(
      height: 120,
      color: AppColor.lightGreyColorBgColor,
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
              child: Container(
                  color: AppColor.lightBlueColorBgColor,
                  margin: EdgeInsets.only(right: 10, left: 10),
                  child: new ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        AppAsset.add_photo,
                        width: 100,
                        height: 100,
                      ))),
              onTap: () async {
                selectGalleryImage();
              }),
          Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: false,
                physics: BouncingScrollPhysics(),
                child: Container(
                  child: Row(
                    children: albumFileList.map((file) {
                      return GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Hero(
                                tag: "${albumFileList.indexOf(file)}",
                                child: Image.file(
                                  file,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          onTap: () async {
                            Navigator.of(context).push(new PhotoViewFadeRoute(
                                page: PhotoViewGalleryScreen(
                              images: albumFileList.map((e) => e.path).toList(),
                              index: albumFileList.indexOf(file),
                              heroTag: "${albumFileList.indexOf(file)}",
                            )));
                          });
                    }).toList(),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  buildInfo() {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 16, right: 16),
        child: Column(
          children: <Widget>[
            buildInfoItems(title_name, userStore.user.nickname),
            Divider(),
            buildInfoItems(title_age, userStore.user.age),
            Divider(),
            buildInfoItems(title_sex, userStore.user.sex == "1" ? "男" : "女"),
            Divider(),
            buildInfoItems(title_intro, userStore.user.decs,
                height: 80, textBottom: 0),
          ],
        ));
  }

  buildInfoItems(String title, String value,
      {double height = 44, double textBottom = 0}) {
    return GestureDetector(
      child: Container(
          height: height,
          color: Colors.white,
          child: Row(
            children: [
              Container(
                  child: Text(title,
                      style: TextStyle(
                          color: AppColor.fontColorGray,
                          fontSize: AppLayout.px(15.0)))),
              Expanded(
                  child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(
                          left: 10, right: 3, bottom: textBottom),
                      child: Text(value,
                          maxLines: 3,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: AppColor.fontColor,
                              fontSize: AppLayout.px(14.0))))),
              Image.asset(
                AppAsset.arrow_right_list,
                width: 15,
                height: 15,
                color: AppColor.fontColor,
              )
            ],
          )),
      onTap: () {
        _handleClick(context, title);
      },
    );
  }
}

// Action
extension on _MyInfoPageState {
  selectHeadImage() {
    AppImagePicker().showSheet(context, (result) {
      if (result is String) {
        AppToast.show(result);
      }
      if (result is File) {
        setState(() {
          imageFile = result;
        });
        print(result);
      }
    });
  }

  selectGalleryImage() {
    AssetPicker.pickAssets(context).then((List<AssetEntity> assets) async {
      print(assets);
      assets.forEach((element) async {
        var d = await element.originFile;
        print(d);
        albumFileList.add(d);
        setState(() {
          albumFileList = albumFileList;
        });
      });
    });
  }

  // 点击 cell
  void _handleClick(context, String title) {
    if (title == title_age) {
      AppSelectPicker.showDatePicker(context, title: "出生日期",
          clickCallback: (p, l) {
        userStore.setAge('$p');
        print('$p');
      });
      return;
    }

    if (title == title_sex) {
      AppSelectPicker.showStringPicker(context,
          title: "选择性别",
          data: ["男", "女"],
          normalIndex: userStore.user.sex == "1" ? 0 : 1,
          clickCallBack: (index, sex) {
        userStore.setSex((index + 1).toString());
      });
      return;
    }

    if (title == title_name) {
      AppRouter().navigateTo(context, PageNames.mine_editor_myinfo.toString(),
          params: {"type": "1", "title": "修改昵称"});
      return;
    }

    if (title == title_intro) {
      AppRouter().navigateTo(context, PageNames.mine_editor_myinfo.toString(),
          params: {"type": "2", "title": "修改简介"});
      return;
    }
  }
}
