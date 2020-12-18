import 'dart:io';
import 'dart:convert';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:scriptkill/base/app_config.dart';

const String key_wechat_appid = AppConfig.key_wechat_appid;
const String key_wechat_secret = AppConfig.key_wechat_secret;
const String key_wechat_universalLink = AppConfig.key_wechat_universalLink;

class AppWechat {
  static setup() {
    fluwx.registerWxApi(
        appId: key_wechat_appid, universalLink: key_wechat_universalLink);
  }

  static loginWechat(Function(Map<String, dynamic> userInfo) success,
      Function(String errStr) failed) async {
    if (await fluwx.isWeChatInstalled == true) {
      sendWeChatAuth(
          (code) => {
                getAccessToken(
                    code,
                    (token, openid) => {
                          getUserinfo(
                              token,
                              openid,
                              (userInfo) => {success(userInfo)},
                              (errStr) => {failed(errStr)})
                        },
                    (errStr) => {print(errStr)})
              },
          (errStr) => print(errStr));
    } else {
      var userInfo = {
        "openid": "oo98c1Nw4C1u53eN7Bl5tbkLxlcw",
        "nickname": "Gavin",
        "sex": 1,
        "language": "zh_CN",
        "city": "Zhuhai",
        "province": "Guangdong",
        "country": "CN",
        "headimgurl":
            "http://thirdwx.qlogo.cn/mmopen/vi_32/6rIicDHZssMZOnhCBgoKOLoRJMnsKicBZ5Qkq7skUicnSrxMiaBC43zGJk7MwWMntIbmVicnlGloFOyBx71jOl5oRKg/132",
        "privilege": ["chinaunicom"],
        "unionid": "omC0F1oGYw97KaDJIPAJdRARhYww",
      };
      success(userInfo);
    }
  }

  static sendWeChatAuth(
      Function(String code) success, Function(String errStr) failed) async {
    print("微信登录");
    if (await fluwx.isWeChatInstalled == false) failed("未安装微信");
    bool isOk = await fluwx.sendWeChatAuth(
        scope: "snsapi_userinfo", state: "ScriptKill");
    if (isOk == false) failed("请求微信授权失败");
    fluwx.weChatResponseEventHandler.distinct((a, b) => a != b).listen((res) {
      if (res.errCode == 0) {
        if (res is fluwx.WeChatAuthResponse) {
          success(res.code);
        }
      } else {
        failed(res.errStr);
      }
    });
  }

  static getAccessToken(
      String code,
      Function(String token, String openid) success,
      Function(String errStr) failed) async {
    var httpClient = HttpClient();
    var uri = Uri.https('api.weixin.qq.com', '/sns/oauth2/access_token', {
      'appid': key_wechat_appid,
      'secret': key_wechat_secret,
      'code': code,
      'grant_type': 'authorization_code'
    });
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var json = await response.transform(utf8.decoder).join();
    var data = jsonDecode(json);
    print(data);
    if ((data as Map).containsKey("access_token")) {
      success(data["access_token"], data["openid"]);
    } else {
      failed("获取access_token失败");
    }
  }

  static getUserinfo(
      String token,
      String openid,
      Function(Map<String, dynamic> userInfo) success,
      Function(String errStr) failed) async {
    var httpClient = HttpClient();
    var uri = Uri.https('api.weixin.qq.com', '/sns/userinfo', {
      'access_token': token,
      'openid': openid,
    });
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var json = await response.transform(utf8.decoder).join();
    var data = jsonDecode(json);
    print(data);
    if (data is Map) {
      success(data);
    } else {
      failed("获取用户信息失败");
    }
  }
}

// flutter: {access_token: 36_i2PkPtCogIxlKqsfu-roFU1YuaJf1h7bd0-lFdiDu9B2HAuE4_-sJtfk2pFJZHHrYc7Lmxj8VCquTZFr3lgetPa3V3Rh7Z9oBuiCVGRvVEs, expires_in: 7200, refresh_token: 36_yVBuZM6Eh5JZ6AvtkCfGT9ZVjEMWuEF_oamfo1PGT9psl-BKQYYgId3VkM-Eq6NmvpcKNmX-VvETF4Ow18uP5VB7aZhLTxp4QTQdkQByqRY, openid: oo98c1Nw4C1u53eN7Bl5tbkLxlcw, scope: snsapi_userinfo, unionid: omC0F1oGYw97KaDJIPAJdRARhYww}
