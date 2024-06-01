import 'package:get/get.dart';

import '../controllers/how_its_work_controller.dart';

class HowItsWorkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HowItsWorkController>(
      () => HowItsWorkController(),
    );
  }
}
