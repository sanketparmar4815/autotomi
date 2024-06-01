import 'package:get/get.dart';

import '../controllers/rentcardetails_controller.dart';

class RentcardetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RentcardetailsController>(
      () => RentcardetailsController(),
    );
  }
}
