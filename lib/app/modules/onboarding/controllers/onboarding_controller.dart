import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../common/asset.dart';

class OnboardingController extends GetxController {
  var Selectindex = 0.obs;

  PageController pageController = PageController();

  List onboarding_data = [
    {
      "Image": assetsUrl.onBording1,
      "text1": 'Book a ride abroad roam with it Local',
      "text2": "Convenient locations just a short walk  away.",
    },
    {
      "Image": assetsUrl.onBording2,
      "text1": 'Rent a perfect car for any occasion',
      "text2": "Enjoy the comforts of a rental car with the ease of booking it here.",
    },
    {
      "Image": assetsUrl.onBording3,
      "text1": 'Need a car?\nRent it quickly now!',
      "text2": "You can choose your ideal car and book it easily with us.",
    }
  ];

  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
    );
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
