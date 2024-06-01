import 'package:get/get.dart';

class PersonalInfo4Controller extends GetxController {
  var flag;
  @override
  void onInit() {
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
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
