import 'dart:ffi';

import 'package:autotomi/app/modules/completed_ride_details/views/completed_ride_details_view.dart';
import 'package:autotomi/app/modules/ratingReview/views/rating_review_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/CachedImageContainer.dart';
import '../../../data/NetworkClint.dart';
import '../../allCarRatingReview/views/all_car_rating_review_view.dart';
import '../controllers/completed_ride_controller.dart';
import 'package:autotomi/common/asset.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class CompletedRideView extends GetView<CompletedRideController> {
  const CompletedRideView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompletedRideController>(
      assignId: true,
      init: CompletedRideController(),
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
              body: SingleChildScrollView(
                controller: controller.scroll_controller,
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.listMyCarList.length == 0 && controller.isLoading.value == false
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: Center(child: commonWidget.semiBoldText('No Data Found', fontsize: 20.0)),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.listMyCarList.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => CompletedRideDetailsView(), arguments: {
                                      'car_id': controller.listMyCarList[index].carId,
                                      'booking_id': controller.listMyCarList[index].bookingId,
                                      'car_image': controller.listMyCarList[index].carImage,
                                      'car_name': controller.listMyCarList[index].carName,
                                      'star_count': controller.listMyCarList[index].starCount,
                                      'review_count': controller.listMyCarList[index].reviewCount,
                                      'start_date': controller.listMyCarList[index].startDate,
                                      'pick_time': controller.listMyCarList[index].pickupTime,
                                      'end_date': controller.listMyCarList[index].endDate,
                                      'drop_time': controller.listMyCarList[index].dropoffTime,
                                      'fare_unlimited_kms': controller.listMyCarList[index].totalFare,
                                      'damage_protection_fee': controller.listMyCarList[index].damageProtectionFee,
                                      'convenience_fee': controller.listMyCarList[index].convenienceFee,
                                      'total_fare': controller.listMyCarList[index].totalFare,
                                      'security_deposit': controller.listMyCarList[index].securityDeposit,
                                      'final_fare': controller.listMyCarList[index].finalFare,
                                      'per_day_price': controller.listMyCarList[index].pricePerDay,
                                      'per_week_price': controller.listMyCarList[index].pricePerWeek,
                                      'drop_location': controller.listMyCarList[index].dropoffLocation,
                                      'pickUp_location': controller.listMyCarList[index].pickupLocation,
                                      'bring_car_me': controller.listMyCarList[index].bringCarMe,
                                      'come_pickup_car': controller.listMyCarList[index].comePickupCar,
                                      'extra_price': controller.listMyCarList[index].extraPrice,
                                      'extra_days': controller.listMyCarList[index].extraDays,
                                      'discount_amount': controller.listMyCarList[index].discountAmount,
                                    });
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Color(0xffD4D4D4),
                                        )),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: CachedImageContainer(
                                                  image: "$BaseUrl${controller.listMyCarList[index].carImage![0].image}",
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
                                                  commonWidget.semiBoldText(controller.listMyCarList[index].carName.toString(), fontsize: 20.0),
                                                  SizedBox(height: 8),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(() => AllCarRatingReviewView(), arguments: {
                                                        'car_id': controller.listMyCarList[index].carId.toString(),
                                                      });
                                                    },
                                                    splashColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.star, color: color.appColor, size: 18),
                                                        SizedBox(width: 6),
                                                        commonWidget.regularText('${controller.listMyCarList[index].starCount}(${controller.listMyCarList[index].reviewCount} Review)', fontsize: 12.0),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: hw.height * 0.016),
                                          Row(
                                            children: [
                                              commonWidget.regularText('Booking id ', fontsize: 16.0),
                                              commonWidget.semiBoldText(': ${controller.listMyCarList[index].bookingId}', fontsize: 16.0),
                                              Spacer(),
                                              commonWidget.semiBoldText('Completed', fontsize: 16.0, tcolor: color.appColor),
                                            ],
                                          ),
                                          SizedBox(height: hw.height * 0.016),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              commonWidget.regularText('Total Fare', fontsize: 14.0),
                                              commonWidget.semiBoldText('£${controller.listMyCarList[index].finalFare} Total', fontsize: 16.0),
                                            ],
                                          ),
                                          SizedBox(height: hw.height * 0.016),
                                          Divider(),
                                          controller.listMyCarList[index].review!.length != 0
                                              ? Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    commonWidget.regularText(
                                                      "${controller.listMyCarList[index].review![0].reviewText}",
                                                      fontsize: 14.0,
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        RatingBar(
                                                          ignoreGestures: true,
                                                          ratingWidget: RatingWidget(
                                                            // full: Icon(Icons.star, color: Colors.amber),
                                                            full: Image.asset(assetsUrl.starRatingImage),
                                                            half: Image.asset(assetsUrl.starRatingBlank),
                                                            empty: Image.asset(assetsUrl.starRatingBlank),
                                                          ),
                                                          initialRating: controller.listMyCarList[index].review![0].noOfStar!.toDouble(),
                                                          minRating: 0,
                                                          itemSize: 14,
                                                          direction: Axis.horizontal,
                                                          allowHalfRating: false,
                                                          updateOnDrag: false,
                                                          itemCount: 5,
                                                          unratedColor: color.white,
                                                          itemPadding: EdgeInsets.symmetric(horizontal: 2),
                                                          onRatingUpdate: (double value) {},
                                                        ),
                                                        SizedBox(width: 5),
                                                        CachedImageContainer(
                                                          image: "$BaseUrl${controller.listMyCarList[index].review![0].profilePic}",
                                                          fit: BoxFit.cover,
                                                          circular: 90.0,
                                                          topCorner: 90.0,
                                                          bottomCorner: 90.0,
                                                          height: 22,
                                                          width: 22,
                                                          placeholder: assetsUrl.plashHolder,
                                                          // flag: 1,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Container(
                                                          width: Get.width * 0.19,
                                                          child: commonWidget.regularText(
                                                            "${controller.listMyCarList[index].review![0].firstName} ${controller.listMyCarList[index].review![0].lastName}",
                                                            fontsize: 12.0,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(width: 3),
                                                        commonWidget.regularText(
                                                          timeago.format(DateTime.parse(controller.listMyCarList[index].review![0].createdAt.toString())),
                                                          fontsize: 12.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    Get.to(() => RatingReviewView(), arguments: {'booking_id': controller.listMyCarList[index].bookingId});
                                                  },
                                                  splashColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  child: commonWidget.semiBoldText(
                                                    'Write a review',
                                                    fontsize: 15.0,
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                      Obx(() {
                        return controller.isLoadMoreRunning.value == true ? Center(child: customerIndicator) : Container();
                      })
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
