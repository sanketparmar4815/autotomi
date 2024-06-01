import 'package:get/get.dart';

import '../controllers/payment_successfull_controller.dart';

class PaymentSuccessfullBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentSuccessfullController>(
      () => PaymentSuccessfullController(),
    );
  }
}
