import 'package:get/get.dart';

import '../controllers/completed_ride_controller.dart';

class CompletedRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletedRideController>(
      () => CompletedRideController(),
    );
  }
}
