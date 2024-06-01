import 'package:get/get.dart';

import '../controllers/mycar_details_controller.dart';

class MycarDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MycarDetailsController>(
      () => MycarDetailsController(),
    );
  }
}
