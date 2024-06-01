import 'package:get/get.dart';

import '../../../Model/list_my_car_model.dart';

class CompletedRideDetailsController extends GetxController {
  var isLoading = false.obs;

  List list = [
    {'name': 'Rented For', 'price': '1 Day'},
    {'name': 'Fare(Unlimited Kms without Fuel)', 'price': '£100'},
    {'name': 'Damage Protection Fee', 'price': '+£30'},
    {'name': 'Convenience Fee', 'price': '+£30'},
    {'name': 'Total Fare', 'price': '£160'},
    {'name': 'Security Deposit', 'price': '+£130'},
    {'name': 'Final Fare', 'price': '£290'},
  ];
  List<CarImage> carImageList = [];
  var carID, showTotalFare, showTotalFinalFare, extraDays, extraPrice, bringCarMe, comePickupCar, discountAmount, totalDay, carName, starCount, reviewCount, startDate, pickUpTime, endDate, dropTime, fareUnlimitedKms, damageProtectionFee, convenienceFee, totalFare, securityDeposit, finalFare, bookingID, perDay, perWeek, pickUpLocation, dropLocation;
  int calculateTotalDays(DateTime startDate, DateTime endDate) {
    print(startDate);
    print(endDate);
    Duration difference = endDate.difference(startDate);
    totalDay = difference.inDays + 1;
    print(totalDay);
    print("total day");
    return difference.inDays;
  }

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
      dropLocation = Get.arguments['drop_location'];
      pickUpLocation = Get.arguments['pickUp_location'];
      bringCarMe = Get.arguments['bring_car_me'];
      comePickupCar = Get.arguments['come_pickup_car'];
      extraDays = Get.arguments['extra_days'];
      extraPrice = Get.arguments['extra_price'];
      discountAmount = Get.arguments['discount_amount'];
    }
    print("dropLocation is her $dropLocation");
    calculateTotalDays(DateTime.parse(startDate), DateTime.parse(endDate));
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
}
