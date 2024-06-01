import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  var isObSecure = true.obs, isLoading = false.obs;
  var isConObSecure = true.obs;
  var isOldSecure = true.obs;
  @override
  void onInit() {
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

  changePassword_Api() {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "change_password",
      method: MethodType.Post,
      params: {
        "password": oldPassword.text,
        "new_pass": newPassword.text,
      },
      successCallback: (response, message) async {
        if (response['Status'] == 1) {
          print("resend Api Response :-- ${response}");
          isLoading.value = false;
          Get.back();
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
      timeOutCallback: () {
        Toasty.showtoast('something is wrong please try again');
        isLoading.value = false;
      },
    );
  }
}
