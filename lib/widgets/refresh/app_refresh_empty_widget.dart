import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:scriptkill/base/app_color.dart';

class AppRefreshEmptyWidget extends StatefulWidget {
  @override
  _AppRefreshEmptyWidgetState createState() {
    return _AppRefreshEmptyWidgetState();
  }
}

class _AppRefreshEmptyWidgetState extends State<AppRefreshEmptyWidget> {
  Widget build(BuildContext context) {
    return Align(
      child: Text("暂无数据", style: TextStyle(color: AppColor.fontColorGray)),
    );
  }
}
