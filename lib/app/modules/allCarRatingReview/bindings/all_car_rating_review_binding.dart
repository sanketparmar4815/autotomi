import 'package:get/get.dart';

import '../controllers/all_car_rating_review_controller.dart';

class AllCarRatingReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllCarRatingReviewController>(
      () => AllCarRatingReviewController(),
    );
  }
}
