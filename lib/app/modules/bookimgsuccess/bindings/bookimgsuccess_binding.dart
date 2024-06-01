import 'package:get/get.dart';

import '../controllers/bookimgsuccess_controller.dart';

class BookimgsuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookimgsuccessController>(
      () => BookimgsuccessController(),
    );
  }
}
