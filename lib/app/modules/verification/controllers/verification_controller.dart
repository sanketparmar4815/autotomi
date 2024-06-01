import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/create_account/views/create_account_view.dart';
import 'package:autotomi/app/modules/reset_password/views/reset_password_view.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  TextEditingController pin = TextEditingController();
  var flag, userToken, emailID, isLogin, isLoading = false.obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
      emailID = Get.arguments['emailID'];
      isLogin = Get.arguments['isLogin'];
      print('flag====>');
      print(flag);
      print(emailID);
      print('userToken');
      print(userToken);
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

  verificationEmail_Api() {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "verification_for_email",
      method: MethodType.Post,
      params: {
        "email_id": emailID,
        "temp_pass": pin.text,
        "is_login": isLogin,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          print(flag);
          if (flag == 0) {
            Get.to(() => CreateAccountView(), arguments: {'userToken': response['UserToken']});
          } else if (flag == 1) {
            Get.to(() => ResetPasswordView(), arguments: emailID.toString());
          }
          Toasty.showtoast('email verification successful');
        } else {
          Toasty.showtoast(response['Message']);
          print('response status is 0');
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

  resendOtp_Api() {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "forgot_password",
      method: MethodType.Post,
      params: {
        "email_id": emailID,
      },
      successCallback: (response, message) async {
        if (response['Status'] == 1) {
          isLoading.value = false;
          Toasty.showtoast(response['Message']);
          print("resend Api Response :-- ${response}");
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
