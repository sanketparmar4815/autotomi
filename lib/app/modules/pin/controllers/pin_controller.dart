import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/pickup_successful/views/pickup_successful_view.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PinController extends GetxController {
  TextEditingController pin = TextEditingController();
  TextEditingController agentName = TextEditingController();
  var flag, bookingID, isLoading = false.obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
      bookingID = Get.arguments['booking_id'];
      update();
    }
    print('fhdkjhdfjkhdfjkhdf');
    print(flag);
    print(bookingID);
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

  getCarKey_Api() async {
    print(bookingID);
    print("get booking id");
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "get_car_key",
      method: MethodType.Post,
      params: {
        "agent_name": agentName.text,
        "code": pin.text,
        "booking_id": bookingID,
        "is_return": flag == 2 || flag == 3 ? 'return' : 'pickup',
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          Get.offAll(() => PickupSuccessfulView(), arguments: {
            'flag': flag,
            'booking_id': bookingID,
          });
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
