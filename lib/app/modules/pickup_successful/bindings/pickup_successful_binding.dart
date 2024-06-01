import 'package:get/get.dart';

import '../controllers/pickup_successful_controller.dart';

class PickupSuccessfulBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickupSuccessfulController>(
      () => PickupSuccessfulController(),
    );
  }
}
