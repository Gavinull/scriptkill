import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scriptkill/base/app_color.dart';

class AppFirstRefreshAnimation extends StatefulWidget {
  @override
  _AppFirstRefreshAnimationState createState() =>
      _AppFirstRefreshAnimationState();
}

class _AppFirstRefreshAnimationState extends State<AppFirstRefreshAnimation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: double.infinity,
      child: Container(
        child: SpinKitDoubleBounce(
          color: AppColor.mainColor,
          size: 35.0,
        ),
      ),
    );
  }
}
