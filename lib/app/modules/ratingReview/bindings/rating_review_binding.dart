import 'package:get/get.dart';

import '../controllers/rating_review_controller.dart';

class RatingReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RatingReviewController>(
      () => RatingReviewController(),
    );
  }
}
