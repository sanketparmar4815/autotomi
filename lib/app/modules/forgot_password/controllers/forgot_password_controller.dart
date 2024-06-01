import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/verification/views/verification_view.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController email = TextEditingController();

  var isLoading = false.obs;

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

  forgotPassword_Api() {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "forgot_password",
      method: MethodType.Post,
      params: {
        "email_id": email.text,
      },
      successCallback: (response, message) async {
        if (response['Status'] == 1) {
          print("resend Api Response :-- ${response}");

          Get.to(() => VerificationView(), arguments: {'flag': 1, 'emailID': email.text, 'isLogin': 2});

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
      timeOutCallback: () {
        Toasty.showtoast('something is wrong please try again');
        isLoading.value = false;
      },
    );
  }
}
