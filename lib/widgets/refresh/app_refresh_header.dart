import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scriptkill/base/app_color.dart';

// The duration of the ScaleTransition that starts when the refresh action
// has completed.
const Duration _kIndicatorScaleDuration = Duration(milliseconds: 200);

class AppRefreshHeader extends Header {
  final Key key;
  final double displacement;
  final Animation<Color> valueColor;
  final Color backgroundColor;

  final LinkHeaderNotifier linkNotifier = LinkHeaderNotifier();

  AppRefreshHeader({
    this.key,
    this.displacement = 40.0,
    this.valueColor,
    this.backgroundColor,
    completeDuration = const Duration(seconds: 1),
    bool enableHapticFeedback = false,
  }) : super(
          float: false,
          extent: 70.0,
          triggerDistance: 70.0,
          completeDuration: completeDuration == null
              ? Duration(
                  milliseconds: 300,
                )
              : completeDuration +
                  Duration(
                    milliseconds: 300,
                  ),
          enableInfiniteRefresh: false,
          enableHapticFeedback: enableHapticFeedback,
        );

  @override
  Widget contentBuilder(
      BuildContext context,
      RefreshMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteRefresh,
      bool success,
      bool noMore) {
    linkNotifier.contentBuilder(
        context,
        refreshState,
        pulledExtent,
        refreshTriggerPullDistance,
        refreshIndicatorExtent,
        axisDirection,
        float,
        completeDuration,
        enableInfiniteRefresh,
        success,
        noMore);
    return MaterialHeaderWidget(
      key: key,
      displacement: displacement,
      valueColor: valueColor,
      backgroundColor: backgroundColor,
      linkNotifier: linkNotifier,
    );
  }
}

class MaterialHeaderWidget extends StatefulWidget {
  final double displacement;
  final Animation<Color> valueColor;
  final Color backgroundColor;
  final LinkHeaderNotifier linkNotifier;

  const MaterialHeaderWidget({
    Key key,
    this.displacement,
    this.valueColor,
    this.backgroundColor,
    this.linkNotifier,
  }) : super(key: key);

  @override
  MaterialHeaderWidgetState createState() {
    return MaterialHeaderWidgetState();
  }
}

class MaterialHeaderWidgetState extends State<MaterialHeaderWidget>
    with TickerProviderStateMixin<MaterialHeaderWidget> {
  static final Animatable<double> _oneToZeroTween =
      Tween<double>(begin: 1.0, end: 0.0);

  RefreshMode get _refreshState => widget.linkNotifier.refreshState;
  double get _pulledExtent => widget.linkNotifier.pulledExtent;
  double get _riggerPullDistance =>
      widget.linkNotifier.refreshTriggerPullDistance;
  Duration get _completeDuration => widget.linkNotifier.completeDuration;
  AxisDirection get _axisDirection => widget.linkNotifier.axisDirection;

  AnimationController _scaleController;
  Animation<double> _scaleFactor;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(vsync: this);
    _scaleFactor = _scaleController.drive(_oneToZeroTween);
  }

  @override
  void dispose() {
    super.dispose();
    _scaleController.dispose();
  }

  bool _refreshFinish = false;
  set refreshFinish(bool finish) {
    if (_refreshFinish != finish) {
      if (finish) {
        Future.delayed(_completeDuration - Duration(milliseconds: 300), () {
          if (mounted) {
            _scaleController.animateTo(1.0, duration: _kIndicatorScaleDuration);
          }
        });
        Future.delayed(_completeDuration, () {
          _refreshFinish = false;
          _scaleController.animateTo(0.0, duration: Duration(milliseconds: 10));
        });
      }
      _refreshFinish = finish;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isVertical = _axisDirection == AxisDirection.down ||
        _axisDirection == AxisDirection.up;
    bool isReverse = _axisDirection == AxisDirection.up ||
        _axisDirection == AxisDirection.left;
    double indicatorValue = _pulledExtent / (_riggerPullDistance / 0.75);
    indicatorValue = indicatorValue < 0.75 ? indicatorValue : 0.75;
    if (_refreshState == RefreshMode.refreshed) {
      refreshFinish = true;
    }
    return Container(
      height: isVertical
          ? _refreshState == RefreshMode.inactive ? 0.0 : _pulledExtent
          : double.infinity,
      width: !isVertical
          ? _refreshState == RefreshMode.inactive ? 0.0 : _pulledExtent
          : double.infinity,
      child: Stack(
        children: <Widget>[
          SpinKitCircle(
            // controller: _scaleController,
            color: AppColor.mainColor,
            size: 30.0,
          ),
        ],
      ),
    );
  }
}
