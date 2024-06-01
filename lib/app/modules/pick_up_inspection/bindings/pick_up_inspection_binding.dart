import 'package:get/get.dart';

import '../controllers/pick_up_inspection_controller.dart';

class PickUpInspectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickUpInspectionController>(
      () => PickUpInspectionController(),
    );
  }
}
