import 'package:get/get.dart';

import '../controllers/send_request_admin_controller.dart';

class SendRequestAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendRequestAdminController>(
      () => SendRequestAdminController(),
    );
  }
}
