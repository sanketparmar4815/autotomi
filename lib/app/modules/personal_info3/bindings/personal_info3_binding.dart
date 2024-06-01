import 'package:get/get.dart';

import '../controllers/personal_info3_controller.dart';

class PersonalInfo3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalInfo3Controller>(
      () => PersonalInfo3Controller(),
    );
  }
}
