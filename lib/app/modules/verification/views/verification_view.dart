import 'package:autotomi/app/modules/create_account/views/create_account_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../reset_password/views/reset_password_view.dart';
import '../controllers/verification_controller.dart';
import '../../../../common/constant.dart';
import '../../../../common/Strings.dart';
import '../../../../common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';

class VerificationView extends GetView<VerificationController> {
  const VerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerificationController>(
      assignId: true,
      init: VerificationController(),
      builder: (logic) {
        return Obx(() {
          return ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            opacity: 0,
            progressIndicator: customerIndicator,
            child: Scaffold(
              backgroundColor: color.white,
              appBar: commonWidget.customAppbar(
                arroOnTap: () {
                  Get.back();
                },
                titleText: stringsUtils.verification,
                actions: SizedBox(),
                centerTitle: true,
                backgroundColor: color.white,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: hw.height * 0.055),
                            Center(
                              child: commonWidget.mediumText(stringsUtils.otp, fontsize: 16.0, height: 1.5, textAlign: TextAlign.center),
                            ),
                            SizedBox(height: hw.height * 0.06),
                            Center(
                              child: Pinput(
                                cursor: Container(
                                  width: 8,
                                  height: 2,
                                  color: color.black,
                                ),
                                controller: controller.pin,
                                onCompleted: (pin) {},
                                onChanged: (value) {},
                                submittedPinTheme: PinTheme(
                                  width: 62,
                                  height: 62,
                                  margin: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                    color: color.appColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: color.appColor, width: 1.5),
                                  ),
                                ),
                                focusedPinTheme: PinTheme(
                                  width: 62,
                                  height: 62,
                                  margin: EdgeInsets.only(right: 5),
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Bold',
                                  ),
                                  decoration: BoxDecoration(
                                    color: color.fillColor,
                                    borderRadius: BorderRadius.circular(15),
                                    // border: Border.all(color: color.appColor, width: 1.5),
                                  ),
                                ),
                                defaultPinTheme: PinTheme(
                                  height: 62,
                                  margin: EdgeInsets.only(right: 5),
                                  width: 62,
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Bold',
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: color.fillColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: hw.height * 0.035),
                            InkWell(
                              onTap: () {
                                controller.resendOtp_Api();
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Center(
                                child: commonWidget.semiBoldText(stringsUtils.resend_Code, fontsize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: commonWidget.customButton(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        if (validation()) {
                          await controller.verificationEmail_Api();
                        }

                        // if (controller.flag == 0) {
                        //   FocusScope.of(context).unfocus();
                        //   Get.offAll(() => CreateAccountView());
                        // } else if (controller.flag == 1) {
                        //   FocusScope.of(context).unfocus();
                        //   Get.to(() => ResetPasswordView());
                        // }
                      },
                      text: stringsUtils.verify,
                    ),
                  ),
                  SizedBox(height: hw.height * 0.025),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  bool validation() {
    if (controller.pin.text.isEmpty) {
      Toasty.showtoast("Please Enter OTP");
      return false;
    } else {
      return true;
    }
  }
}
