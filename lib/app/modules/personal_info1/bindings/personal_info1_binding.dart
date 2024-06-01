import 'package:get/get.dart';

import '../controllers/personal_info1_controller.dart';

class PersonalInfo1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalInfo1Controller>(
      () => PersonalInfo1Controller(),
    );
  }
}
