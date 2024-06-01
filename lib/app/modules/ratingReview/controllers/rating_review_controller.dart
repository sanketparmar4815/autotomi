import 'package:autotomi/app/Model/raview_rating_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/routes/app_pages.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RatingReviewController extends GetxController {
  var bookingID, isLoading = false.obs, rate = 0.0, carID;

  TextEditingController reviewDescribe = TextEditingController();

  Info? info;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      bookingID = Get.arguments['booking_id'];
    }
    print(bookingID);
    await getCarDetailReview_Api();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getCarDetailReview_Api() async {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "get_booking_details",
      method: MethodType.Post,
      params: {
        "booking_id": bookingID,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          review_rating_model data = review_rating_model.fromJson(response);
          info = data.info;
          carID = data.info!.carId;
        } else {
          // Toasty.showtoast(response['Message']);
          print(response['Message']);
        }
        isLoading.value = false;
      },
      failureCallback: (message, statusCode) {
        print(message.toString());
        print(statusCode);

        isLoading.value = false;
      },
      timeOutCallback: () {
        Toasty.showtoast('something is wrong please try again');
        isLoading.value = false;
      },
    );
  }

  addReviewRating_Api() async {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "add_review",
      method: MethodType.Post,
      params: {
        "car_id": carID,
        "booking_id": bookingID,
        "no_of_star": rate,
        "review_text": reviewDescribe.text,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          Toasty.showtoast(response['Message']);
          Get.offAllNamed(Routes.BOTTOMBAR);
        } else {
          Toasty.showtoast(response['Message']);
          print(response['Message']);
        }
        isLoading.value = false;
      },
      failureCallback: (message, statusCode) {
        print(message.toString());
        print(statusCode);

        isLoading.value = false;
      },
      timeOutCallback: () {
        Toasty.showtoast('something is wrong please try again');
        isLoading.value = false;
      },
    );
  }
}
