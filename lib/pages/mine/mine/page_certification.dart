import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scriptkill/base/app_assets.dart';
import 'package:scriptkill/base/app_color.dart';
import 'package:scriptkill/base/app_layout.dart';
import 'package:scriptkill/base/app_routes.dart';
import 'package:scriptkill/util/util_router.dart';
import 'package:scriptkill/util/util_select_picker.dart';

class CertificationPage extends StatefulWidget {
  @override
  _CertificationPageState createState() => _CertificationPageState();
}

const String tiitle_stores = "选择门店";
const String tiitle_type = "带本类型";
const String tiitle_goodAt = "擅长剧本";

class _CertificationPageState extends State<CertificationPage> {
  /// 门店
  String value_stores = "";

  /// 带本类型名称
  String value_type = "";

  /// 擅长剧本名称
  String value_goodAt = "";

  /// 已选剧本
  List<String> scriptList = [];

  /// 是否已提交资料
  bool isSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => (Scaffold(
            backgroundColor: AppColor.lightBlueColorBgColor,
            appBar: AppBar(
              title: Text("认证DM"),
              centerTitle: true,
              elevation: 0,
            ),
            body: isSubmit
                ? buildSubmitSuccessView()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [buildInfoView(), buildSubmit()]))));
  }
}

/// UI
extension on _CertificationPageState {
  buildInfoView() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.lightGreyColorBgColor, width: 0.5),
        color: Colors.white,
        borderRadius: new BorderRadius.circular((8.0)),
      ),
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16),
              height: 60,
              child: Text(
                "基本信息  (必填)",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.fontColor,
                    fontSize: AppLayout.px(16.0),
                    fontWeight: FontWeight.bold),
              )),
          Divider(),
          buildSelectView(tiitle_stores, "点击选择", value_stores),
          buildSelectView(tiitle_type, "点击选择", value_type),
          buildSelectView(tiitle_goodAt, "自选3个", value_goodAt,
              valueTextColor: AppColor.fontColor),
          Container(
            height: 10,
          ),
          buildSciptListView()
        ],
      ),
    );
  }

  buildSelectView(String title, String hintText, String valueText,
      {Color valueTextColor = AppColor.mainColor}) {
    var hasSelected = valueText.isNotEmpty;

    return Container(
      height: 60,
      child: Row(
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.fontColor,
                    fontSize: AppLayout.px(15.0),
                    fontWeight: FontWeight.normal),
              )),
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    _handleClick(title);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: AppLayout.height(40),
                    margin: EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      color: hasSelected
                          ? AppColor.lightBlueColorBgColor
                          : AppColor.lightGreyColorBgColor,
                      borderRadius: new BorderRadius.circular((8.0)),
                    ),
                    child: Text(
                      hasSelected ? valueText : hintText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: hasSelected
                              ? valueTextColor
                              : AppColor.fontColorGray,
                          fontSize: AppLayout.px(12.0),
                          fontWeight: FontWeight.w400),
                    ),
                  ))),
        ],
      ),
    );
  }

  buildSciptListView() {
    double w = (AppLayout.screenWidth - 16 * 4 - 10 * 2 - 3.3) / 3;
    double h = 140 * AppLayout.scaleHeight;

    return Container(
      // height: h + 40,
      // color: AppColor.lightGreyColorBgColor,
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: false,
          physics: BouncingScrollPhysics(),
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: scriptList.map((d) {
                return GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Column(children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: Image.asset(
                              AppAsset.logo,
                              width: w,
                              height: h,
                              fit: BoxFit.cover,
                            )),
                        Container(
                          height: 35,
                          alignment: Alignment.center,
                          // margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            "剧本杀杀",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.fontColor,
                                fontSize: AppLayout.px(12.0),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ]),
                    ),
                    onTap: () async {});
              }).toList(),
            ),
          )),
    );
  }

  buildSubmit() {
    bool isNotAllselected =
        (scriptList.isEmpty || value_type.isEmpty || value_stores.isEmpty);
    return GestureDetector(
      onTap: () {
        if (isNotAllselected) {
          return;
        }
        setState(() {
          isSubmit = true;
        });
      },
      child: Container(
        margin: EdgeInsets.only(
            left: 16, right: 16, bottom: AppLayout.height(50.0)),
        padding: EdgeInsets.symmetric(vertical: AppLayout.height(14.0)),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isNotAllselected
              ? AppColor.buttonBGlightGrayColor
              : AppColor.buttonBGGrayColor,
          borderRadius: new BorderRadius.circular((8.0)),
        ),
        child: Text(
          "提交",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: AppLayout.px(15.0),
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

/// Action
extension on _CertificationPageState {
  _handleClick(String title) {
    if (title == tiitle_stores) {
      List<String> data = [
        "深大山海间1",
        "深大山海间2",
        "深大山海间3",
        "深大山海间4",
        "深大山海间6",
        "深大山海间8",
        "深大山海间1",
        "深大山海间0"
      ];
      AppSelectPicker.showStringPicker(context,
          title: title,
          data: data,
          normalIndex: data.indexOf(value_stores), clickCallBack: (index, e) {
        setState(() {
          value_stores = e;
        });
      });
      return;
    }

    if (title == tiitle_type) {
      List<String> data = [
        "类型1",
        "类型2",
        "类型3",
        "类型4",
        "类型6",
        "类型8",
        "类型1",
        "类型0"
      ];
      AppSelectPicker.showStringPicker(context,
          title: title,
          data: data,
          normalIndex: data.indexOf(value_type), clickCallBack: (index, e) {
        setState(() {
          value_type = e;
        });
      });
      return;
    }

    if (title == tiitle_goodAt) {
      AppRouter().navigateTo(context, PageNames.script_list.toString(),
          params: {"maxNum": "3", "title": "选择剧本"}).then((list) {
        print(list);
        print(list.runtimeType);

        if (list is LinkedHashSet) {
          if (list.first is List<String>) {
            setState(() {
              value_goodAt = "重新选择";
              this.scriptList = list.first;
            });
          }
          print("32323");
        }
      });
    }
  }
}

// 提交成功 View
extension on _CertificationPageState {
  buildSubmitSuccessView() {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 150.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: new ClipRRect(
                borderRadius: BorderRadius.circular(75.0),
                child: Image.asset(
                  AppAsset.waiting,
                  width: 150,
                  height: 150,
                ),
              )),
              Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "你已提交资料",
                        style:
                            TextStyle(fontSize: 12, color: AppColor.fontColor),
                      ),
                      Text(
                        "请耐心等待,我们会尽快审核",
                        style:
                            TextStyle(fontSize: 12, color: AppColor.fontColor),
                      ),
                    ],
                  ))
            ]));
  }
}
