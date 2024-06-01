import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/routes/app_pages.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../controllers/change_ride_controller.dart';

class ChangeRideView extends GetView<ChangeRideController> {
  const ChangeRideView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChangeRideController controller = Get.put(ChangeRideController());
    return GetBuilder<ChangeRideController>(
        init: ChangeRideController(),
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
                  titleText: stringsUtils.ChangeRide,
                  actions: SizedBox(),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: controller.scroll_controller,
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 6),
                              commonWidget.semiBoldText(
                                "Currently Rented",
                                fontsize: 18.0,
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(.4),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: CachedImageContainer(
                                              image: "$BaseUrl${controller.carImageList[0].image}",
                                              fit: BoxFit.cover,
                                              height: 57,
                                              width: 85,
                                              placeholder: assetsUrl.plashHolderFullCard,
                                              // flag: 1,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              commonWidget.semiBoldText(
                                                "${controller.carName ?? ""}",
                                                fontsize: 20.0,
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    assetsUrl.starRatingImage,
                                                    scale: 4,
                                                  ),
                                                  SizedBox(width: 5),
                                                  commonWidget.regularText(
                                                    "${controller.starCount ?? ""}(${controller.reviewCount ?? ""} Reviews)",
                                                    fontsize: 14.0,
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          commonWidget.semiBoldText(
                                            "${stringsUtils.Bookingid} : ${controller.bookingID ?? ""}",
                                            fontsize: 16.0,
                                          ),
                                          commonWidget.semiBoldText(
                                            "Rented",
                                            fontsize: 16.0,
                                            tcolor: color.appColor,
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          commonWidget.regularText(
                                            "Total Fare",
                                            fontsize: 16.0,
                                          ),
                                          commonWidget.semiBoldText(
                                            "£${controller.totalFare ?? ""}.00 Total",
                                            fontsize: 16.0,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              commonWidget.semiBoldText(
                                "Booked List",
                                fontsize: 18.0,
                              ),
                              SizedBox(height: 10),
                              controller.listMyCarList.length == 0 && controller.isLoading.value == false
                                  ? Column(
                                      children: [
                                        SizedBox(height: Get.height * 0.15),
                                        Center(
                                          child: commonWidget.semiBoldText(
                                            "No Data Found",
                                            fontsize: 20.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: controller.listMyCarList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            controller.selectCar = index;
                                            controller.update();
                                          },
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 8),
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              border: Border.all(
                                                color: controller.selectCar == index ? color.appColor : Colors.grey.withOpacity(.4),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(3),
                                                        child: CachedImageContainer(
                                                          image: "$BaseUrl${controller.listMyCarList[index].carImage![0].image}",
                                                          fit: BoxFit.cover,
                                                          height: 57,
                                                          width: 85,
                                                          placeholder: assetsUrl.plashHolderFullCard,
                                                          // flag: 1,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          commonWidget.semiBoldText(
                                                            "${controller.listMyCarList[index].carName ?? ""}",
                                                            fontsize: 20.0,
                                                          ),
                                                          SizedBox(height: 4),
                                                          Row(
                                                            children: [
                                                              Image.asset(
                                                                assetsUrl.starRatingImage,
                                                                scale: 4,
                                                              ),
                                                              SizedBox(width: 5),
                                                              commonWidget.regularText(
                                                                "${controller.listMyCarList[index].starCount ?? ""}(${controller.listMyCarList[index].reviewCount ?? ""} Reviews)",
                                                                fontsize: 14.0,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 12),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      commonWidget.semiBoldText(
                                                        "${stringsUtils.Bookingid} : ${controller.listMyCarList[index].bookingId ?? ""}",
                                                        fontsize: 16.0,
                                                      ),
                                                      commonWidget.semiBoldText(
                                                        "Rented",
                                                        fontsize: 16.0,
                                                        tcolor: color.appColor,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 12),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      commonWidget.regularText(
                                                        "Total Fare",
                                                        fontsize: 16.0,
                                                      ),
                                                      commonWidget.semiBoldText(
                                                        "£${controller.listMyCarList[index].totalFare ?? ""}.00 Total",
                                                        fontsize: 16.0,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 16),
                                                  commonWidget.mediumText(
                                                    "Please review the Final cost",
                                                    fontsize: 15.0,
                                                  ),
                                                  SizedBox(height: 16),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      commonWidget.semiBoldText(
                                                        "Addition Cost",
                                                        fontsize: 16.0,
                                                      ),
                                                      commonWidget.semiBoldText(
                                                        "£100.00",
                                                        fontsize: 16.0,
                                                      )
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
                                return controller.isLoadMoreRunning.value == true ? Center(child: customerIndicator) : SizedBox();
                              })
                            ],
                          ),
                        ),
                      ),
                      controller.listMyCarList.length == 0
                          ? SizedBox()
                          : Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: SafeArea(
                                child: commonWidget.customButton(
                                  onTap: () {
                                    if (controller.selectCar != null) {
                                      Get.toNamed(Routes.MYCAR_DETAILS, arguments: {
                                        'data': controller.listMyCarList[controller.selectCar],
                                        'flag': 3,
                                        'car_id': controller.carID,
                                        'booking_id': controller.bookingID,
                                        'car_image': controller.carImageList,
                                        'car_name': controller.carName,
                                        'star_count': controller.starCount,
                                        'review_count': controller.reviewCount,
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
                                        'per_day_price': controller.perDay,
                                        'per_week_price': controller.perWeek,
                                        'drop_location': controller.dropLocation,
                                        'pickUp_location': controller.pickUpLocation,
                                      });
                                    } else {
                                      Toasty.showtoast("Please Select Car");
                                    }
                                  },
                                  height: 48.0,
                                  width: Get.width,
                                  text: "Change Car",
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
