import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  var isLoading = false.obs, flag;
  @override
  void onInit() {
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
    }
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

  contactUs_Api() async {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "add_contact_us",
      method: MethodType.Post,
      params: {
        'subject': subject.text,
        'message': message.text,
      },
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          Get.back();
          Toasty.showtoast(flag == 1 ? "Support added successful" : response['Message']);
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
