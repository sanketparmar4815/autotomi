import 'package:get/get.dart';

import '../controllers/mycar_controller.dart';

class MycarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MycarController>(
      () => MycarController(),
    );
  }
}
