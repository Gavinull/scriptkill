import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

//    WXApi.startLog(by: .detail) { (l) in
//        print(l);
//    }
//   var f = WXApi.registerApp("wx88b4bb53bcd4405d", universalLink: "https://ssl.ehomecare.cn/")
//
////    WXApi.checkUniversalLinkReady { (step, re) in
////        print("\(step)" ,"\(re)")
////    }
//    DispatchQueue.main.asyncAfter(deadline: .now()+5) {
//      var f =  WXApi.openWXApp();
//    }



    self.window.backgroundColor = .white
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
