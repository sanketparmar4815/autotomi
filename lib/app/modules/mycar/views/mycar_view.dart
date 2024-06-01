import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/allCarRatingReview/views/all_car_rating_review_view.dart';
import 'package:autotomi/app/modules/buyMoreTime/views/buy_more_time_view.dart';
import 'package:autotomi/app/modules/mycar_details/views/mycar_details_view.dart';
import 'package:autotomi/app/modules/new_condition_report/views/new_condition_report_view.dart';
import 'package:autotomi/app/modules/pick_up_inspection/views/pick_up_inspection_view.dart';
import 'package:autotomi/app/modules/send_request_admin/views/send_request_admin_view.dart';
import 'package:autotomi/app/modules/support/views/support_view.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/widgets.dart';
import '../../../routes/app_pages.dart';
import '../controllers/mycar_controller.dart';

class MycarView extends GetView<MycarController> {
  const MycarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MycarController controller = Get.put(MycarController());
    return GetBuilder<MycarController>(
      init: MycarController(),
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
                  leading: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: commonWidget.semiBoldText(stringsUtils.myCar, fontsize: 24.0),
                  ),
                  leadingWidth: 200.0,
                  titleText: '',
                  actions: SizedBox(),
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Container(
                        height: 55,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Divider(
                                thickness: 2,
                                color: Color(0xffECECEC),
                              ),
                            ),
                            TabBar(
                              dividerColor: Colors.transparent,
                              indicatorPadding: EdgeInsets.zero,
                              indicatorSize: TabBarIndicatorSize.tab,
                              unselectedLabelStyle: TextStyle(fontSize: 16.0, fontFamily: "DMSansMedium"),
                              physics: BouncingScrollPhysics(),
                              controller: controller.tabController,
                              labelStyle: TextStyle(
                                fontSize: 16,
                                color: color.appColor,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'SemiBold',
                              ),
                              unselectedLabelColor: color.black.withOpacity(0.4),
                              indicatorColor: color.appColor,
                              labelColor: color.appColor,
                              tabs: [
                                Tab(text: 'Booked'),
                                Tab(text: 'Reserved'),
                                Tab(text: 'Rented'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: controller.tabController,
                          physics: BouncingScrollPhysics(),
                          children: [
                            BookedTab(),
                            ReservedTab(),
                            rentedCarTab(),
                          ],
                        ),
                      ),
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

  BookedTab() {
    return SingleChildScrollView(
      controller: controller.scroll_controller,
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 10),
          controller.listMyCarList.length == 0 ? SizedBox(height: Get.height * 0.3) : SizedBox(),
          controller.listMyCarList.length == 0 && controller.isLoading.value == false
              ? commonWidget.semiBoldText("No Data Found", fontsize: 20.0)
              : ListView.builder(
                  itemCount: controller.listMyCarList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => MycarDetailsView(),
                          arguments: {
                            'flag': 0,
                            'booking_id': controller.listMyCarList[index].bookingId,
                            'car_image': controller.listMyCarList[index].carImage,
                            'car_id': controller.listMyCarList[index].carId,
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
                            'drop_location': controller.listMyCarList[index].dropoffLocation,
                            'pickUp_location': controller.listMyCarList[index].pickupLocation,
                            'is_reserve': controller.listMyCarList[index].isReserve,
                            'bring_car_me': controller.listMyCarList[index].bringCarMe,
                            'come_pickup_car': controller.listMyCarList[index].comePickupCar,
                            'discount_amount': controller.listMyCarList[index].discountAmount,
                            'is_admin_approve': controller.listMyCarList[index].isAdminApprove,
                            'car_booking_id': controller.listMyCarList[index].carBookingId,
                          },
                        )!
                            .then((value) {
                          if (value == 1) {
                            print(value);
                            controller.cancelCar_Api(bookingID: controller.listMyCarList[index].bookingId, index: index);
                            controller.update();
                          } else if (value == 2) {
                            controller.myCar_Api();
                            controller.update();
                          }
                        });
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: color.appColor,
                          ),
                        ),
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
                                            commonWidget.regularText(
                                              '${controller.listMyCarList[index].starCount}(${controller.listMyCarList[index].reviewCount} Reviews)',
                                              fontsize: 12.0,
                                            ),
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
                                  commonWidget.semiBoldText('Booked', fontsize: 16.0, tcolor: color.appColor),
                                ],
                              ),
                              SizedBox(height: hw.height * 0.016),
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
                                        DateTime.parse(controller.listMyCarList[index].startDate.toString()),
                                      )} ${DateFormat('h:mma').format(
                                        DateFormat('HH:mm').parse(controller.listMyCarList[index].pickupTime.toString()),
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
                                      '${controller.listMyCarList[index].pickupLocation}',
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
                                        '${DateFormat('EE, dd MMM,').format(DateTime.parse(controller.listMyCarList[index].endDate.toString()))}'
                                        ' ${DateFormat("h:mma").format(
                                          DateFormat("hh:mm").parse(controller.listMyCarList[index].dropoffTime.toString()),
                                        )}',
                                        fontsize: 16.0),
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
                                      '${controller.listMyCarList[index].dropoffLocation}',
                                      fontsize: 16.0,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: hw.height * 0.018),
                              Divider(),
                              SizedBox(height: hw.height * 0.018),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  commonWidget.regularText('Total Fare', fontsize: 14.0),
                                  commonWidget.semiBoldText('£${controller.listMyCarList[index].totalFare} Total ', fontsize: 14.0),
                                ],
                              ),
                              SizedBox(height: hw.height * 0.018),
                              Row(
                                children: [
                                  Expanded(
                                    child: commonWidget.customButton(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9.0))),
                                              contentPadding: EdgeInsets.only(top: 10.0),
                                              content: Container(
                                                height: 300,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(9),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SizedBox(height: hw.height * 0.016),
                                                      Image.asset(assetsUrl.car, height: 85, width: 85),
                                                      SizedBox(height: hw.height * 0.016),
                                                      commonWidget.semiBoldText('Are you sure want to Cancel\nthis Car?', fontsize: 16.0, textAlign: TextAlign.center, height: 1.5),
                                                      SizedBox(height: hw.height * 0.016),
                                                      commonWidget.customButton(
                                                        onTap: () {
                                                          Get.back();
                                                          controller.cancelCar_Api(bookingID: controller.listMyCarList[index].bookingId, index: index);
                                                          controller.update();
                                                        },
                                                        height: 48.0,
                                                        text: stringsUtils.yes,
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
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
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
                                            : controller.listMyCarList[index].isReserve == 0 || controller.listMyCarList[index].isAdminApprove == 1
                                                ? controller.checkReserveCar_Api(index: index, carID: controller.listMyCarList[index].carId, startDate: controller.listMyCarList[index].startDate, endDate: controller.listMyCarList[index].endDate, flag: 0)
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
                                                                      controller.listMyCarList[index].carBookingId == 0 ? controller.checkReserveCar_Api(index: index, carID: controller.listMyCarList[index].carId, startDate: controller.listMyCarList[index].startDate, endDate: controller.listMyCarList[index].endDate, flag: 1) : Toasty.showtoast("Your request is already sending to the Admin please wait for the Admin approval");
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
                                                          ));
                                                    },
                                                  );
                                      },
                                      Ccolor: controller.listMyCarList[index].isReserve == 0 || controller.listMyCarList[index].isAdminApprove == 1 ? color.appColor : color.grey,
                                      text: 'Reserve',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
          Obx(() {
            return controller.isLoadMoreRunning.value == true ? Center(child: customerIndicator) : Container();
          }),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  ReservedTab() {
    return SingleChildScrollView(
      controller: controller.scroll_controller,
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 10),
          controller.listMyCarList.length == 0 ? SizedBox(height: Get.height * 0.3) : SizedBox(),
          controller.listMyCarList.length == 0 && controller.isLoading.value == false
              ? commonWidget.semiBoldText("No Data Found", fontsize: 20.0)
              : ListView.builder(
                  itemCount: controller.listMyCarList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => MycarDetailsView(),
                          arguments: {
                            'flag': 1,
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
                            'reserve_date': controller.listMyCarList[index].reservedDatetime,
                            'bring_car_me': controller.listMyCarList[index].bringCarMe,
                            'come_pickup_car': controller.listMyCarList[index].comePickupCar,
                            'extra_price': controller.listMyCarList[index].extraPrice,
                            'extra_days': controller.listMyCarList[index].extraDays,
                            'discount_amount': controller.listMyCarList[index].discountAmount,
                            'coupon_id': controller.listMyCarList[index].couponId,
                          },
                        )!
                            .then((value) {
                          if (value == 1) {
                            print(value);
                            controller.cancelCar_Api(bookingID: controller.listMyCarList[index].bookingId, index: index);
                            controller.update();
                          }
                        });
                        print(controller.listMyCarList[index].finalFare);
                        print(controller.listMyCarList[index].totalFare);
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: color.appColor,
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
                                  commonWidget.semiBoldText(
                                    'Reserved',
                                    fontsize: 16.0,
                                    tcolor: color.appColor,
                                  ),
                                ],
                              ),
                              SizedBox(height: hw.height * 0.016),
                              controller.listMyCarList[index].reservedDatetime == null
                                  ? SizedBox()
                                  : Container(
                                      width: Get.width / 1.2,
                                      child: commonWidget.boldText(
                                        'Reserve Date :- ${DateFormat('EE, dd MMM, h:mma').format(
                                          DateTime.parse(controller.listMyCarList[index].reservedDatetime.toString()).toLocal(),
                                        )}',
                                        fontsize: 15.0,
                                        tcolor: color.black,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                              SizedBox(height: hw.height * 0.016),
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
                                        DateTime.parse(controller.listMyCarList[index].startDate.toString()),
                                      )} ${DateFormat('h:mma').format(
                                        DateFormat('HH:mm').parse(controller.listMyCarList[index].pickupTime.toString()),
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
                                      '${controller.listMyCarList[index].pickupLocation}',
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
                                      '${DateFormat('EE, dd MMM,').format(
                                        DateTime.parse(controller.listMyCarList[index].endDate.toString()),
                                      )} ${DateFormat('h:mma').format(
                                        DateFormat('HH:mm').parse(controller.listMyCarList[index].dropoffTime.toString()),
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
                                      '${controller.listMyCarList[index].dropoffLocation}',
                                      fontsize: 16.0,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              InkWell(
                                onTap: () {
                                  selectedCalenderDateEndDateMoreTime = null;
                                  Get.toNamed(Routes.BUY_MORE_TIME, arguments: {
                                    'flag': 1,
                                    'car_id': controller.listMyCarList[index].carId,
                                    'booking_id': controller.listMyCarList[index].bookingId,
                                    'car_image': controller.listMyCarList[index].carImage![0].image,
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
                                    'bring_car_me': controller.listMyCarList[index].bringCarMe,
                                    'come_pickup_car': controller.listMyCarList[index].comePickupCar,
                                    'discount_amount': controller.listMyCarList[index].discountAmount,
                                    'coupon_id': controller.listMyCarList[index].couponId,
                                  });
                                },
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: commonWidget.semiBoldText(
                                    '+Add more time',
                                    fontsize: 14.0,
                                    tcolor: color.appColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: hw.height * 0.018),
                              Divider(),
                              SizedBox(height: hw.height * 0.018),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  commonWidget.regularText('Total Fare', fontsize: 14.0),
                                  commonWidget.semiBoldText(
                                    '£${controller.listMyCarList[index].finalFare ?? ''} Total ',
                                    fontsize: 14.0,
                                  ),
                                ],
                              ),
                              SizedBox(height: hw.height * 0.018),
                              // Center(
                              //   child: commonWidget.customButton(
                              //     width: 200.0,
                              //     onTap: () {
                              //       Get.to(() => ChangeRideView(), arguments: {
                              //         'car_id': controller.listMyCarList[index].carId,
                              //         'booking_id': controller.listMyCarList[index].bookingId,
                              //         'car_image': controller.listMyCarList[index].carImage,
                              //         'car_name': controller.listMyCarList[index].carName,
                              //         'star_count': controller.listMyCarList[index].starCount,
                              //         'review_count': controller.listMyCarList[index].reviewCount,
                              //         'start_date': controller.listMyCarList[index].startDate,
                              //         'pick_time': controller.listMyCarList[index].pickupTime,
                              //         'end_date': controller.listMyCarList[index].endDate,
                              //         'drop_time': controller.listMyCarList[index].dropoffTime,
                              //         'fare_unlimited_kms': controller.listMyCarList[index].totalFare,
                              //         'damage_protection_fee': 10,
                              //         'convenience_fee': 10,
                              //         'total_fare': controller.listMyCarList[index].totalFare,
                              //         'security_deposit': 50,
                              //         'final_fare': controller.listMyCarList[index].finalFare,
                              //         'per_day_price': controller.listMyCarList[index].pricePerDay,
                              //         'per_week_price': controller.listMyCarList[index].pricePerWeek,
                              //         'drop_location': controller.listMyCarList[index].dropoffLocation,
                              //         'pickUp_location': controller.listMyCarList[index].pickupLocation,
                              //       });
                              //     },
                              //     text: 'Change Ride',
                              //     Tcolor: color.appColor,
                              //     Ccolor: Color(0xffECF5EF),
                              //   ),
                              // ),
                              SizedBox(height: hw.height * 0.018),
                              Row(
                                children: [
                                  Expanded(
                                    child: commonWidget.customButton(
                                      onTap: () {
                                        print("yes");
                                        controller.calculateCancelCarDays(
                                          DateTime.parse(controller.listMyCarList[index].reservedDatetime.toString()).toLocal(),
                                          DateTime.parse(DateTime.now().toString()),
                                          controller.listMyCarList[index].totalFare,
                                          controller.listMyCarList[index].finalFare,
                                        );

                                        cancelCar(context, index: index, bookingID: controller.listMyCarList[index].bookingId);
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
                                        controller.checkRemainderDay(DateTime.parse(DateTime.now().toString()), DateTime.parse(controller.listMyCarList[index].startDate.toString()));
                                        controller.isNegative.value == false
                                            ? Get.to(
                                                () => PickUpInspectionView(),
                                                arguments: {
                                                  'flag': 1,
                                                  'car_id': controller.listMyCarList[index].carId,
                                                  'booking_id': controller.listMyCarList[index].bookingId,
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
                                      text: 'Pickup',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
          Obx(() {
            return controller.isLoadMoreRunning.value == true ? Center(child: customerIndicator) : Container();
          }),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  rentedCarTab() {
    return SingleChildScrollView(
      controller: controller.scroll_controller,
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 10),
          controller.listMyCarList.length == 0 ? SizedBox(height: Get.height * 0.3) : SizedBox(),
          controller.listMyCarList.length == 0 && controller.isLoading.value == false
              ? commonWidget.semiBoldText("No Data Found", fontsize: 20.0)
              : ListView.builder(
                  itemCount: controller.listMyCarList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.MYCAR_DETAILS,
                          arguments: {
                            'flag': 2,
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
                            'reserve_date': controller.listMyCarList[index].reservedDatetime,
                            'discount_amount': controller.listMyCarList[index].discountAmount,
                            'coupon_id': controller.listMyCarList[index].couponId,
                            'county_id': controller.listMyCarList[index].countryId,
                          },
                        );
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: color.grey.withOpacity(.4),
                          ),
                        ),
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
                                            commonWidget.regularText(
                                              '${controller.listMyCarList[index].starCount}(${controller.listMyCarList[index].reviewCount} Reviews)',
                                              fontsize: 12.0,
                                            ),
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
                                  commonWidget.semiBoldText(
                                    'Roaming',
                                    fontsize: 16.0,
                                    tcolor: color.appColor,
                                  ),
                                ],
                              ),
                              SizedBox(height: hw.height * 0.016),
                              controller.listMyCarList[index].reservedDatetime == null
                                  ? SizedBox()
                                  : Container(
                                      width: Get.width / 1.2,
                                      child: commonWidget.boldText(
                                        'Reserve Date :- ${DateFormat('EE, dd MMM, h:mma').format(
                                          DateTime.parse(controller.listMyCarList[index].reservedDatetime.toString()).toLocal(),
                                        )}',
                                        fontsize: 15.0,
                                        tcolor: color.black,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                              SizedBox(height: hw.height * 0.016),
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
                                        DateTime.parse(controller.listMyCarList[index].startDate.toString()),
                                      )} ${DateFormat('h:mma').format(
                                        DateFormat('HH:mm').parse(controller.listMyCarList[index].pickupTime.toString()),
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
                                      '${controller.listMyCarList[index].pickupLocation}',
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
                                    padding: const EdgeInsets.only(top: 5),
                                    child: commonWidget.semiBoldText(
                                      '${DateFormat('EE, dd MMM,').format(
                                        DateTime.parse(controller.listMyCarList[index].endDate.toString()),
                                      )} ${DateFormat('h:mma').format(
                                        DateFormat('HH:mm').parse(controller.listMyCarList[index].dropoffTime.toString()),
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
                                      '${controller.listMyCarList[index].dropoffLocation}',
                                      fontsize: 16.0,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: hw.height * 0.018),
                              InkWell(
                                onTap: () {
                                  selectedCalenderDateEndDateMoreTime = null;
                                  Get.toNamed(Routes.BUY_MORE_TIME, arguments: {
                                    'flag': 2,
                                    'car_id': controller.listMyCarList[index].carId,
                                    'booking_id': controller.listMyCarList[index].bookingId,
                                    'car_image': controller.listMyCarList[index].carImage![0].image,
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
                                    'discount_amount': controller.listMyCarList[index].discountAmount,
                                    'come_pickup_car': controller.listMyCarList[index].comePickupCar,
                                    'bring_car_me': controller.listMyCarList[index].bringCarMe,
                                    'coupon_id': controller.listMyCarList[index].couponId,
                                  });
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: commonWidget.semiBoldText(
                                  stringsUtils.Buymoretime,
                                  fontsize: 14.0,
                                  tcolor: color.appColor,
                                ),
                              ),
                              Divider(),
                              SizedBox(height: hw.height * 0.018),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  commonWidget.regularText('Total Fare', fontsize: 14.0),
                                  commonWidget.semiBoldText(
                                    '£${controller.listMyCarList[index].finalFare} Total ',
                                    fontsize: 14.0,
                                  ),
                                ],
                              ),
                              SizedBox(height: hw.height * 0.018),
                              Row(
                                children: [
                                  Expanded(
                                    child: commonWidget.customButton(
                                      height: 48.0,
                                      onTap: () {
                                        Get.to(() => NewConditionReportView(), arguments: {'flag': 3, 'car_id': controller.listMyCarList[index].carId, 'booking_id': controller.listMyCarList[index].bookingId, 'report_type': 3});
                                      },
                                      Ccolor: Color(0xffFF5E5E).withOpacity(0.15),
                                      Tcolor: Color(0xffFF5E5E),
                                      text: stringsUtils.ReportIncident,
                                      textfontsize: 15.0,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: commonWidget.customButton(
                                      height: 48.0,
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.PICK_UP_INSPECTION,
                                          arguments: {
                                            'flag': 2,
                                            'car_id': controller.listMyCarList[index].carId,
                                            'booking_id': controller.listMyCarList[index].bookingId,
                                            'county_id': controller.listMyCarList[index].countryId,
                                          },
                                        );
                                        //Get.to(() => MycarDetailsView(), arguments: 2);
                                      },
                                      textfontsize: 15.0,
                                      text: "Return Car",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
          Obx(() {
            return controller.isLoadMoreRunning.value == true ? Center(child: customerIndicator) : Container();
          }),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  cancelCar(BuildContext context, {index, bookingID}) {
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
                    'Your Refund Amount Will Be:- £${controller.refundAmount}',
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
                      controller.getRefundAmount_Api(index: index, bookingID: controller.listMyCarList[index].bookingId);
                      // if (controller.cancelTotalDay >= 3) {
                      //   controller.getRefundAmount_Api(index: index, bookingID: controller.listMyCarList[index].bookingId);
                      // } else {
                      //   print("cancel  Api");
                      //   controller.cancelCar_Api(bookingID: controller.listMyCarList[index].bookingId, index: index);
                      // }
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
