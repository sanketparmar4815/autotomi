import 'package:get/get.dart';

import '../controllers/change_ride_controller.dart';

class ChangeRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeRideController>(
      () => ChangeRideController(),
    );
  }
}
