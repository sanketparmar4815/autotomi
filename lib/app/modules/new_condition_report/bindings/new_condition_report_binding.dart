import 'package:get/get.dart';

import '../controllers/new_condition_report_controller.dart';

class NewConditionReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewConditionReportController>(
      () => NewConditionReportController(),
    );
  }
}
