import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:scriptkill/base/app_assets.dart';
import 'package:scriptkill/base/app_color.dart';
import 'package:scriptkill/base/app_layout.dart';
import 'package:scriptkill/base/app_routes.dart';
import 'package:scriptkill/util/util_router.dart';
import 'package:scriptkill/util/util_select_picker.dart';
import 'package:scriptkill/util/util_toast.dart';

class ScriptListPage extends StatefulWidget {
  final String title;
  final maxCanSelectedNum;
  ScriptListPage({this.maxCanSelectedNum = 1, this.title = "添加剧本"});
  @override
  _ScriptListPageState createState() =>
      _ScriptListPageState(maxCanSelectedNum: maxCanSelectedNum);
}

const String tiitle_stores = "选择门店";
const String tiitle_type = "带本类型";
const String tiitle_goodAt = "擅长剧本";

class _ScriptListPageState extends State<ScriptListPage> {
  _ScriptListPageState({this.maxCanSelectedNum});
  int maxCanSelectedNum = 1;
  List<String> didSelectedList = List();
  List<String> scriptList = [
    "WS6666W",
    "EE355eE32",
    "DwWED",
    "WSQrrW",
    "Er3Ess32",
    "DWDsssWED",
    "WSQW",
    "EE23Err32",
    "www",
    "WSQwwwrrW",
    "EE2dssssww3E32",
    "ssaasa"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => (Scaffold(
            backgroundColor: AppColor.themeColor,
            appBar: AppBar(
              title: Text(
                  "${widget.title}${maxCanSelectedNum > 1 ? "(" + didSelectedList.length.toString() + "/" + maxCanSelectedNum.toString() + ")" : ""}"),
              centerTitle: true,
              elevation: 0,
            ),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildInfoView(),
                  maxCanSelectedNum == 0 ? Container() : buildSubmit()
                ]))));
  }
}

/// UI
extension on _ScriptListPageState {
  buildInfoView() {
    double w = AppLayout.screenWidth / 3;
    double h = (140 + 35 + 10) * AppLayout.scaleHeight;
    return Expanded(
        child: Container(
            margin: EdgeInsets.only(
                left: AppLayout.pageMargin,
                right: AppLayout.pageMargin,
                bottom: AppLayout.pageMargin),
            alignment: Alignment.center,
            child: AnimationLimiter(
                child: GridView.builder(
                    itemCount: scriptList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 0.0,
                        crossAxisSpacing: 0.0,
                        childAspectRatio: w / h),
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredGrid(
                          columnCount: scriptList.length,
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: FadeInAnimation(
                              // verticalOffset: 150.0,
                              child: buildSciptListView(scriptList[index])));
                    }))));
  }

  buildSciptListView(String name) {
    double w = (AppLayout.screenWidth - 16 * 2 - 20 * 2) / 3;
    // double h = 140 * AppLayout.scaleHeight;

    return GestureDetector(
        onTap: () {
          _handleClick(name);
        },
        child: Container(
            margin: EdgeInsets.only(top: 16),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                              color: didSelectedList.contains(name)
                                  ? AppColor.mainColor
                                  : Colors.transparent,
                              width: 0.1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: didSelectedList.contains(name)
                                    ? AppColor.mainColor
                                    : Colors.transparent,
                                blurRadius: 1,
                                spreadRadius: 2,
                              )
                            ]),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: w,
                              imageUrl:
                                  "https://dss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3256100974,305075936&fm=26&gp=0.jpg",
                              placeholder: (context, url) => Image.asset(
                                AppAsset.default_headImage,
                                fit: BoxFit.cover,
                                height: 30,
                                width: 30,
                              ),
                            )))),
                Container(
                  // height: 35,
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  // margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "剧本",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: didSelectedList.contains(name)
                            ? AppColor.mainColor
                            : AppColor.fontColor,
                        fontSize: AppLayout.px(12.0),
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )));
  }

  buildSubmit() {
    return GestureDetector(
      onTap: () {
        if (didSelectedList.isEmpty) {
          return;
        }
        AppRouter().goBack(context, result: {didSelectedList});
      },
      child: Container(
        margin: EdgeInsets.only(
            left: 16, right: 16, bottom: AppLayout.height(50.0)),
        padding: EdgeInsets.symmetric(vertical: AppLayout.height(14.0)),
        width: double.infinity,
        decoration: BoxDecoration(
          color: didSelectedList.isEmpty
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
extension on _ScriptListPageState {
  _handleClick(String title) {
    print(title);
    print(didSelectedList);

    if (maxCanSelectedNum == 0) {
      AppRouter().navigateTo(context, PageNames.script_details.toString());
    }

    //单选
    if (maxCanSelectedNum == 1) {
      setState(() {
        didSelectedList = [title];
      });
    }

    // 多选
    if (maxCanSelectedNum > 1) {
      if (didSelectedList.contains(title)) {
        didSelectedList.remove(title);
        setState(() {
          didSelectedList = didSelectedList;
        });
      } else {
        if (didSelectedList.length < maxCanSelectedNum) {
          didSelectedList.add(title);
          setState(() {
            didSelectedList = didSelectedList;
          });
        } else {
          AppToast.show("最多可选择$maxCanSelectedNum个");
        }
      }
    }
  }
}
