import 'package:get/get.dart';

import '../controllers/personal_info2_controller.dart';

class PersonalInfo2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalInfo2Controller>(
      () => PersonalInfo2Controller(),
    );
  }
}
