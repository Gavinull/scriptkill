import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scriptkill/base/app_assets.dart';
import 'package:scriptkill/base/app_color.dart';
import 'package:scriptkill/base/app_layout.dart';
import 'package:scriptkill/base/app_routes.dart';
import 'package:scriptkill/util/util_router.dart';
import 'package:scriptkill/util/util_select_picker.dart';

class ScriptAddPage extends StatefulWidget {
  @override
  _ScriptAddPageState createState() => _ScriptAddPageState();
}

const String tiitle_script = "选择剧本";
const String tiitle_peple = "玩家列表";

const String tiitle_overall_score = "整体评分";
const String tiitle_murderer_score = "凶手评分";
const String tiitle_carry_score = "Carry评分";

class _ScriptAddPageState extends State<ScriptAddPage> {
  /// 选择剧本
  String value_script = "";

  /// 玩家列表
  String value_peple = "";

  /// 整体评分
  String value_overall_score = "";

  /// 凶手评分
  String value_murderer_score = "";

  /// Carry评分
  String value_carry_score = "";

  /// 是否已提交资料
  bool isSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => (Scaffold(
            backgroundColor: AppColor.lightBlueColorBgColor,
            appBar: AppBar(
              title: Text("新增剧本经历"),
              centerTitle: true,
              elevation: 0,
            ),
            body: isSubmit
                ? buildSubmitSuccessView()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Expanded(
                            child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: false,
                          physics: BouncingScrollPhysics(),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [buildInfoView(), buildScoreView()]),
                        )),
                        buildSubmit()
                      ]))));
  }
}

/// UI
extension on _ScriptAddPageState {
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
                "基本信息",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.fontColor,
                    fontSize: AppLayout.px(16.0),
                    fontWeight: FontWeight.bold),
              )),
          Divider(),
          buildSelectView(tiitle_script, "点击选择", value_script),
          buildSelectView(tiitle_peple, "新增", value_peple),
        ],
      ),
    );
  }

  buildScoreView() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.lightGreyColorBgColor, width: 0.5),
        color: Colors.white,
        borderRadius: new BorderRadius.circular((8.0)),
      ),
      margin: EdgeInsets.only(
          left: AppLayout.pageMargin, right: AppLayout.pageMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16),
              height: 60,
              child: Text(
                "DM打分",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.fontColor,
                    fontSize: AppLayout.px(16.0),
                    fontWeight: FontWeight.bold),
              )),
          Divider(),
          buildSelectView(tiitle_overall_score, "点击选择", value_overall_score),
          buildSelectView(tiitle_murderer_score, "点击选择", value_murderer_score),
          buildSelectView(tiitle_carry_score, "点击选择", value_carry_score),
          Container(
            height: 10,
          ),
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
              width: 100,
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

  buildSubmit() {
    bool isNotAllselected = (value_script.isEmpty ||
        value_peple.isEmpty ||
        value_overall_score.isEmpty ||
        value_murderer_score.isEmpty ||
        value_carry_score.isEmpty);

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
extension on _ScriptAddPageState {
  _handleClick(String title) {
    if (title == tiitle_script) {
      AppRouter().navigateTo(context, PageNames.script_list.toString(),
          params: {"maxNum": "1", "title": "选择剧本"}).then((list) {
        print(list);
        print(list.runtimeType);

        if (list is LinkedHashSet) {
          if (list.first is List<String>) {
            setState(() {
              value_script = "${list.first}";
            });
          }
          print("32323");
        }
      });
    }

    if (title == tiitle_peple) {
      List<String> data = [
        "玩家1",
        "玩家2",
        "玩家3",
        "玩家4",
        "玩家型6",
        "玩家8",
        "玩家1",
        "玩家0"
      ];
      AppSelectPicker.showStringPicker(context,
          title: title,
          data: data,
          normalIndex: data.indexOf(value_peple), clickCallBack: (index, e) {
        setState(() {
          value_peple = e;
        });
      });
      return;
    }

    if (title == tiitle_overall_score) {
      List<String> data = [
        "0分",
        "1分",
        "2分",
        "3分",
        "4分",
        "5分",
      ];
      AppSelectPicker.showStringPicker(context,
          title: title,
          data: data,
          normalIndex: data.indexOf(value_script), clickCallBack: (index, e) {
        setState(() {
          value_overall_score = e;
        });
      });
      return;
    }

    if (title == tiitle_murderer_score) {
      List<String> data = [
        "0分",
        "1分",
        "2分",
        "3分",
        "4分",
        "5分",
      ];
      AppSelectPicker.showStringPicker(context,
          title: title,
          data: data,
          normalIndex: data.indexOf(value_script), clickCallBack: (index, e) {
        setState(() {
          value_murderer_score = e;
        });
      });
      return;
    }

    if (title == tiitle_carry_score) {
      List<String> data = [
        "0分",
        "1分",
        "2分",
        "3分",
        "4分",
        "5分",
      ];
      AppSelectPicker.showStringPicker(context,
          title: title,
          data: data,
          normalIndex: data.indexOf(value_script), clickCallBack: (index, e) {
        setState(() {
          value_carry_score = e;
        });
      });
      return;
    }
  }
}

// 提交成功 View
extension on _ScriptAddPageState {
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
                        "你已提交剧本",
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
