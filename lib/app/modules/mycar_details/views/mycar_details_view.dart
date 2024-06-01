import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/allCarRatingReview/views/all_car_rating_review_view.dart';
import 'package:autotomi/app/modules/buyMoreTime/views/buy_more_time_view.dart';
import 'package:autotomi/app/modules/new_condition_report/views/new_condition_report_view.dart';
import 'package:autotomi/app/modules/payment_method/views/payment_method_view.dart';
import 'package:autotomi/app/modules/pick_up_inspection/views/pick_up_inspection_view.dart';
import 'package:autotomi/app/modules/send_request_admin/views/send_request_admin_view.dart';
import 'package:autotomi/app/modules/support/views/support_view.dart';
import 'package:autotomi/app/routes/app_pages.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:autotomi/common/asset.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import '../controllers/mycar_details_controller.dart';

class MycarDetailsView extends GetView<MycarDetailsController> {
  const MycarDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MycarDetailsController controller = Get.put(MycarDetailsController());
    return GetBuilder<MycarDetailsController>(
      assignId: true,
      init: MycarDetailsController(),
      builder: (logic) {
        return Obx(() {
          return ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            opacity: 0,
            progressIndicator: customerIndicator,
            child: WillPopScope(
              onWillPop: () {
                return controller.onWillPopScope();
              },
              child: Scaffold(
                backgroundColor: color.white,
                appBar: commonWidget.customAppbar(
                  fontsize: 20.0,
                  arroOnTap: () {
                    Get.back(result: 2);
                  },
                  titleText: controller.flag == 1 || controller.flag == 2 || controller.flag == 3 ? "Your Selected Car" : 'Booked Car',
                  actions: SizedBox(),
                  centerTitle: false,
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
                              controller.flag == 0 ? commonWidget.mediumText('Thank you for your booking, kindly make payment to reserve this car for yourself', fontsize: 15.0) : SizedBox(),
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
                                          controller.reserveDate == null
                                              ? SizedBox()
                                              : Container(
                                                  width: Get.width / 1.2,
                                                  child: commonWidget.boldText(
                                                    'Reserve Date :- ${DateFormat('EE, dd MMM, h:mma').format(
                                                      DateTime.parse(controller.reserveDate.toString()).toLocal(),
                                                    )}',
                                                    fontsize: 15.0,
                                                    tcolor: color.black,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                          controller.reserveDate == null ? SizedBox() : SizedBox(height: 15),
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
                                          controller.flag == 0 ? SizedBox() : SizedBox(height: 12),
                                          controller.flag == 1 || controller.flag == 2 || controller.flag == 3
                                              ? Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        selectedCalenderDateEndDateMoreTime = null;
                                                        Get.toNamed(Routes.BUY_MORE_TIME, arguments: {
                                                          'flag': controller.flag,
                                                          'booking_id': controller.bookingID,
                                                          'car_image': controller.carImageList[0].image,
                                                          'car_name': controller.carName,
                                                          'star_count': controller.starCount,
                                                          'review_count': controller.reviewCount,
                                                          'start_date': controller.startDate,
                                                          'pick_time': controller.pickUpTime,
                                                          'end_date': controller.endDate,
                                                          'drop_time': controller.dropTime,
                                                          'fare_unlimited_kms': controller.totalFare,
                                                          'damage_protection_fee': controller.damageProtectionFee,
                                                          'convenience_fee': controller.convenienceFee,
                                                          'total_fare': controller.totalFare,
                                                          'security_deposit': controller.securityDeposit,
                                                          'final_fare': controller.finalFare,
                                                          'per_day_price': controller.perDay,
                                                          'per_week_price': controller.perWeek,
                                                          'car_id': controller.carID,
                                                          'bring_car_me': controller.bringCarMe,
                                                          'come_pickup_car': controller.comePickupCar,
                                                          'discount_amount': controller.discountAmount,
                                                          'coupon_id': controller.couponId,
                                                        });
                                                      },
                                                      splashColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      child: Container(
                                                        padding: EdgeInsets.all(6),
                                                        child: commonWidget.semiBoldText(
                                                          controller.flag == 1 || controller.flag == 3 ? "+Add more Time" : '+Buy more Time',
                                                          fontsize: 14.0,
                                                          tcolor: color.appColor,
                                                        ),
                                                      ),
                                                    ),
                                                    controller.flag == 2 ? SizedBox(height: hw.height * 0.02) : SizedBox(),
                                                    controller.flag == 2
                                                        ? Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              commonWidget.mediumText('Your ride will be ended', fontsize: 15.0),
                                                              controller.isNegative.value == true
                                                                  ? commonWidget.semiBoldText(
                                                                      '00:00:00',
                                                                      fontsize: 18.0,
                                                                      tcolor: color.appColor,
                                                                    )
                                                                  : commonWidget.mediumText(
                                                                      '${controller.rideEndDay}Day : ${controller.totalHour}Hour',
                                                                      fontsize: 15.0,
                                                                      tcolor: color.appColor,
                                                                    ),
                                                            ],
                                                          )
                                                        : SizedBox(),
                                                    controller.flag == 1 || controller.flag == 3 ? SizedBox(height: hw.height * 0.02) : SizedBox(),
                                                    controller.flag == 1 || controller.flag == 3
                                                        ? Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              commonWidget.mediumText('Your ride will start in', fontsize: 15.0),
                                                              commonWidget.mediumText('Ride Duration', fontsize: 15.0),
                                                            ],
                                                          )
                                                        : SizedBox(),
                                                    controller.flag == 1 || controller.flag == 3 ? SizedBox(height: hw.height * 0.02) : SizedBox(),
                                                    controller.flag == 1 || controller.flag == 3
                                                        ? Row(
                                                            children: [
                                                              controller.isNegative.value == true
                                                                  ? commonWidget.semiBoldText('00:00:00', fontsize: 18.0, tcolor: color.appColor)
                                                                  : commonWidget.semiBoldText(
                                                                      '${controller.totalHour}:${controller.showMinutes}:00',
                                                                      fontsize: 18.0,
                                                                      tcolor: color.appColor,
                                                                    ),
                                                              Spacer(),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  color: Color(0xffFAFBFC),
                                                                  borderRadius: BorderRadius.circular(5),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(Icons.watch_later, color: color.appColor),
                                                                      commonWidget.mediumText(' ${controller.totalDay} Day', fontsize: 15.0),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                )
                                              : SizedBox(),
                                          controller.flag == 1 ? SizedBox() : SizedBox(height: hw.height * 0.02),
                                          Divider(),
                                          SizedBox(height: hw.height * 0.02),
                                          commonWidget.mediumText('Please review the final fare', fontsize: 15.0),
                                          SizedBox(height: hw.height * 0.02),
                                          controller.flag == 0
                                              ? SizedBox()
                                              : Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    commonWidget.regularText('Rented For', fontsize: 14.0),
                                                    commonWidget.regularText('${controller.totalDay} Day', fontsize: 14.0),
                                                  ],
                                                ),
                                          controller.flag == 0 ? SizedBox() : SizedBox(height: hw.height * 0.02),
                                          controller.flag == 3
                                              ? Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    commonWidget.semiBoldText('You are eligible for a refund.', fontsize: 14.0),
                                                    commonWidget.semiBoldText('${controller.totalDay} Day', fontsize: 14.0),
                                                  ],
                                                )
                                              : Column(
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
                                                    controller.comePickupCar == 0 ? SizedBox() : SizedBox(height: 5),
                                                    controller.comePickupCar == 0 ? SizedBox() : Divider(),
                                                    controller.comePickupCar == 0 ? SizedBox() : SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        commonWidget.semiBoldText("Total Fare", fontsize: 14.0, tcolor: color.black),
                                                        commonWidget.semiBoldText(
                                                          '£${controller.showTotalFare = (controller.totalFare + controller.damageProtectionFee + controller.convenienceFee + controller.bringCarMe + controller.comePickupCar) ?? ''}',
                                                          fontsize: 14.0,
                                                          tcolor: color.black,
                                                        )
                                                      ],
                                                    ),
                                                    controller.flag == 0 ? SizedBox() : Divider(),
                                                    controller.flag == 0 ? SizedBox() : SizedBox(height: 5),
                                                    controller.flag == 0
                                                        ? SizedBox()
                                                        : Row(
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
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          SizedBox(height: hw.height * 0.015),
                          controller.flag == 1 || controller.flag == 2
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: commonWidget.customButton(
                                            onTap: () {
                                              controller.calculateCancelCarDays(
                                                DateTime.parse(controller.reserveDate),
                                                DateTime.parse(DateTime.now().toString()),
                                                controller.totalFare,
                                                controller.finalFare,
                                              );
                                              controller.flag == 2
                                                  ? Get.to(() => NewConditionReportView(), arguments: {
                                                      'flag': 3,
                                                      'car_id': controller.carID,
                                                      'booking_id': controller.bookingID,
                                                      'report_type': 3,
                                                    })
                                                  : cancelCar(context);
                                              controller.update();
                                            },
                                            Ccolor: Color(0xffFF5E5E).withOpacity(0.15),
                                            Tcolor: Color(0xffFF5E5E),
                                            text: controller.flag == 2 ? 'Report Incident' : 'Cancel',
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Expanded(
                                          child: commonWidget.customButton(
                                            onTap: () {
                                              controller.checkRemainderDay(
                                                DateTime.parse(DateTime.now().toString()),
                                                DateTime.parse(controller.startDate),
                                              );
                                              controller.isNegative.value == true || controller.flag == 2
                                                  ? Get.to(
                                                      () => PickUpInspectionView(),
                                                      arguments: {
                                                        'flag': controller.flag,
                                                        'car_id': controller.carID,
                                                        'booking_id': controller.bookingID,
                                                        'county_id': controller.countyId,
                                                      },
                                                    )
                                                  : showDialog(
                                                      context: Get.context!,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                            backgroundColor: color.fillColor,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9.0))),
                                                            contentPadding: EdgeInsets.only(top: 10.0),
                                                            content: Container(
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: color.fillColor),
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    SizedBox(height: 12),
                                                                    commonWidget.semiBoldText(
                                                                      "Today is Not Your PickUp Day.",
                                                                      fontsize: 16.0,
                                                                      textAlign: TextAlign.center,
                                                                      height: 1.5,
                                                                    ),
                                                                    SizedBox(height: 12),
                                                                    Divider(),
                                                                    SizedBox(height: 12),
                                                                    commonWidget.customButton(
                                                                      onTap: () {
                                                                        Get.back();
                                                                      },
                                                                      text: 'OK',
                                                                    ),
                                                                    SizedBox(height: 12),
                                                                  ],
                                                                ),
                                                              ),
                                                            ));
                                                      },
                                                    );
                                            },
                                            text: controller.flag == 2 ? 'Return Car' : 'Pickup',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : controller.flag == 3
                                  ? commonWidget.customButton(
                                      onTap: () {
                                        Get.to(PaymentMethodView(), arguments: {
                                          'flag': controller.flag,
                                          'booking_id': controller.bookingID,
                                          'car_image': controller.carImageList[0].image,
                                          'car_name': controller.carName,
                                          'start_date': controller.startDate,
                                          'pick_time': controller.pickUpTime,
                                          'end_date': controller.endDate,
                                          'drop_time': controller.dropTime,
                                          'fare_unlimited_kms': controller.totalFare,
                                          'damage_protection_fee': 10,
                                          'convenience_fee': 10,
                                          'total_fare': controller.totalFare,
                                          'security_deposit': 50,
                                          'final_fare': controller.finalFare,
                                          'is_payment': 0,
                                        });
                                      },
                                      width: Get.width,
                                      text: 'Pickup',
                                      Tcolor: color.white,
                                      Ccolor: color.appColor,
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: commonWidget.customButton(
                                            onTap: () {
                                              print(controller.totalFare);
                                              print("controller.totalFare");
                                              if (controller.flag == 1) {
                                              } else if (controller.flag == 0) {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9.0))),
                                                      contentPadding: EdgeInsets.only(top: 10.0),
                                                      content: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(9),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              SizedBox(height: hw.height * 0.016),
                                                              Image.asset(assetsUrl.car, height: 85, width: 85),
                                                              SizedBox(height: hw.height * 0.016),
                                                              commonWidget.semiBoldText('Are you sure want to Cancel\nthis Car?', fontsize: 16.0, textAlign: TextAlign.center, height: 1.5),
                                                              SizedBox(height: hw.height * 0.016),
                                                              commonWidget.customButton(
                                                                onTap: () {
                                                                  Get.back();
                                                                  Get.back(result: 1);
                                                                },
                                                                height: 48.0,
                                                                text: "Yes",
                                                                textfontsize: 16.0,
                                                              ),
                                                              SizedBox(height: hw.height * 0.016),
                                                              Divider(),
                                                              SizedBox(height: hw.height * 0.016),
                                                              InkWell(
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                                splashColor: color.transparent,
                                                                highlightColor: color.transparent,
                                                                child: Container(
                                                                  width: hw.width,
                                                                  height: 30.0,
                                                                  child: Center(child: commonWidget.semiBoldText('Cancel', fontsize: 16.0)),
                                                                ),
                                                              ),
                                                              SizedBox(height: hw.height * 0.016),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            Ccolor: Color(0xffFF5E5E).withOpacity(0.15),
                                            Tcolor: Color(0xffFF5E5E),
                                            text: 'Cancel',
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Expanded(
                                          child: commonWidget.customButton(
                                            onTap: () {
                                              print(controller.finalFare);
                                              box.read('is_profile_veri') == 0
                                                  ? showDialog(
                                                      context: Get.context!,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                            backgroundColor: color.fillColor,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9.0))),
                                                            contentPadding: EdgeInsets.only(top: 10.0),
                                                            content: Container(
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: color.fillColor),
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    SizedBox(height: 12),
                                                                    commonWidget.semiBoldText(
                                                                      "Your profile is still under review, sorry you cannot reserve this car at the moment.",
                                                                      fontsize: 16.0,
                                                                      textAlign: TextAlign.center,
                                                                      height: 1.5,
                                                                    ),
                                                                    SizedBox(height: 12),
                                                                    Divider(),
                                                                    SizedBox(height: 12),
                                                                    commonWidget.customButton(
                                                                      onTap: () {
                                                                        Get.back();
                                                                      },
                                                                      text: 'OK',
                                                                    ),
                                                                    SizedBox(height: 12),
                                                                    commonWidget.customButton(
                                                                      onTap: () {
                                                                        Get.back();
                                                                        Get.to(() => SupportView());
                                                                      },
                                                                      text: 'Contact Support',
                                                                    ),
                                                                    SizedBox(height: 16),
                                                                  ],
                                                                ),
                                                              ),
                                                            ));
                                                      },
                                                    )
                                                  : controller.isReserve == 0 || controller.isAdminApprove == 1
                                                      ? controller.checkReserveCar_Api(flag: 0)
                                                      : showDialog(
                                                          context: Get.context!,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              backgroundColor: color.fillColor,
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9.0))),
                                                              contentPadding: EdgeInsets.only(top: 10.0),
                                                              content: Container(
                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: color.fillColor),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      SizedBox(height: 12),
                                                                      commonWidget.semiBoldText(
                                                                        "Send Request to Admin Reserve My Second Car.",
                                                                        fontsize: 16.0,
                                                                        textAlign: TextAlign.center,
                                                                        height: 1.5,
                                                                      ),
                                                                      SizedBox(height: 12),
                                                                      Divider(),
                                                                      SizedBox(height: 12),
                                                                      commonWidget.customButton(
                                                                        onTap: () {
                                                                          Get.back();
                                                                          controller.carBookingId == 0 ? controller.checkReserveCar_Api(flag: 1) : Toasty.showtoast("Your request is already sending to the Admin please wait for the Admin approval");
                                                                        },
                                                                        text: 'Send',
                                                                      ),
                                                                      SizedBox(height: 12),
                                                                      commonWidget.customButton(
                                                                        onTap: () {
                                                                          Get.back();
                                                                        },
                                                                        text: 'cancel',
                                                                      ),
                                                                      SizedBox(height: 16),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                            },
                                            Ccolor: controller.isReserve == 0 || controller.isAdminApprove == 1 ? color.appColor : color.grey,
                                            text: 'Reserve',
                                          ),
                                        ),
                                      ],
                                    ),
                          SizedBox(height: hw.height * 0.015),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  cancelCar(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: hw.height * 0.016),
                  Image.asset(assetsUrl.car, height: 85, width: 85),
                  SizedBox(height: hw.height * 0.016),
                  commonWidget.semiBoldText(
                    controller.showPercentage == 0 ? "You Will Get Only Damage Protection Fee" : 'You Will Get :- ${controller.showPercentage}% Refund From Total Fare',
                    fontsize: 14.0,
                    textAlign: TextAlign.center,
                    height: 1.5,
                  ),
                  SizedBox(height: hw.height * 0.015),
                  commonWidget.semiBoldText(
                    'Your Refund Amount :- ${controller.refundAmount}',
                    fontsize: 16.0,
                    textAlign: TextAlign.center,
                    height: 1.5,
                  ),
                  // : commonWidget.semiBoldText(
                  //     'You are not eligible for a refund if you cancel the ride within the three-day period.',
                  //     fontsize: 14.0,
                  //     textAlign: TextAlign.center,
                  //     height: 1.5,
                  //   ),
                  SizedBox(height: hw.height * 0.026),
                  commonWidget.customButton(
                    onTap: () {
                      Get.back();

                      controller.getRefundAmount_Api();

                      // controller.cancelCar_Api(bookingID: controller.listMyCarList[index].bookingId, index: index);
                      // controller.update();
                    },
                    height: 48.0,
                    text: "Refund",
                    textfontsize: 16.0,
                  ),
                  SizedBox(height: hw.height * 0.010),
                  Divider(),
                  SizedBox(height: hw.height * 0.010),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    splashColor: color.transparent,
                    highlightColor: color.transparent,
                    child: Container(
                      width: hw.width,
                      height: 35.0,
                      child: Center(child: commonWidget.semiBoldText('Cancel', fontsize: 16.0)),
                    ),
                  ),
                  SizedBox(height: hw.height * 0.010),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
