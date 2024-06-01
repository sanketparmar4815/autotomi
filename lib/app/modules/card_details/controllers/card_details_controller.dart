import 'package:get/get.dart';

class CardDetailsController extends GetxController {
  var isChecked = false.obs, flag, carImage, carName, starCount, reviewCount, startDate, pickUpTime, endDate, dropTime, fareUnlimitedKms, damageProtectionFee, convenienceFee, securityDeposit, totalFare, finalFare, bookingID;
  var bringCarMe, comePickupCar, carID;
  void toggleCheckbox(bool value) {
    isChecked.value = value;
  }

  @override
  void onInit() {
    isChecked.value = false;

    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
      carID = Get.arguments['car_id'];
      bookingID = Get.arguments['booking_id'];
      carImage = Get.arguments['car_image'];
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
      bringCarMe = Get.arguments['bring_car_me'];
      comePickupCar = Get.arguments['come_pickup_car'];
    }
    print(securityDeposit);
    print(securityDeposit);
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
