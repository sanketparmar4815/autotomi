import 'package:get/get.dart';

import '../controllers/rentcar_controller.dart';

class RentcarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RentcarController>(
      () => RentcarController(),
    );
  }
}
