import 'package:flutter/material.dart';
import 'package:scriptkill/base/app_assets.dart';
import 'package:scriptkill/base/app_layout.dart';
import 'package:scriptkill/base/app_routes.dart';
import 'package:scriptkill/base/app_user.dart';
import 'package:scriptkill/util/util_router.dart';

class GuidePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  final guideImages = [
    AppAsset.guide_1,
    AppAsset.guide_2,
    AppAsset.guide_3,
  ];

  PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: PageView.builder(
          itemBuilder: ((context, index) {
            return GestureDetector(
              child: Image.asset(
                guideImages[index],
                fit: BoxFit.cover,
                width: AppLayout.screenWidth,
                height: AppLayout.screenHeight,
              ),
              onTap: () => {
                if (index == guideImages.length - 1)
                  {
                    if (AppUser.isLogin() == true)
                      {
                        AppRouter().navigateTo(
                            context, PageNames.tabbar.toString(),
                            clearStack: true)
                      }
                    else
                      {
                        AppRouter().navigateTo(
                            context, PageNames.login.toString(),
                            clearStack: true)
                      }
                  }
              },
            );
          }),
          itemCount: guideImages.length,
          controller: _controller,
        ));
  }
}
