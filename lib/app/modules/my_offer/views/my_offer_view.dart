import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../controllers/my_offer_controller.dart';

class MyOfferView extends GetView<MyOfferController> {
  const MyOfferView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyOfferController controller = Get.put(MyOfferController());
    return GetBuilder<MyOfferController>(
        init: MyOfferController(),
        builder: (logic) {
          return Obx(() {
            return ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              opacity: 0,
              progressIndicator: customerIndicator,
              child: Scaffold(
                backgroundColor: color.white,
                appBar: commonWidget.customAppbar(
                  arroOnTap: () {
                    Get.back(result: 0);
                  },
                  titleText: "Your Offer",
                  actions: SizedBox(),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      controller.myOfferList.length == 0 && controller.isLoading.value == false
                          ? Column(
                              children: [
                                SizedBox(height: Get.height * 0.3),
                                Center(
                                  child: commonWidget.semiBoldText(
                                    "No Found Offer",
                                    fontsize: 18.0,
                                    tcolor: color.black,
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.myOfferList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.back(result: {
                                      'coupon_code': controller.myOfferList[index].couponCode,
                                      'coupon_id': controller.myOfferList[index].couponId,
                                      'discount': controller.myOfferList[index].discount,
                                    });
                                    // Get.to(() => ChatSupportView(), arguments: {'ticket_id': controller.supportList[index].ticketId, 'flag': 0});
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                    height: Get.height * 0.15,
                                    margin: EdgeInsets.only(bottom: 11, top: 10, left: 20, right: 20),
                                    //padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: color.fillColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: Get.height * 0.15,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              bottomLeft: Radius.circular(12),
                                            ),
                                            color: color.appColor,
                                          ),
                                          child: Center(
                                            child: RotatedBox(
                                              quarterTurns: 3,
                                              child: commonWidget.semiBoldText(
                                                "${controller.myOfferList[index].discount}% 0ff",
                                                fontsize: 18.0,
                                                tcolor: color.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    commonWidget.semiBoldText(
                                                      "${controller.myOfferList[index].couponCode}",
                                                      fontsize: 18.0,
                                                      tcolor: color.black,
                                                    ),
                                                    commonWidget.customButton(
                                                      height: 30.0,
                                                      width: Get.width / 4.5,
                                                      Ccolor: color.appColor,
                                                      Tcolor: Colors.white,
                                                      text: "APPLY",
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                commonWidget.regularText(
                                                  "Add ${controller.myOfferList[index].discount}% off your booking",
                                                  fontsize: 14.0,
                                                  tcolor: color.black,
                                                ),
                                                SizedBox(height: 7),
                                                commonWidget.semiBoldText(
                                                  "Get ${controller.myOfferList[index].discount}% off",
                                                  fontsize: 18.0,
                                                  tcolor: color.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
