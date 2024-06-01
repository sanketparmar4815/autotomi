import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Model/list_my_car_model.dart';

class ChangeRideController extends GetxController {
  var selectCar, perDay, perWeek;
  List<CarImage> carImageList = [];
  var carID, flag, carName, starCount, reviewCount, startDate, pickUpTime, endDate, dropTime, fareUnlimitedKms, damageProtectionFee, convenienceFee, totalFare, securityDeposit, finalFare, bookingID, dropLocation, pickUpLocation;

  var isLoading = false.obs, page = 1;
  var hasNextPage = true.obs;
  var isLoadMoreRunning = false.obs;

  List<listMyCar> listMyCarList = [];

  ScrollController? scroll_controller;

  TabController? tabController;

  @override
  void onInit() {
    if (Get.arguments != null) {
      carID = Get.arguments['car_id'];
      bookingID = Get.arguments['booking_id'];
      carImageList = Get.arguments['car_image'];
      carName = Get.arguments['car_name'];
      starCount = Get.arguments['star_count'];
      reviewCount = Get.arguments['review_count'];
      startDate = Get.arguments['start_date'];
      pickUpTime = Get.arguments['pick_time'];
      endDate = Get.arguments['end_date'];
      dropTime = Get.arguments['drop_time'];
      fareUnlimitedKms = Get.arguments['fare_unlimited_kms'];
      damageProtectionFee = Get.arguments['damage_protection_fee'];
      convenienceFee = Get.arguments['convenience_fee'];
      totalFare = Get.arguments['total_fare'];
      securityDeposit = Get.arguments['security_deposit'];
      finalFare = Get.arguments['final_fare'];
      perDay = Get.arguments['per_day_price'];
      perWeek = Get.arguments['per_week_price'];
      pickUpLocation = Get.arguments['pickUp_location'];
      dropLocation = Get.arguments['drop_location'];
    }

    scroll_controller = ScrollController()..addListener(loadMore);
    myCar_Api();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  myCar_Api({LoadMore}) {
    if (LoadMore != 1) {
      isLoading.value = true;
    }
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "list_my_car",
      method: MethodType.Post,
      params: {
        "page_no": page,
        "booking_status": 0,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          list_my_car_model data = list_my_car_model.fromJson(response);
          if (LoadMore != 1) {
            listMyCarList = data.info!;

            isLoading.value = false;
            update();
          } else {
            isLoadMoreRunning.value = false;
            if (data.info!.length > 0) {
              listMyCarList.addAll(data.info!);
              isLoading.value = false;
            } else {
              hasNextPage.value = false;
            }
            update();
          }
        } else {
          print(response['Message']);
        }
        isLoading.value = false;
      },
      failureCallback: (message, statusCode) {
        print(message.toString());
        print(statusCode);
        isLoading.value = false;
      },
      timeOutCallback: () {
        Toasty.showtoast('something is wrong please try again');
        isLoading.value = false;
      },
    );
  }

  Future<dynamic> loadMore() async {
    if (hasNextPage.value == true && isLoading.value == false && isLoadMoreRunning.value == false && scroll_controller!.offset >= scroll_controller!.position.maxScrollExtent) {
      isLoadMoreRunning.value = true;
      page++;
      await myCar_Api(LoadMore: 1);
    }
  }
}
