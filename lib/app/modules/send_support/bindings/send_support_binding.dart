import 'package:get/get.dart';

import '../controllers/send_support_controller.dart';

class SendSupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendSupportController>(
      () => SendSupportController(),
    );
  }
}
