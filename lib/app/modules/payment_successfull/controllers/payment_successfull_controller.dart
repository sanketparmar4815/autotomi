import 'package:get/get.dart';

class PaymentSuccessfullController extends GetxController {
  final count = 0.obs;
  var finalFare, returnFlag, bookingID;
  @override
  void onInit() {
    if (Get.arguments != null) {
      finalFare = Get.arguments['final_fare'];
      returnFlag = Get.arguments['return_flag'];
      bookingID = Get.arguments['booking_id'];
    }
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

  void increment() => count.value++;
}
