import 'package:autotomi/app/modules/verification/views/verification_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/Strings.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      assignId: true,
      init: ForgotPasswordController(),
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
                titleText: stringsUtils.forgot_Password,
                actions: SizedBox(),
                centerTitle: true,
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
                              child: commonWidget.mediumText(stringsUtils.reset_your_Password, fontsize: 16.0, height: 1.5, textAlign: TextAlign.center),
                            ),
                            SizedBox(height: hw.height * 0.025),
                            commonWidget.customTextfield(
                              hintText: stringsUtils.enter_Email,
                              controller: controller.email,
                              label: stringsUtils.email,
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
                            await controller.forgotPassword_Api();
                          }

                          // Get.to(() => VerificationView(), arguments: {'flag': 1});
                        },
                        text: stringsUtils.forgot_Password),
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
    if (controller.email.text.isEmpty) {
      Toasty.showtoast('Please Enter Your Email Address');
      return false;
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(controller.email.text)) {
      Toasty.showtoast('Please Enter Valid Email');
      return false;
    } else {
      return true;
    }
  }
}
