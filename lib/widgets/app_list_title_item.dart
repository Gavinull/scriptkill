import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scriptkill/base/app_color.dart';
import 'package:scriptkill/base/app_layout.dart';

class AppListTitleItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final double height;
  final Widget rightWidget;
  final Color borderBottomSideColor;

  final GestureTapCallback onTap;

  AppListTitleItem(
      {this.title,
      this.subTitle,
      this.height = 44.0,
      this.onTap,
      this.rightWidget = const SizedBox(),
      this.borderBottomSideColor = AppColor.lightGreyColorBgColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
            left: AppLayout.pageMargin, right: AppLayout.pageMargin),
        height: AppLayout.height(height),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: AppLayout.width(0.5),
                    color: this.borderBottomSideColor))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            subTitle == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            color: AppColor.fontColor,
                            fontSize: AppLayout.px(15.0)),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            color: AppColor.fontColor,
                            fontSize: AppLayout.px(15.0)),
                      ),
                      SizedBox(
                        height: AppLayout.height(4.0),
                      ),
                      Text(
                        subTitle,
                        style: TextStyle(color: AppColor.fontColorGray),
                      )
                    ],
                  ),
            this.rightWidget
          ],
        ),
      ),
    );
  }
}
