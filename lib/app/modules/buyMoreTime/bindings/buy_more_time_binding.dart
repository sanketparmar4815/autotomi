import 'package:get/get.dart';

import '../controllers/buy_more_time_controller.dart';

class BuyMoreTimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyMoreTimeController>(
      () => BuyMoreTimeController(),
    );
  }
}
