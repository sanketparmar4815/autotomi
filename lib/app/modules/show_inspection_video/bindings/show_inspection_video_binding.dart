import 'package:get/get.dart';

import '../controllers/show_inspection_video_controller.dart';

class ShowInspectionVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowInspectionVideoController>(
      () => ShowInspectionVideoController(),
    );
  }
}
