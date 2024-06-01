import 'package:autotomi/app/modules/bottombar/views/bottombar_view.dart';
import 'package:autotomi/app/modules/home/views/home_view.dart';
import '../controllers/payment_successfull_controller.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSuccessfullView extends GetView<PaymentSuccessfullController> {
  const PaymentSuccessfullView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaymentSuccessfullController controller = Get.put(PaymentSuccessfullController());
    return GetBuilder<PaymentSuccessfullController>(
      assignId: true,
      init: PaymentSuccessfullController(),
      builder: (logic) {
        return Scaffold(
          backgroundColor: color.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: hw.height * 0.12),
                Container(
                  width: hw.width,
                  decoration: BoxDecoration(
                    color: color.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: color.grey.withOpacity(0.5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 27),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Image.asset(assetsUrl.PaymentSuccessfull, height: 115, width: 115)),
                        SizedBox(height: hw.height * 0.025),
                        commonWidget.semiBoldText('Payment successfully !', fontsize: 24.0),
                        SizedBox(height: hw.height * 0.025),
                        commonWidget.mediumText('Your Reserve has been successful', fontsize: 16.0),
                        SizedBox(height: hw.height * 0.025),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            commonWidget.regularText('Booking id : ', fontsize: 16.0),
                            commonWidget.semiBoldText('${controller.bookingID ?? "0"}', fontsize: 16.0),
                          ],
                        ),
                        SizedBox(height: hw.height * 0.025),
                        Divider(),
                        SizedBox(height: hw.height * 0.025),
                        commonWidget.regularText('Amount paid', fontsize: 16.0),
                        SizedBox(height: 10),
                        commonWidget.semiBoldText('£${controller.finalFare}', fontsize: 28.0),
                        SizedBox(height: hw.height * 0.025),
                        commonWidget.customButton(
                          onTap: () {
                            if (controller.returnFlag == 2) {
                              isReturnCar = 2;
                            } else {
                              isReturnCar = 1;
                            }

                            Get.offAll(BottombarView(), arguments: 1);
                          },
                          height: 48.0,
                          text: stringsUtils.Done,
                          textfontsize: 16.0,
                        ),
                        SizedBox(height: hw.height * 0.02),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
