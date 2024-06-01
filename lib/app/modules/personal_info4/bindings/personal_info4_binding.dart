import 'package:get/get.dart';

import '../controllers/personal_info4_controller.dart';

class PersonalInfo4Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalInfo4Controller>(
      () => PersonalInfo4Controller(),
    );
  }
}
