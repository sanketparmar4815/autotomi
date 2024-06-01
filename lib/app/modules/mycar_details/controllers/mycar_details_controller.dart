import 'package:autotomi/app/Model/list_my_car_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/card_details/views/card_details_view.dart';
import 'package:autotomi/app/modules/send_request_admin/views/send_request_admin_view.dart';
import 'package:autotomi/common/constant.dart';
import 'package:get/get.dart';

class MycarDetailsController extends GetxController {
  List list = [
    {'name': 'Fare(Unlimited Kms without Fuel)', 'price': '£100'},
    {'name': 'Damage Protection Fee', 'price': '+£30'},
    {'name': 'Convenience Fee', 'price': '+£30'},
    {'name': 'Total Fare', 'price': '£160'},
    {'name': 'Security Deposit', 'price': '+£130'},
    {'name': 'Final Fare', 'price': '£290'},
  ];
  var isNegative = false.obs, isAdminApprove, countyId, carBookingId;
  var carID, flag, carName, starCount, reviewCount, startDate, pickUpTime, endDate, dropTime, fareUnlimitedKms, damageProtectionFee, convenienceFee, totalFare, securityDeposit, finalFare, bookingID, dropLocation, pickUpLocation;
  List<CarImage> carImageList = [];
  List<listMyCar> listMyCarList = [];
  var isLoading = false.obs, reserveDate, comePickupCar, bringCarMe, extraPrice, extraDays, couponId;
  var showTotalFare, showTotalFinalFare, totalDay, totalHour, rideEndDay, showMinutes, newDate, newHour, perDay, perWeek, currentCarAmount, isReserve, discountAmount;

  @override
  void onInit() {
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
      currentCarAmount = Get.arguments['total_fare'];
      if (flag == 3) {
        listMyCarList.add(Get.arguments['data']);
        carID = listMyCarList[0].carId;
        bookingID = listMyCarList[0].bookingId;
        carImageList = listMyCarList[0].carImage!;
        carName = listMyCarList[0].carName;
        starCount = listMyCarList[0].starCount;
        reviewCount = listMyCarList[0].reviewCount;
        startDate = listMyCarList[0].startDate;
        pickUpTime = listMyCarList[0].pickupTime;
        endDate = listMyCarList[0].endDate;
        dropTime = listMyCarList[0].dropoffTime;
        fareUnlimitedKms = listMyCarList[0].totalFare;
        damageProtectionFee = 10;
        convenienceFee = 10;
        totalFare = listMyCarList[0].totalFare;
        securityDeposit = 50;
        finalFare = listMyCarList[0].finalFare;
        perDay = listMyCarList[0].pricePerDay;
        perWeek = listMyCarList[0].pricePerWeek;
        pickUpLocation = listMyCarList[0].pickupLocation;
        dropLocation = listMyCarList[0].dropoffTime;
        isReserve = listMyCarList[0].isReserve;
        reserveDate = listMyCarList[0].reservedDatetime;
        bringCarMe = listMyCarList[0].bringCarMe;
        comePickupCar = listMyCarList[0].comePickupCar;
        extraDays = listMyCarList[0].extraDays;
        extraPrice = listMyCarList[0].extraPrice;
        discountAmount = listMyCarList[0].discountAmount;
        couponId = listMyCarList[0].countryId;
        isAdminApprove = listMyCarList[0].isAdminApprove;
        countyId = listMyCarList[0].countryId;
        carBookingId = listMyCarList[0].carBookingId;
        print(isReserve);
        print("isReserve");
      } else {
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
        isReserve = Get.arguments['is_reserve'];
        reserveDate = Get.arguments['reserve_date'];
        bringCarMe = Get.arguments['bring_car_me'];
        comePickupCar = Get.arguments['come_pickup_car'];
        extraDays = Get.arguments['extra_days'];
        extraPrice = Get.arguments['extra_price'];
        discountAmount = Get.arguments['discount_amount'];
        couponId = Get.arguments['coupon_id'];
        isAdminApprove = Get.arguments['is_admin_approve'];
        countyId = Get.arguments['county_id'];
        carBookingId = Get.arguments['car_booking_id'];
      }
    }

    calculateTotalDays(DateTime.parse(startDate), DateTime.parse(endDate));
    print(flag);
    print("flag");
    print(extraDays);
    print(extraPrice);
    if (flag == 2) {
      calculateTotalHour(DateTime.now(), DateTime.parse(endDate));
    } else {
      calculateTotalHour(DateTime.parse(startDate.replaceAll(startDate.toString().split("T").last.toString().split(".").first.toString().replaceAll("T", " "), pickUpTime)), DateTime.parse("${DateTime.now().toString()}Z").toLocal());
    }

    super.onInit();
  }

  int calculateTotalDays(DateTime startDate, DateTime endDate) {
    print(startDate);
    print(endDate);
    Duration difference = endDate.difference(startDate);
    totalDay = difference.inDays + 1;
    print(totalDay);
    print("total day");
    return difference.inDays;
  }

  var remainderDay;
  int checkRemainderDay(DateTime current, DateTime startDate) {
    print(current);
    print(startDate);
    Duration difference = startDate.difference(current);
    remainderDay = difference.inDays - 1;
    print(remainderDay);
    print("remainderDay");
    formatDuration(difference);

    return difference.inDays;
  }

  String formatDuration(Duration duration) {
    if (duration.isNegative) {
      isNegative.value = true;
      print(isNegative.value);
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

  int calculateTotalHour(DateTime startDate, DateTime endDate) {
    print(startDate);
    print(endDate);
    print("object");

    if (flag == 2) {
      DateTime now = DateTime.now();
      totalHour = 24 - now.hour;

      Duration difference = endDate.difference(startDate);
      rideEndDay = difference.inDays + 1;
      formatDuration(difference);
      print(rideEndDay);
      print(totalHour);
      print("rutik ===>  ${rideEndDay}");
      return rideEndDay;
    } else {
      Duration difference = startDate.difference(endDate);
      totalHour = difference.inHours;
      formatDuration(difference);
      showMinutes = difference.inMinutes.remainder(60);
      return difference.inDays;
    }

    print("show minits");
    print(showMinutes);
    print(totalHour);

    // print(totalMinutes);
    // print("total Minutes");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  checkReserveCar_Api({flag}) async {
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
                  'car_id': carID,
                  'booking_id': bookingID,
                })
              : Get.to(
                  () => CardDetailsView(),
                  arguments: {
                    'flag': flag,
                    'car_id': carID,
                    'booking_id': bookingID,
                    'car_image': carImageList[0].image,
                    'car_name': carName,
                    'start_date': startDate,
                    'pick_time': pickUpTime,
                    'end_date': endDate,
                    'drop_time': dropTime,
                    'fare_unlimited_kms': totalFare,
                    'damage_protection_fee': damageProtectionFee,
                    'convenience_fee': convenienceFee,
                    'total_fare': totalFare,
                    'security_deposit': securityDeposit,
                    'final_fare': finalFare,
                    'bring_car_me': bringCarMe,
                    'come_pickup_car': comePickupCar,
                  },
                );
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

  getRefundAmount_Api() async {
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
          Get.back(result: 1);
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

  var cancelTotalDay, refundAmount, minesAmount, showPercentage;
  int calculateCancelCarDays(DateTime reserveDate, DateTime startDate, amount, totalAmount) {
    print(reserveDate);
    print(startDate);
    print(amount);
    print(totalAmount);
    print("amount");
    Duration difference = startDate.difference(reserveDate);
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

    // if (cancelTotalDay <= 3) {
    //   showPercentage = 100;
    //   refundAmount = totalAmount;
    //
    //   print("Return Amount :--- 100%");
    // } else if (cancelTotalDay > 3 && cancelTotalDay <= 28) {
    //   showPercentage = 50;
    //   minesAmount = totalAmount - amount;
    //   refundAmount = minesAmount + (amount / 2);
    //   print(refundAmount);
    //   print("Return Amount :--- 50%");
    // } else if (cancelTotalDay > 28 && cancelTotalDay <= 84) {
    //   showPercentage = 20;
    //   minesAmount = totalAmount - amount;
    //   refundAmount = minesAmount + (amount / 100) * 20;
    //   //refundAmount = amount - percentageAmount;
    //   // print(percentageAmount);
    //   // print(refundAmount);
    //   print("Return Amount :--- 20%");
    // } else {
    //   showPercentage = 0;
    //   refundAmount = totalAmount - amount;
    //   print("else part");
    // }
  }

  onWillPopScope() {
    Get.back(result: 2);
  }
}
