import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SendRequestAdminController extends GetxController {
  TextEditingController sendRequestAdmin = TextEditingController();
  var isLoading = false.obs, carId, bookingId;
  @override
  void onInit() {
    if (Get.arguments != null) {
      carId = Get.arguments['car_id'];
      bookingId = Get.arguments['booking_id'];
    }
    print(carId);
    print(bookingId);
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

  sendRequestAdmin_Api() async {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "send_car_reserve_request",
      method: MethodType.Post,
      params: {
        "car_id": carId,
        "booking_id": bookingId,
        "booking_text": sendRequestAdmin.text,
      },
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          Get.back(result: 1);
          Toasty.showtoast(response['Message']);
        } else {
          Toasty.showtoast(response['Message']);
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
