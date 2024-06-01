import 'package:get/get.dart';

class BookimgsuccessController extends GetxController {
  var bookingID;
  @override
  void onInit() {
    if(Get.arguments != null){
      bookingID = Get.arguments;
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

}
