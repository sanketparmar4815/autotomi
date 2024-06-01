import 'package:autotomi/app/modules/login/views/login_view.dart';
import 'package:autotomi/common/PrefsKey.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../availability_car/views/availability_car_view.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      assignId: true,
      init: OnboardingController(),
      builder: (logic) {
        return Scaffold(
          backgroundColor: color.appColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.onboarding_data.length,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    controller.Selectindex.value = value;
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // SizedBox(
                        //   height: hw.height * 0.13,
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            width: hw.width,
                            height: hw.height * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: AssetImage(
                                  controller.onboarding_data[index]["Image"],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(height: hw.height * 0.08),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: hw.width * 0.07),
                          child: Column(
                            children: [
                              commonWidget.semiBoldText(
                                controller.onboarding_data[index]["text1"],
                                tcolor: color.white,
                                textAlign: TextAlign.center,
                                fontsize: 32.0,
                              ),
                              SizedBox(height: hw.height * 0.025),
                              commonWidget.regularText(
                                controller.onboarding_data[index]["text2"],
                                tcolor: color.white,
                                textAlign: TextAlign.center,
                                fontsize: 16.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Center(
                child: Container(
                  height: 8,
                  width: 150,
                  child: Padding(
                    padding: EdgeInsets.only(left: 60),
                    child: ListView.builder(
                      itemCount: controller.onboarding_data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Obx(() {
                          return Container(
                            decoration: BoxDecoration(
                              color: controller.Selectindex.value == index ? color.white : Color(0xffD9D9D9).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.only(right: 7),
                            height: 8,
                            width: 8,
                          );
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: hw.height * 0.05,
              ),
              Obx(() {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: hw.width * 0.07, vertical: 12),
                  child: controller.Selectindex.value == 0 || controller.Selectindex.value == 1
                      ? SafeArea(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  box.write(PrefsKey.Onboarding, '1');

                                  Get.offAll(() => AvailabilityCarView());
                                },
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Container(
                                  height: 30,
                                  width: 58,
                                  alignment: Alignment.centerLeft,
                                  // color: Colors.red,
                                  child: commonWidget.semiBoldText(
                                    'Skip',
                                    fontsize: 14.0,
                                    tcolor: color.white,
                                  ),
                                ),
                              ),
                              commonWidget.customButton(
                                text: 'Next',
                                onTap: () {
                                  if (controller.Selectindex.value == 0) {
                                    controller.pageController.animateToPage(
                                      controller.pageController.page!.toInt() + 1,
                                      duration: Duration(milliseconds: 100),
                                      curve: Curves.easeIn,
                                    );
                                  } else if (controller.Selectindex.value == 1) {
                                    controller.pageController.animateToPage(
                                      controller.pageController.page!.toInt() + 1,
                                      duration: Duration(milliseconds: 100),
                                      curve: Curves.easeIn,
                                    );
                                  }
                                  controller.update();
                                },
                                height: 38.0,
                                width: 86.0,
                                cornerRadius: 4.0,
                                Ccolor: color.white,
                                Tcolor: color.appColor,
                              )
                            ],
                          ),
                        )
                      : commonWidget.customButton(
                          text: 'Let’s Start',
                          onTap: () {
                            box.write(PrefsKey.Onboarding, '1');
                            Get.offAll(() => AvailabilityCarView());
                          },
                          height: 48.0,
                          width: hw.width,
                          cornerRadius: 8.0,
                          Ccolor: color.white,
                          Tcolor: color.black,
                        ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
