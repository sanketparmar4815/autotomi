import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BuyMoreTimeController extends GetxController {
  var time2, totalWeek, totalWeekAmount, totalDay, totalDayAmount, bringCarMe, comePickupCar, discountAmount, couponId;
  var selectDropTime, perDayPrice, perWeekPrice, totalAmount, percentage;
  var carID, flag, carName, starCount, reviewCount, startDate1, pickUpTime, endDate, dropTime, fareUnlimitedKms, damageProtectionFee, convenienceFee, totalFare, securityDeposit, finalFare, bookingID, carImage;

  @override
  void onInit() {
    // perDayPrice = box.read('per_day_price');
    // perWeekPrice = box.read('per_week_price');
    print(perDayPrice);
    print(perWeekPrice);
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
      carID = Get.arguments['car_id'];
      bookingID = Get.arguments['booking_id'];
      carImage = Get.arguments['car_image'];
      carName = Get.arguments['car_name'];
      starCount = Get.arguments['star_count'];
      reviewCount = Get.arguments['review_count'];
      startDate1 = Get.arguments['start_date'];
      pickUpTime = Get.arguments['pick_time'];
      endDate = Get.arguments['end_date'];
      dropTime = Get.arguments['drop_time'];
      fareUnlimitedKms = Get.arguments['fare_unlimited_kms'];
      damageProtectionFee = Get.arguments['damage_protection_fee'];
      convenienceFee = Get.arguments['convenience_fee'];
      totalFare = Get.arguments['total_fare'];
      securityDeposit = Get.arguments['security_deposit'];
      finalFare = Get.arguments['final_fare'];
      perDayPrice = Get.arguments['per_day_price'];
      perWeekPrice = Get.arguments['per_week_price'];
      bringCarMe = Get.arguments['bring_car_me'];
      comePickupCar = Get.arguments['come_pickup_car'];
      discountAmount = Get.arguments['discount_amount'];
      couponId = Get.arguments['coupon_id'];
    }
    print(bringCarMe);
    print(comePickupCar);
    print(securityDeposit);
    print(securityDeposit);

    hereWeGo();
    day = DateTime(
      now.year,
      now.month,
      now.day,
    );
    selectedCalenderDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    checkBookingAvailability();
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

  List bookingCarList = [];
  List<DateTime> days1 = [];

  checkBookingAvailability() {
    print("Api call");
    print(carID);
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "check_booking_availability",
      method: MethodType.Post,
      params: {
        'car_id': carID,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          bookingCarList = response['info'];
          print(bookingCarList);
          print("bookingCarList");

          for (var j = 0; j < bookingCarList.length; j++) {
            for (int i = 0; i <= DateTime.parse(bookingCarList[j]['end_date']).difference(DateTime.parse(bookingCarList[j]['start_date'])).inDays; i++) {
              if (days1.contains(DateTime.parse(bookingCarList[j]['start_date']).add(Duration(days: i)))) {
              } else {
                days1.add(DateTime.parse(bookingCarList[j]['start_date']).add(Duration(days: i)));
              }
            }
            print(days1);
            print('days');
          }

          print("avalubaler Date");
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

  EndTime(BuildContext context) async {
    time2 = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).brightness == Brightness.light
              ? ThemeData.from(colorScheme: ColorScheme.light())
              : ThemeData.from(
                  colorScheme: ColorScheme.dark(),
                ),
          child: child!,
        );
      },
    );
    selectDropTime = DateFormat('HH:mm:ss').format(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        time2.hour,
        time2.minute,
      ),
    );

    update();
  }

  var time_select = [];

  List<String> days = [];
  List date = [];
  List currentMonthData = [];
  List nextMonthData = [];
  List prevMonthData = [];
  List finalMonthData = [];
  List<String> time = [];
  List splitted = [];
  var selectedCalenderDate;
  var formatTime;
  var JsonDatesList;

  var lastday = (DateTime.now().month < 12) ? new DateTime(DateTime.now().year, DateTime.now().month + 1, 0) : new DateTime(DateTime.now().year + 1, 1, 0);
  var month = DateTime.now().month;

  Color an(var ank) {
    for (var i in days) {
      if (i == ank) {
        return Theme.of(Get.context!).brightness == Brightness.light ? color.appColor /*AppColor.primaryColor*/ : Color(0xffE1A6AD);
      }
    }
    return Theme.of(Get.context!).brightness == Brightness.light ? Colors.white : Colors.transparent;
  }

  formatTimeList(String time) {
    formatTime = DateFormat("h:mma").format(
      DateFormat("hh:mm").parse(time),
    );
    return formatTime;
  }

  Color js(var ank) {
    for (var i in days) {
      if (i == ank) {
        return Theme.of(Get.context!).brightness == Brightness.light ? Colors.black : Colors.white;
      }
    }
    return Theme.of(Get.context!).brightness == Brightness.light ? Colors.black : Colors.white;
  }

  finalStep() {
    int nextMonthFirstMonday = getFirstSunday(nextMonthData);
    finalMonthData = [...finalMonthData, ...currentMonthData];
    for (int i = 0; i < nextMonthFirstMonday; i++) {
      finalMonthData.add(nextMonthData[i]);
    }
  }

  int getFirstSunday(List monthData) {
    int firstMondayAt = 0;

    final index = monthData.indexWhere((element) => element['day'] == 'Sunday');
    if (index >= 0) {
      firstMondayAt = index;
    }
    return firstMondayAt;
  }

  letsFun() {
    prevMonthData.clear();
    for (DateTime indexDay = DateTime(month == 1 ? year - 1 : year, month == 1 ? 12 : month - 1, 1); indexDay.month == (month == 1 ? 12 : month - 1); indexDay = indexDay.add(Duration(days: 1))) {
      prevMonthData.add({'full_date': DateFormat('yyyy-MM-dd').format(indexDay), 'date': DateFormat('dd').format(indexDay), 'day': DateFormat('EEEE').format(indexDay)});
    }

    for (DateTime indexDay = DateTime(year, month, 1);
        indexDay.month == month;
        indexDay = indexDay.add(
      Duration(days: 1),
    ),) {
      currentMonthData.add({'full_date': DateFormat('yyyy-MM-dd').format(indexDay), 'date': DateFormat('dd').format(indexDay), 'day': DateFormat('EEEE').format(indexDay)});
    }

    // Next Month
    nextMonthData.clear();
    for (DateTime indexDay = DateTime(month == 12 ? year + 1 : year, month == 12 ? 1 : month + 1, 1); indexDay.month == (month == 12 ? 1 : month + 1); indexDay = indexDay.add(Duration(days: 1))) {
      nextMonthData.add({'full_date': DateFormat('yyyy-MM-dd').format(indexDay), 'date': DateFormat('dd').format(indexDay), 'day': DateFormat('EEEE').format(indexDay)});
    }
  }

  getPreviousMonthLeadingDates() async {
    int prevDays = 0;
    int currMonthFirstMonday = getFirstSunday(currentMonthData);
    prevDays = 7 - currMonthFirstMonday;

    for (int i = 0; i < prevMonthData.length; i++) {
      if (currMonthFirstMonday != 0) {
        if (i == prevMonthData.length - prevDays) {
          prevDays--;
          finalMonthData.add(prevMonthData[i]);
        }
      }
    }
  }

  var day;
  final now = DateTime.now();

  hereWeGo() {
    letsFun();
    getPreviousMonthLeadingDates();
    finalStep();
  }

  var CalenderDay;

  var startDate = DateTime(DateTime.now().year, DateTime.now().month + 0, 1);
  var year = DateTime.now().year;
  var user_id, isLoading = false.obs;
}
