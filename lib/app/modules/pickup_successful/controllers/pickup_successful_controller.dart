import 'package:get/get.dart';

class PickupSuccessfulController extends GetxController {
  var flag, bookingID;
  @override
  void onInit() {
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
      bookingID = Get.arguments['booking_id'];
    }
    print(flag);
    print(bookingID);
    print("rutik");
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
