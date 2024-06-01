import 'package:get/get.dart';

import '../controllers/favoritecar_controller.dart';

class FavoritecarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritecarController>(
      () => FavoritecarController(),
    );
  }
}
