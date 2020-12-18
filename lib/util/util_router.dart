import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:scriptkill/base/app_routes.dart';

class AppRouter {
  // 路由
  Router router = new Router();
  AppRouter._internal() {}

  // 单例
  static AppRouter get instance => _getInstance();
  factory AppRouter() => _getInstance();
  static AppRouter _instance;
  static AppRouter _getInstance() {
    if (_instance == null) {
      _instance = AppRouter._internal();
    }
    return _instance;
  }

  // 导航
  Future navigateTo(BuildContext context, String path,
      {Map<String, dynamic> params,
      bool replace = false,
      bool clearStack = false,
      TransitionType transition = TransitionType.native}) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
    path = path + query;
    print('路由：${Uri.decodeComponent(path)}');
    return router.navigateTo(context, path,
        replace: replace, clearStack: clearStack, transition: transition);
  }

  // 返回
  void goBack(BuildContext context, {result}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.pop(context, result);
  }

  // 生成 Handler
  static Handler handler(Function(Map<String, String> data) f) {
    return Handler(handlerFunc: (context, params) {
      Map<String, String> m = {};
      params.forEach((key, value) {
        m[key] = value?.first;
      });
      return f(m);
    });
  }
}
