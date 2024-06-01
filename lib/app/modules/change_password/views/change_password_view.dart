import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controllers/change_password_controller.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      assignId: true,
      init: ChangePasswordController(),
      builder: (logic) {
        bool keyBordOpen = MediaQuery.of(context).viewInsets.bottom != 0;
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
                titleText: stringsUtils.change_Password,
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
                            SizedBox(height: hw.height * 0.030),
                            commonWidget.customTextfield(
                              hintText: stringsUtils.password,
                              controller: controller.oldPassword,
                              label: stringsUtils.old_Password,
                              letterSpacing: 1.0,
                              obscureText: controller.isOldSecure.value,
                              suffixIcon: Obx(() {
                                return InkWell(
                                  onTap: () {
                                    controller.isOldSecure.value = !controller.isOldSecure.value;
                                    controller.update();
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: controller.isOldSecure.value ? Image.asset(assetsUrl.Eyeoff, color: Color(0xff0A0A0A), scale: 3.5) : Image.asset(assetsUrl.Eyeon, color: Color(0xff0A0A0A), scale: 3.5),
                                );
                              }),
                            ),
                            commonWidget.customTextfield(
                              hintText: stringsUtils.password,
                              controller: controller.newPassword,
                              label: stringsUtils.new_Password,
                              letterSpacing: 1.0,
                              obscureText: controller.isObSecure.value,
                              suffixIcon: Obx(() {
                                return InkWell(
                                  onTap: () {
                                    controller.isObSecure.value = !controller.isObSecure.value;
                                    controller.update();
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: controller.isObSecure.value ? Image.asset(assetsUrl.Eyeoff, color: Color(0xff0A0A0A), scale: 3.5) : Image.asset(assetsUrl.Eyeon, color: Color(0xff0A0A0A), scale: 3.5),
                                );
                              }),
                            ),
                            SizedBox(height: 16),
                            commonWidget.customTextfield(
                              hintText: stringsUtils.password,
                              controller: controller.confirmNewPassword,
                              label: stringsUtils.con_new_Password,
                              letterSpacing: 1.0,
                              obscureText: controller.isConObSecure.value,
                              suffixIcon: Obx(() {
                                return InkWell(
                                  onTap: () {
                                    controller.isConObSecure.value = !controller.isConObSecure.value;
                                    controller.update();
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: controller.isConObSecure.value ? Image.asset(assetsUrl.Eyeoff, color: Color(0xff0A0A0A), scale: 3.5) : Image.asset(assetsUrl.Eyeon, color: Color(0xff0A0A0A), scale: 3.5),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  keyBordOpen
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: commonWidget.customButton(
                            onTap: () async {
                              if (validate()) {
                                await controller.changePassword_Api();
                              }
                            },
                            text: stringsUtils.change_Password,
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

  bool validate() {
    if (controller.oldPassword.text.isEmpty) {
      Toasty.showtoast('Please Enter Your Current Password');
      return false;
    } else if (controller.oldPassword.text.length < 6) {
      Toasty.showtoast('Please Enter min 6 Character Password');
      return false;
    } else if (controller.newPassword.text.isEmpty) {
      Toasty.showtoast('Please Enter Your New Password');
      return false;
    } else if (controller.newPassword.text.length < 6) {
      Toasty.showtoast('Please Enter min 6 Character Password');
      return false;
    } else if (controller.confirmNewPassword.text.isEmpty) {
      Toasty.showtoast('Please Enter Your Confirm New Password');
      return false;
    } else if (controller.confirmNewPassword.text.length < 6) {
      Toasty.showtoast('Please Enter min 6 Character Password');
      return false;
    } else if (controller.newPassword.text != controller.confirmNewPassword.text) {
      Toasty.showtoast('Password Does Not Match');
      return false;
    } else {
      return true;
    }
  }
}
