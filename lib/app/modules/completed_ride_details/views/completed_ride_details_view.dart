import 'package:autotomi/app/modules/rentcardetails/views/rentcardetails_view.dart';
import 'package:autotomi/common/asset.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/CachedImageContainer.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import '../../../data/NetworkClint.dart';
import '../../allCarRatingReview/views/all_car_rating_review_view.dart';
import '../controllers/completed_ride_details_controller.dart';

class CompletedRideDetailsView extends GetView<CompletedRideDetailsController> {
  const CompletedRideDetailsView({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    CompletedRideDetailsController controller = Get.put(CompletedRideDetailsController());
    return GetBuilder<CompletedRideDetailsController>(
      assignId: true,
      init: CompletedRideDetailsController(),
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
                titleText: 'Your Completed Ride',
                actions: SizedBox(),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Color(0xffD4D4D4),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Container(
                                      height: 200,
                                      child: Swiper(
                                        loop: false,
                                        autoplay: false,
                                        itemBuilder: (BuildContext context, int index) {
                                          return CachedImageContainer(
                                            image: "$BaseUrl${controller.carImageList[index].image}",
                                            fit: BoxFit.cover,
                                            placeholder: assetsUrl.plashHolderFullCard,
                                            // flag: 1,
                                          );
                                        },
                                        itemCount: controller.carImageList.length,
                                        pagination: SwiperPagination(
                                          builder: DotSwiperPaginationBuilder(
                                            size: 7,
                                            activeSize: 7,
                                            color: color.white,
                                            activeColor: color.appColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        commonWidget.semiBoldText(controller.carName ?? '', fontsize: 20.0),
                                        SizedBox(height: 12),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(() => AllCarRatingReviewView(), arguments: {
                                                  'car_id': controller.carID,
                                                });
                                              },
                                              splashColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              child: Icon(
                                                Icons.star,
                                                size: 18,
                                                color: color.appColor,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() => AllCarRatingReviewView(), arguments: {
                                                  'car_id': controller.carID.toString(),
                                                });
                                              },
                                              splashColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              child: commonWidget.regularText(
                                                '${controller.starCount ?? ''}(${controller.reviewCount ?? ''} Reviews)',
                                                fontsize: 14.0,
                                              ),
                                            ),
                                            Spacer(),
                                            commonWidget.semiBoldText('View details', fontsize: 14.0, tcolor: color.appColor),
                                          ],
                                        ),
                                        SizedBox(height: 12),
                                        Divider(),
                                        SizedBox(height: 12),
                                        commonWidget.mediumText('Booking Summary', fontsize: 15.0),
                                        SizedBox(height: 15),
                                        Row(
                                          children: [
                                            Image.asset(assetsUrl.pickup, height: 24, width: 24),
                                            SizedBox(width: 15),
                                            commonWidget.mediumText('Pickup', fontsize: 15.0, tcolor: color.appColor),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            commonWidget.boldText(
                                              '  ：  ',
                                              fontsize: 15.0,
                                              tcolor: color.appColor,
                                            ),
                                            SizedBox(width: 10),
                                            Padding(
                                              padding: EdgeInsets.only(top: 5),
                                              child: commonWidget.semiBoldText(
                                                '${DateFormat('EE, dd MMM,').format(
                                                  DateTime.parse(controller.startDate.toString()),
                                                )} ${DateFormat('h:mma').format(
                                                  DateFormat('HH:mm').parse(controller.pickUpTime.toString()),
                                                )}',
                                                fontsize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(width: 40),
                                            Container(
                                              width: Get.width / 1.4,
                                              child: commonWidget.semiBoldText(
                                                '${controller.pickUpLocation}',
                                                fontsize: 16.0,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Row(
                                          children: [
                                            commonWidget.boldText(
                                              '  ：  ',
                                              fontsize: 15.0,
                                              tcolor: color.appColor,
                                            ),
                                            SizedBox(width: 10),
                                            commonWidget.mediumText('Drop-off', fontsize: 15.0, tcolor: color.appColor),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(assetsUrl.location, height: 24, width: 24),
                                            SizedBox(width: 15),
                                            Padding(
                                              padding: EdgeInsets.only(top: 5),
                                              child: commonWidget.semiBoldText(
                                                '${DateFormat('EE, dd MMM').format(DateTime.parse(controller.endDate ?? ''))}, ${DateFormat("h:mma").format(
                                                  DateFormat("hh:mm").parse(controller.dropTime.toString()),
                                                )}',
                                                fontsize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(width: 40),
                                            Container(
                                              width: Get.width / 1.4,
                                              child: commonWidget.semiBoldText(
                                                '${controller.dropLocation}',
                                                fontsize: 16.0,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        SizedBox(height: hw.height * 0.02),
                                        commonWidget.mediumText('Please review the final fare', fontsize: 15.0),
                                        SizedBox(height: hw.height * 0.02),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            commonWidget.regularText('Rented For', fontsize: 14.0),
                                            commonWidget.regularText('${controller.totalDay} Day', fontsize: 14.0),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Divider(),
                                        SizedBox(height: 5),
                                        Column(
                                          children: [
                                            controller.extraDays == null || controller.extraDays == 0
                                                ? SizedBox()
                                                : Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          commonWidget.regularText('Extra Day', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                          commonWidget.regularText('${controller.extraDays ?? '0'}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5),
                                                      Divider(),
                                                      SizedBox(height: 5),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          commonWidget.regularText('Extra Fee', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                          commonWidget.regularText('£${controller.extraPrice ?? '00'}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5),
                                                      Divider(),
                                                      SizedBox(height: 5),
                                                    ],
                                                  ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                commonWidget.regularText('Fare(Unlimited Kms without Fuel)', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                commonWidget.regularText('£${controller.totalFare ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Divider(),
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
                                            controller.bringCarMe == 0 ? SizedBox() : SizedBox(height: 5),
                                            controller.bringCarMe == 0 ? SizedBox() : Divider(),
                                            controller.bringCarMe == 0 ? SizedBox() : SizedBox(height: 5),
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
                                            //   crossAxisAlignment: CrossAxisAlignment.start,
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
                                            //   crossAxisAlignment: CrossAxisAlignment.start,
                                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //   children: [
                                            //     commonWidget.regularText('Convenience Fee', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                            //     commonWidget.regularText('+£${controller.convenienceFee ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                            //   ],
                                            // ),
                                            controller.comePickupCar == 0 ? SizedBox() : SizedBox(height: 5),
                                            controller.comePickupCar == 0 ? SizedBox() : Divider(),
                                            controller.comePickupCar == 0 ? SizedBox() : SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                commonWidget.semiBoldText("Total Fare", fontsize: 14.0, tcolor: color.black),
                                                commonWidget.semiBoldText(
                                                  '£${controller.showTotalFare = (controller.totalFare + controller.damageProtectionFee + controller.convenienceFee + controller.bringCarMe + controller.comePickupCar + controller.extraPrice) ?? ''}',
                                                  fontsize: 14.0,
                                                  tcolor: color.black,
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Divider(),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                commonWidget.regularText("Applied Coupon Discount\n(On Total Fare)", fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
                                                commonWidget.regularText('-£${controller.discountAmount ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
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
                                                commonWidget.semiBoldText('£${controller.showTotalFinalFare = (controller.securityDeposit + controller.showTotalFare - controller.discountAmount) ?? ''}', fontsize: 14.0, tcolor: color.black),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: commonWidget.customButton(
                      onTap: () {
                        Get.to(RentcardetailsView(), arguments: {'car_id': controller.carID});
                      },
                      height: 48.0,
                      text: 'BookCar Again',
                      textfontsize: 16.0,
                    ),
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}

// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(12),
// border: Border.all(
// color: Color(0xffD4D4D4),
// ),
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// ClipRRect(
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(10),
// topRight: Radius.circular(10),
// ),
// child: Container(
// height: 200,
// child: Swiper(
// autoplay: false,
// itemBuilder: (BuildContext context, int index) {
// return CachedImageContainer(
// image: "$BaseUrl${controller.carImageList[index].image}",
// fit: BoxFit.cover,
// placeholder: assetsUrl.plashHolderFullCard,
// // flag: 1,
// );
// },
// itemCount: controller.carImageList.length,
// pagination: SwiperPagination(
// builder: DotSwiperPaginationBuilder(
// size: 7,
// activeSize: 7,
// color: color.white,
// activeColor: color.appColor,
// ),
// ),
// ),
// ),
// ),
// SizedBox(height: 15),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 10.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// commonWidget.semiBoldText(controller.carName ?? '', fontsize: 20.0),
// SizedBox(height: 12),
// Row(
// children: [
// InkWell(
// onTap: () {
// Get.to(() => AllCarRatingReviewView(), arguments: {
// 'car_id': controller.carID.toString(),
// });
// },
// splashColor: Colors.transparent,
// highlightColor: Colors.transparent,
// child: Icon(
// Icons.star,
// size: 18,
// color: color.appColor,
// ),
// ),
// InkWell(
// onTap: () {
// Get.to(() => AllCarRatingReviewView(), arguments: {
// 'car_id': controller.carID.toString(),
// });
// },
// splashColor: Colors.transparent,
// highlightColor: Colors.transparent,
// child: commonWidget.regularText(
// '${controller.starCount ?? ''}(${controller.reviewCount ?? ''} Reviews)',
// fontsize: 14.0,
// ),
// ),
// Spacer(),
// commonWidget.semiBoldText('View details', fontsize: 14.0, tcolor: color.appColor),
// ],
// ),
// SizedBox(height: 12),
// Divider(),
// SizedBox(height: 12),
// commonWidget.mediumText('Booking Summary', fontsize: 15.0),
// SizedBox(height: 15),
// Row(
// children: [
// Image.asset(assetsUrl.pickup, height: 24, width: 24),
// SizedBox(width: 15),
// commonWidget.mediumText('Pickup', fontsize: 15.0, tcolor: color.appColor),
// ],
// ),
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// commonWidget.boldText(
// '  ：  ',
// fontsize: 15.0,
// tcolor: color.appColor,
// ),
// SizedBox(width: 10),
// // Padding(
// //   padding: const EdgeInsets.only(top: 5),
// //   child: commonWidget.semiBoldText('Wed, 17 Oct, 8AM', fontsize: 16.0),
// // ),
// Padding(
// padding: const EdgeInsets.only(top: 5),
// child: commonWidget.semiBoldText(
// '${DateFormat('EE, dd MMM,').format(
// DateTime.parse(controller.startDate.toString()),
// )} ${DateFormat('h:mma').format(
// DateFormat('HH:mm').parse(controller.pickUpTime.toString()),
// )}',
// fontsize: 16.0,
// ),
// ),
// ],
// ),
// SizedBox(height: 10),
// Row(
// children: [
// SizedBox(width: 40),
// commonWidget.semiBoldText('${controller.pickUpLocation}', fontsize: 16.0),
// ],
// ),
// SizedBox(height: 15),
// Row(
// children: [
// commonWidget.boldText(
// '  ：  ',
// fontsize: 15.0,
// tcolor: color.appColor,
// ),
// SizedBox(width: 10),
// commonWidget.mediumText('Drop-off', fontsize: 15.0, tcolor: color.appColor),
// ],
// ),
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Image.asset(assetsUrl.location, height: 24, width: 24),
// SizedBox(width: 15),
// // Padding(
// //   padding: const EdgeInsets.only(top: 5),
// //   child: commonWidget.semiBoldText('Wed, 17 Oct, 8AM', fontsize: 16.0),
// // ),
// Padding(
// padding: EdgeInsets.only(top: 5),
// child: commonWidget.semiBoldText(
// '${DateFormat('EE, dd MMM').format(DateTime.parse(controller.endDate ?? ''))}, ${DateFormat("h:mma").format(
// DateFormat("hh:mm").parse(controller.dropTime.toString()),
// )}',
// fontsize: 16.0,
// ),
// ),
// ],
// ),
// SizedBox(height: 10),
// Row(
// children: [
// SizedBox(width: 40),
// commonWidget.semiBoldText('${controller.dropLocation}', fontsize: 16.0),
// ],
// ),
// SizedBox(height: hw.height * 0.02),
// Divider(),
// SizedBox(height: hw.height * 0.02),
// commonWidget.mediumText('Please review the final fare', fontsize: 15.0),
// SizedBox(height: hw.height * 0.02),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// commonWidget.regularText('Rented For', fontsize: 14.0),
// commonWidget.regularText('${controller.totalDay} Day', fontsize: 14.0),
// ],
// ),
// SizedBox(height: hw.height * 0.02),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// commonWidget.regularText('Fare(Unlimited Kms without Fuel)', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
// commonWidget.regularText('£${controller.totalFare ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
// ],
// ),
// // SizedBox(height: 5),
// // Divider(),
// // SizedBox(height: 5),
// // Row(
// //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //   children: [
// //     commonWidget.regularText('Damage Protection Fee', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
// //     commonWidget.regularText('+£${controller.damageProtectionFee ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
// //   ],
// // ),
// // SizedBox(height: 5),
// // Divider(),
// // SizedBox(height: 5),
// // Row(
// //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //   children: [
// //     commonWidget.regularText('Convenience Fee', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
// //     commonWidget.regularText('+£${controller.convenienceFee ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
// //   ],
// // ),
// SizedBox(height: 5),
// Divider(),
// SizedBox(height: 5),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// commonWidget.semiBoldText("Total Fare", fontsize: 14.0, tcolor: color.black),
// commonWidget.semiBoldText(
// '£${controller.showTotalFare = (controller.totalFare + controller.damageProtectionFee + controller.convenienceFee) ?? ''}',
// fontsize: 14.0,
// tcolor: color.black,
// )
// ],
// ),
// SizedBox(height: 5),
// Divider(),
// SizedBox(height: 5),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// commonWidget.regularText("Damage Protection Fee", fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
// commonWidget.regularText('+£${controller.securityDeposit ?? ''}', fontsize: 14.0, tcolor: color.black.withOpacity(.5)),
// ],
// ),
// SizedBox(height: 5),
// Divider(),
// SizedBox(height: 5),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// commonWidget.semiBoldText("Final Fare", fontsize: 14.0, tcolor: color.black),
// commonWidget.semiBoldText('£${controller.showTotalFinalFare = (controller.securityDeposit + controller.showTotalFare) ?? ''}', fontsize: 14.0, tcolor: color.black),
// ],
// ),
// SizedBox(height: 8)
// ],
// ),
// ),
// ],
// ),
// ),
// SizedBox(height: hw.height * 0.03),
// ],
// ),
