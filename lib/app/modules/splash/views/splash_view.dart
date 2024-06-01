import 'package:autotomi/common/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      assignId: true,
      init: SplashController(),
      builder: (logic) {
        return Scaffold(
          body: Center(
            child: Image.asset(
              assetsUrl.splashLogoNew,
              height: Get.height,
              width: Get.width,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
