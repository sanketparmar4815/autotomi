import 'package:autotomi/app/Model/list_my_car_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/card_details/views/card_details_view.dart';
import 'package:autotomi/app/modules/home/views/home_view.dart';
import 'package:autotomi/app/modules/send_request_admin/views/send_request_admin_view.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MycarController extends GetxController with GetSingleTickerProviderStateMixin {
  var flag, isLoading = false.obs, page = 1;
  var hasNextPage = true.obs;
  var isLoadMoreRunning = false.obs;

  List<listMyCar> listMyCarList = [];

  ScrollController? scroll_controller;

  TabController? tabController;
  var tabFlag;
  @override
  void onInit() async {
    // if (Get.arguments != null) {
    //   tabFlag = Get.arguments['tabFlag'];
    // }
    tabController = TabController(length: 3, vsync: this, initialIndex: isReturnCar);
    tabController!.addListener(() {
      page = 1;
      hasNextPage.value = true;
      myCar_Api();
    });
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
        "booking_status": tabController!.index,
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

  getRefundAmount_Api({bookingID, index}) async {
    print(bookingID);
    print(refundAmount);
    print("refundAmount");
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "get_refund_amount",
      method: MethodType.Post,
      params: {
        "booking_id": bookingID,
        'amount': refundAmount,
      },
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          cancelCar_Api(index: index, bookingID: bookingID);
          Toasty.showtoast(response['Message']);
        } else {
          Toasty.showtoast(response['Message']);
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

  cancelCar_Api({bookingID, index}) async {
    print(bookingID);
    print("bookingID");
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "cancle_booking",
      method: MethodType.Post,
      params: {
        "booking_id": bookingID,
      },
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          listMyCarList.removeAt(index);
          update();
          Toasty.showtoast(response['Message']);
        } else {
          Toasty.showtoast(response['Message']);
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

  checkReserveCar_Api({carID, startDate, endDate, index, flag}) async {
    print("carID");
    print(carID);
    print(startDate);
    print(endDate);
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "check_reserve_car",
      method: MethodType.Post,
      params: {
        "car_id": carID,
        "start_date": startDate,
        "end_date": endDate,
      },
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          flag == 1
              ? Get.to(() => SendRequestAdminView(), arguments: {
                  'car_id': listMyCarList[index].carId,
                  'booking_id': listMyCarList[index].bookingId,
                })!
                  .then((value) {
                  if (value != null) {
                    myCar_Api();
                    update();
                  }
                })
              : Get.to(() => CardDetailsView(), arguments: {
                  'flag': 0,
                  'car_id': listMyCarList[index].carId,
                  'booking_id': listMyCarList[index].bookingId,
                  'car_image': listMyCarList[index].carImage![0].image,
                  'car_name': listMyCarList[index].carName,
                  'star_count': listMyCarList[index].starCount,
                  'review_count': listMyCarList[index].reviewCount,
                  'start_date': listMyCarList[index].startDate,
                  'pick_time': listMyCarList[index].pickupTime,
                  'end_date': listMyCarList[index].endDate,
                  'drop_time': listMyCarList[index].dropoffTime,
                  'fare_unlimited_kms': listMyCarList[index].totalFare,
                  'damage_protection_fee': listMyCarList[index].damageProtectionFee,
                  'convenience_fee': listMyCarList[index].damageProtectionFee,
                  'total_fare': listMyCarList[index].totalFare,
                  'security_deposit': listMyCarList[index].securityDeposit,
                  'final_fare': listMyCarList[index].finalFare,
                  'bring_car_me': listMyCarList[index].bringCarMe,
                  'come_pickup_car': listMyCarList[index].comePickupCar,
                });
          // Toasty.showtoast(response['Message']);
        } else {
          Toasty.showtoast(response['Message']);
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

  var remainderDay, isNegative = false.obs;
  int checkRemainderDay(DateTime current, DateTime startDate) {
    print(current);
    print(startDate);
    print("object");

    Duration difference = current.difference(startDate);
    remainderDay = difference.inDays - 1;
    formatDuration(difference);
    print(remainderDay);
    print("remainderDay");
    return difference.inDays;
  }

  String formatDuration(Duration duration) {
    if (duration.isNegative) {
      isNegative.value = true;
      print(isNegative.value);
      print("isNegative.value");
      return '00:00:00';
    } else {
      print(isNegative.value);
      isNegative.value = false;
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      String twoDigitDay = twoDigits(duration.inHours.remainder(24));
      String twoDigitHours = twoDigits(duration.inHours.remainder(24));
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return '$twoDigitDay:';
    }
  }

  var cancelTotalDay, refundAmount, minesAmount, showPercentage;
  int calculateCancelCarDays(DateTime reserveDate, DateTime currentDate, amount, totalAmount) {
    print("yes");
    print(reserveDate);
    print(currentDate);
    print(amount);
    print(totalAmount);
    print("amount");
    Duration difference = currentDate.difference(reserveDate);
    cancelTotalDay = difference.inDays + 1;
    print(cancelTotalDay);
    print("total day");

    if (cancelTotalDay <= 3) {
      showPercentage = 100;
      refundAmount = totalAmount;
      print("Return Amount :--- 100%");
    } else if (cancelTotalDay > 3 && cancelTotalDay <= 28) {
      showPercentage = 20;
      minesAmount = totalAmount - amount;
      refundAmount = minesAmount + (amount / 100) * 20;
      print(refundAmount);
      print("Return Amount :--- 20%");
    } else {
      showPercentage = 0;
      refundAmount = totalAmount - amount;

      //refundAmount = minesAmount + (amount / 100) * 20;
      //refundAmount = amount - percentageAmount;
      // print(percentageAmount);
      print(refundAmount);
      print("Return Amount only deposited");
    }
    return difference.inDays;
  }

  onWillPopScope() {
    myCar_Api();
    update();
  }
}

// if (cancelTotalDay <= 3) {
// showPercentage = 100;
// refundAmount = totalAmount;
// print("Return Amount :--- 100%");
// } else if (cancelTotalDay > 3 && cancelTotalDay <= 28) {
// showPercentage = 20;
// minesAmount = totalAmount - amount;
// refundAmount = minesAmount + (amount / 2);
// print(refundAmount);
// print("Return Amount :--- 50%");
// } else if (cancelTotalDay > 28 && cancelTotalDay <= 56) {
// showPercentage = 20;
// minesAmount = totalAmount - amount;
// refundAmount = minesAmount + (amount / 100) * 20;
// //refundAmount = amount - percentageAmount;
// // print(percentageAmount);
// print(refundAmount);
// print("Return Amount :--- 20%");
// } else {
// showPercentage = 0;
// refundAmount = totalAmount - amount;
// print("else part");
// }
