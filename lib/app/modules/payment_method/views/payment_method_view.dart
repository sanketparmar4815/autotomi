import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/my_offer/views/my_offer_view.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:autotomi/common/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import '../controllers/payment_method_controller.dart';

class PaymentMethodView extends GetView<PaymentMethodController> {
  const PaymentMethodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaymentMethodController controller = Get.put(PaymentMethodController());
    return GetBuilder<PaymentMethodController>(
      assignId: true,
      init: PaymentMethodController(),
      builder: (logic) {
        return Obx(() {
          return ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            opacity: 0,
            progressIndicator: customerIndicator,
            child: Scaffold(
              backgroundColor: color.white,
              appBar: commonWidget.customAppbar(
                fontsize: 20.0,
                arroOnTap: () {
                  Get.back();
                },
                titleText: 'Payment Options',
                actions: SizedBox(),
                centerTitle: false,
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.flag == 5
                                ? Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          width: 1.5,
                                          color: color.grey.withOpacity(0.3),
                                        )),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(6),
                                                    child: CachedImageContainer(
                                                      image: "$BaseUrl${controller.carImage}",
                                                      fit: BoxFit.cover,
                                                      height: 57,
                                                      width: 85,
                                                      placeholder: assetsUrl.plashHolderFullCard,
                                                      // flag: 1,
                                                    ),
                                                  ),
                                                  SizedBox(width: 12),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      commonWidget.semiBoldText(controller.carName ?? '', fontsize: 20.0),
                                                      SizedBox(height: 8),
                                                      Container(
                                                        width: Get.width * 0.57,
                                                        child: commonWidget.regularText(
                                                            '${DateFormat('EE, dd MMM').format(DateTime.parse(controller.startDate.toString() ?? ''))},${DateFormat("h:mma").format(
                                                              DateFormat("hh:mm").parse(controller.pickUpTime.toString()),
                                                            )}  -  ${DateFormat('EE, dd MMM').format(DateTime.parse(controller.endDate ?? ''))},${DateFormat("h:mma").format(
                                                              DateFormat("hh:mm").parse(controller.dropTime.toString()),
                                                            )}',
                                                            fontsize: 12.0,
                                                            maxLines: 2),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: hw.height * 0.016),
                                              commonWidget.mediumText('Please review the final fare', fontsize: 15.0),
                                              SizedBox(height: hw.height * 0.02),
                                              controller.flag == 0
                                                  ? SizedBox()
                                                  : Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        commonWidget.regularText('Rented For', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                        commonWidget.regularText('${controller.totalDay} Day', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                      ],
                                                    ),
                                              controller.flag == 0 ? SizedBox() : SizedBox(height: hw.height * 0.02),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  commonWidget.regularText('Fare(Unlimited Kms without Fuel)', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                  commonWidget.regularText('£${controller.fareUnlimitedKms ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                ],
                                              ),
                                              controller.bringCarMe == 0 ? SizedBox() : SizedBox(height: 5),
                                              controller.bringCarMe == 0 ? SizedBox() : Divider(),
                                              controller.bringCarMe == 0 ? SizedBox() : SizedBox(height: 5),
                                              controller.bringCarMe == 0
                                                  ? SizedBox()
                                                  : Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: Get.width / 1.3,
                                                          child: commonWidget.regularText(
                                                            'BRING THE CAR TO ME\n(attract additional cost)',
                                                            fontsize: 14.0,
                                                            tcolor: color.black.withOpacity(.5),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        commonWidget.regularText('+£${controller.bringCarMe ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                      ],
                                                    ),
                                              controller.comePickupCar == 0 ? SizedBox() : SizedBox(height: 5),
                                              controller.comePickupCar == 0 ? SizedBox() : Divider(),
                                              SizedBox(height: 5),
                                              controller.comePickupCar == 0
                                                  ? SizedBox()
                                                  : Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: Get.width / 1.3,
                                                          child: commonWidget.regularText(
                                                            'Come and pick up the car\n(attract additional cost)',
                                                            fontsize: 14.0,
                                                            tcolor: color.black.withOpacity(.5),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        commonWidget.regularText('+£${controller.comePickupCar ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                      ],
                                                    ),
                                              // SizedBox(height: 5),
                                              // Divider(),
                                              // SizedBox(height: 5),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     commonWidget.regularText('Damage Protection Fee', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                              //     commonWidget.regularText('+£${controller.damageProtectionFee ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                              //   ],
                                              // ),
                                              // SizedBox(height: 5),
                                              // Divider(),
                                              // SizedBox(height: 5),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     commonWidget.regularText('Convenience Fee', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                              //     commonWidget.regularText('+£${controller.convenienceFee ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                              //   ],
                                              // ),
                                              Divider(),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  commonWidget.regularText("Damage Protection Fee", fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                  commonWidget.regularText('+£${controller.securityDeposit ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                ],
                                              ),
                                              Divider(),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  commonWidget.regularText("Applied Coupon Discount\n(Total Fare)", fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                  commonWidget.regularText('-£${controller.discountAmountOnlShow}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Divider(),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  commonWidget.semiBoldText("Total Fare", fontsize: 14.0, tcolor: color.black),
                                                  commonWidget.semiBoldText('£${controller.showFinalFare - controller.discountAmountOnlShow ?? ''}', fontsize: 14.0, tcolor: color.black),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.black,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  commonWidget.semiBoldText("Extra Time", fontsize: 14.0, tcolor: color.black),
                                                  commonWidget.semiBoldText('${controller.extraDay ?? ''} Day', fontsize: 14.0, tcolor: color.black),
                                                ],
                                              ),
                                              Divider(),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  commonWidget.semiBoldText("Addition Cost", fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                  commonWidget.semiBoldText('£${controller.extraPrice ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                ],
                                              ),
                                              Divider(),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  commonWidget.semiBoldText("Final Fare", fontsize: 14.0, tcolor: color.black),
                                                  commonWidget.semiBoldText('£${controller.totalFinalFare ?? ''}', fontsize: 14.0, tcolor: color.black),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          width: 1.5,
                                          color: color.grey.withOpacity(0.3),
                                        )),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(6),
                                                child: CachedImageContainer(
                                                  image: "$BaseUrl${controller.carImage}",
                                                  fit: BoxFit.cover,
                                                  height: 57,
                                                  width: 85,
                                                  placeholder: assetsUrl.plashHolderFullCard,
                                                  // flag: 1,
                                                ),
                                              ),
                                              SizedBox(width: 12),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  commonWidget.semiBoldText(controller.carName ?? '', fontsize: 20.0),
                                                  SizedBox(height: 8),
                                                  Container(
                                                    width: Get.width * 0.57,
                                                    child: commonWidget.regularText(
                                                        '${DateFormat('EE, dd MMM').format(DateTime.parse(controller.startDate.toString() ?? ''))},${DateFormat("h:mma").format(
                                                          DateFormat("hh:mm").parse(controller.pickUpTime.toString()),
                                                        )}  -  ${DateFormat('EE, dd MMM').format(DateTime.parse(controller.endDate ?? ''))},${DateFormat("h:mma").format(
                                                          DateFormat("hh:mm").parse(controller.dropTime.toString()),
                                                        )}',
                                                        fontsize: 12.0,
                                                        maxLines: 2),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: hw.height * 0.016),
                                          commonWidget.mediumText('Please review the final fare', fontsize: 15.0),
                                          SizedBox(height: hw.height * 0.02),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              commonWidget.regularText('Fare(Unlimited Kms without Fuel)', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                              commonWidget.regularText('£${controller.fareUnlimitedKms ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                            ],
                                          ),
                                          controller.bringCarMe == 0 ? SizedBox() : SizedBox(height: 5),
                                          controller.bringCarMe == 0 ? SizedBox() : Divider(),
                                          SizedBox(height: 5),
                                          controller.bringCarMe == 0
                                              ? SizedBox()
                                              : Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: Get.width / 1.3,
                                                      child: commonWidget.regularText(
                                                        'BRING THE CAR TO ME\n(attract additional cost)',
                                                        fontsize: 14.0,
                                                        tcolor: color.black.withOpacity(.5),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    commonWidget.regularText('+£${controller.bringCarMe ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                  ],
                                                ),
                                          controller.comePickupCar == 0 ? SizedBox() : SizedBox(height: 5),
                                          controller.comePickupCar == 0 ? SizedBox() : Divider(),
                                          controller.comePickupCar == 0 ? SizedBox() : SizedBox(height: 5),
                                          controller.comePickupCar == 0
                                              ? SizedBox()
                                              : Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: Get.width / 1.3,
                                                      child: commonWidget.regularText(
                                                        'Come and pick up the car\n(attract additional cost)',
                                                        fontsize: 14.0,
                                                        tcolor: color.black.withOpacity(.5),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    commonWidget.regularText('+£${controller.comePickupCar ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                  ],
                                                ),
                                          // SizedBox(height: 5),
                                          // Divider(),
                                          // SizedBox(height: 5),
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     commonWidget.regularText('Damage Protection Fee', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                          //     commonWidget.regularText('+£${controller.damageProtectionFee ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                          //   ],
                                          // ),
                                          // SizedBox(height: 5),
                                          // Divider(),
                                          // SizedBox(height: 5),
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     commonWidget.regularText('Convenience Fee', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                          //     commonWidget.regularText('+£${controller.convenienceFee ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                          //   ],
                                          // ),
                                          SizedBox(height: 5),
                                          Divider(),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              commonWidget.semiBoldText("Total Fare", fontsize: 14.0, tcolor: color.black),
                                              commonWidget.semiBoldText('£${controller.showTotalFare ?? ''}', fontsize: 14.0, tcolor: color.black),
                                            ],
                                          ),
                                          Divider(),
                                          SizedBox(height: 5),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              commonWidget.regularText("Applied Coupon Discount\n(On Total Fare)", fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                              controller.couponCode == null
                                                  ? SizedBox()
                                                  : InkWell(
                                                      onTap: () {
                                                        controller.showFinalFare = controller.showFinalFare + controller.addCoupon;
                                                        controller.addCoupon = 0.0;
                                                        controller.returnOfferFlag = null;
                                                        controller.couponCode = null;
                                                        controller.couponID = null;
                                                        controller.couponDiscount = null;
                                                        controller.update();
                                                      },
                                                      splashColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      child: commonWidget.semiBoldText(
                                                        " Remove",
                                                        fontsize: 14.0,
                                                        tcolor: color.red_color,
                                                      ),
                                                    ),
                                              Spacer(),
                                              commonWidget.regularText('-£${controller.addCoupon.toStringAsFixed(1) ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Divider(),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              commonWidget.regularText("Damage Protection Fee", fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                              commonWidget.regularText('+£${controller.securityDeposit ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Divider(),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              commonWidget.semiBoldText("Final Fare", fontsize: 14.0, tcolor: color.black),
                                              commonWidget.semiBoldText('£${controller.showFinalFare ?? ''}', fontsize: 14.0, tcolor: color.black),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            controller.flag == 5 ? SizedBox() : SizedBox(height: 15),
                            controller.flag == 5
                                ? SizedBox()
                                : InkWell(
                                    onTap: () {
                                      Get.to(() => MyOfferView())!.then((value) {
                                        if (value != 0) {
                                          if (controller.addCoupon == 0.0) {
                                            controller.showFinalFare = controller.showFinalFare - controller.addCoupon;
                                          } else {
                                            controller.showFinalFare = controller.showFinalFare + controller.addCoupon;
                                          }
                                          controller.returnOfferFlag = value['flag'];
                                          controller.couponCode = value['coupon_code'];
                                          controller.couponID = value['coupon_id'];
                                          controller.couponDiscount = value['discount'];
                                          controller.addCoupon = (controller.showTotalFare / 100) * controller.couponDiscount;
                                          print(controller.addCoupon);
                                          print("discount");

                                          controller.showFinalFare = controller.showFinalFare - controller.addCoupon;
                                          controller.update();
                                        }
                                        // if (value != null) {
                                        //   controller.addCoupon = 0;
                                        //   controller.returnOfferFlag = value['flag'];
                                        //   controller.couponCode = value['coupon_code'];
                                        //   controller.couponID = value['coupon_id'];
                                        //   controller.couponDiscount = value['discount'];
                                        // }

                                        controller.update();
                                      });
                                    },
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        commonWidget.semiBoldText(
                                          "View all coupon",
                                          fontsize: 18.0,
                                          tcolor: color.appColor,
                                        ),
                                        SizedBox(width: 7),
                                        Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          color: color.appColor,
                                          size: 28,
                                        )
                                      ],
                                    ),
                                  ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                    commonWidget.customButton(
                      onTap: () {
                        controller.flag == 3 ? Get.back() : controller.createPaymentIntent_Api();
                        controller.update();
                      },
                      text: 'Make a Payment',
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

// showDialog(
//   context: context,
//   builder: (BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9.0))),
//       contentPadding: EdgeInsets.only(top: 10.0),
//       content: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(9),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset("assets/images/applyCouponCode.png", height: 150, width: 150),
//               commonWidget.semiBoldText(
//                 "Your Coupon Code Apply Successful!",
//                 fontsize: 16.0,
//                 textAlign: TextAlign.center,
//                 height: 1.5,
//               ),
//               SizedBox(height: 5),
//               Divider(),
//               SizedBox(height: 5),
//               commonWidget.semiBoldText(
//                 "BLUEBELL100FF",
//                 fontsize: 18.0,
//                 textAlign: TextAlign.center,
//                 height: 1.5,
//               ),
//               SizedBox(height: 10),
//               commonWidget.regularText(
//                 "Save £20 Off Your Booking",
//                 fontsize: 16.0,
//                 textAlign: TextAlign.center,
//                 height: 1.5,
//               ),
//               SizedBox(height: 20),
//               commonWidget.customButton(
//                 onTap: () {
//                   Get.back();
//                 },
//                 height: 48.0,
//                 text: "OK",
//                 textfontsize: 16.0,
//               ),
//               SizedBox(height: 15),
//             ],
//           ),
//         ),
//       ),
//     );
//   },
// );
