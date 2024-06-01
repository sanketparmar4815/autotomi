import 'package:get/get.dart';

import '../controllers/bookimgcar_controller.dart';

class BookimgcarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookimgcarController>(
      () => BookimgcarController(),
    );
  }
}
