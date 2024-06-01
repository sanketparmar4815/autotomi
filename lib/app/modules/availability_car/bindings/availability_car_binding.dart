import 'package:get/get.dart';

import '../controllers/availability_car_controller.dart';

class AvailabilityCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvailabilityCarController>(
      () => AvailabilityCarController(),
    );
  }
}
