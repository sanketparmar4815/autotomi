import 'package:get/get.dart';

import '../controllers/my_offer_controller.dart';

class MyOfferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyOfferController>(
      () => MyOfferController(),
    );
  }
}
