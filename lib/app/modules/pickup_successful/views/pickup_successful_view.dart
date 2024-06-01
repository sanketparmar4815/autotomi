import 'package:animate_do/animate_do.dart';
import 'package:autotomi/app/modules/home/views/home_view.dart';
import 'package:autotomi/app/routes/app_pages.dart';
import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pickup_successful_controller.dart';

class PickupSuccessfulView extends GetView<PickupSuccessfulController> {
  const PickupSuccessfulView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PickupSuccessfulController>(
      assignId: true,
      init: PickupSuccessfulController(),
      builder: (logic) {
        return Scaffold(
          backgroundColor: color.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(height: hw.height * 0.3),
                ElasticIn(
                  duration: Duration(seconds: 3),
                  child: ZoomIn(
                    duration: Duration(milliseconds: 200),
                    child: Center(
                      child: Image.asset(assetsUrl.pickup_Car, height: 140, width: 140),
                    ),
                  ),
                ),
                SizedBox(height: hw.height * 0.05),
                commonWidget.semiBoldText(controller.flag == 2 || controller.flag == 3 ? "Thank you! for using and returning our ride safely" : 'Thank you! for renting car from Autotomi.', fontsize: 22.0, textAlign: TextAlign.center),
                SizedBox(height: 12),
                commonWidget.mediumText(
                  controller.flag == 2 || controller.flag == 3 ? "Your deposit amount refund is £50.00. It will be credited to your account in 30 minutes" : 'Remember to drive carefully, We wish you a happy holiday.',
                  fontsize: 16.0,
                  textAlign: TextAlign.center,
                  height: 1.5,
                ),
                SizedBox(height: hw.height * 0.03),
                commonWidget.customButton(
                  onTap: () {
                    if (controller.flag != 2 && controller.flag != 3) {
                      isReturnCar = 2;
                    } else {
                      isReturnCar = 3;
                    }
                    controller.flag == 2 || controller.flag == 3
                        ? Get.offAllNamed(Routes.RATING_REVIEW, arguments: {
                            'booking_id': controller.bookingID,
                          })
                        : Get.offAllNamed(Routes.BOTTOMBAR, arguments: 1);
                  },
                  text: controller.flag == 2 || controller.flag == 3 ? "Write a Review" : 'Done',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
