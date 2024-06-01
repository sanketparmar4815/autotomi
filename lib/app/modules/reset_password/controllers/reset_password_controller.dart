import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  var isObSecure = true.obs, isLoading = false.obs, emailID;
  var isConObSecure = true.obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      emailID = Get.arguments;
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

  resetPassword_Api() {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "reset_password",
      method: MethodType.Post,
      params: {
        "email_id": emailID.toString(),
        "new_pass": newPassword.text,
      },
      successCallback: (response, message) async {
        if (response['Status'] == 1) {
          print("resend Api Response :-- ${response}");
          Get.back();
          Get.back();
          Get.back();
          isLoading.value = false;
          Toasty.showtoast(response['Message']);
        } else {
          isLoading.value = false;
          Toasty.showtoast(response['Message']);
        }
      },
      failureCallback: (status, message) {
        isLoading.value = false;
        print("failureCallback  status :---  ${status}");
        print("failureCallback  message :---  ${message}");
      },
    );
  }
}
