import 'package:autotomi/app/modules/bottombar/views/bottombar_view.dart';
import 'package:autotomi/app/modules/forgot_password/views/forgot_password_view.dart';

import 'package:autotomi/app/modules/sign_up/views/sign_up_view.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return GetBuilder<LoginController>(
      assignId: true,
      init: LoginController(),
      builder: (logic) {
        return Obx(() {
          return ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            opacity: 0,
            progressIndicator: customerIndicator,
            child: Scaffold(
              backgroundColor: color.white,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 11),
                      SafeArea(
                        child: Center(
                          child: Image.asset(assetsUrl.splashLogo, height: 95, width: 95),
                        ),
                      ),
                      SizedBox(height: 11),
                      commonWidget.semiBoldText(stringsUtils.sign_In, fontsize: 20.0),
                      SizedBox(height: 8),
                      commonWidget.mediumText(
                        stringsUtils.enter_Yore_Email,
                        fontsize: 14.0,
                        tcolor: color.black.withOpacity(0.6),
                        height: 2.0,
                      ),
                      SizedBox(height: hw.height * 0.025),
                      commonWidget.customTextfield(
                        hintText: stringsUtils.enter_Email,
                        controller: controller.email,
                        label: stringsUtils.email,
                      ),
                      SizedBox(height: 16),
                      commonWidget.customTextfield(
                        hintText: stringsUtils.password,
                        controller: controller.password,
                        label: stringsUtils.password,
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
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          controller.email.clear();
                          controller.password.clear();
                          Get.to(() => ForgotPasswordView());
                        },
                        hoverColor: color.transparent,
                        splashColor: color.transparent,
                        child: commonWidget.semiBoldText(stringsUtils.forgot_password, fontsize: 14.0),
                      ),
                      SizedBox(height: hw.height * 0.04),
                      commonWidget.customButton(
                          onTap: () async {
                            if (validate()) {
                              await controller.login_Api();
                            }
                          },
                          text: stringsUtils.sign_In),
                      SizedBox(height: hw.height * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          commonWidget.regularText(stringsUtils.dont_have_an_account, fontsize: 15.0),
                          SizedBox(width: 3),
                          InkWell(
                            onTap: () {
                              controller.email.clear();
                              controller.password.clear();
                              Get.to(() => SignUpView());
                            },
                            splashColor: color.transparent,
                            highlightColor: color.transparent,
                            child: commonWidget.semiBoldText(stringsUtils.sign_Up, fontsize: 15.0, tcolor: color.appColor),
                          ),
                        ],
                      ),
                      SizedBox(height: hw.height * 0.025),
                      Row(
                        children: [
                          Expanded(child: Container(height: 1, color: Color(0xffE1EEE5))),
                          SizedBox(width: 15),
                          commonWidget.regularText(stringsUtils.or_sign_in_With, fontsize: 13.0, tcolor: Color(0xff989898)),
                          SizedBox(width: 15),
                          Expanded(child: Container(height: 1, color: Color(0xffE1EEE5))),
                        ],
                      ),
                      SizedBox(height: hw.height * 0.025),
                      InkWell(
                        onTap: () {
                          controller.email.clear();
                          controller.password.clear();
                          controller.signInWithGoogle();
                          controller.update();
                        },
                        splashColor: color.transparent,
                        highlightColor: color.transparent,
                        child: Container(
                          height: 48,
                          width: hw.width,
                          decoration: ShapeDecoration(
                            color: color.transparent,
                            shape: SmoothRectangleBorder(
                              side: BorderSide(color: color.appColor.withOpacity(0.2), width: 1),
                              borderRadius: SmoothBorderRadius(
                                cornerRadius: 8,
                                cornerSmoothing: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(assetsUrl.google, height: 20, width: 20),
                              SizedBox(width: 10),
                              commonWidget.semiBoldText(stringsUtils.google, fontsize: 16.0, tcolor: color.black),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      device_type == 1
                          ? SizedBox()
                          : InkWell(
                              onTap: () {
                                controller.email.clear();
                                controller.password.clear();
                              },
                              splashColor: color.transparent,
                              highlightColor: color.transparent,
                              child: Container(
                                height: 48,
                                width: hw.width,
                                decoration: ShapeDecoration(
                                  color: color.transparent,
                                  shape: SmoothRectangleBorder(
                                    side: BorderSide(color: color.appColor.withOpacity(0.2), width: 1),
                                    borderRadius: SmoothBorderRadius(
                                      cornerRadius: 8,
                                      cornerSmoothing: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(assetsUrl.apple, height: 20, width: 20),
                                    SizedBox(width: 10),
                                    commonWidget.semiBoldText(stringsUtils.apple, fontsize: 16.0, tcolor: color.black),
                                  ],
                                ),
                              ),
                            ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Get.offAll(() => BottombarView());
                          box.write('country_id', 12);
                          box.write('country_visiting', "Nigeria");
                          box.write('user_id', 0);
                          print(box.read('country_id'));
                          print(box.read('country_visiting'));
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            commonWidget.semiBoldText("Continue as a Guest", fontsize: 16.0, tcolor: color.appColor),

                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: color.appColor,
                            )
                            // Image.asset(assetsUrl.apple, height: 20, width: 20),
                          ],
                        ),
                      ),
                      SizedBox(height: hw.height * 0.03),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  bool validate() {
    if (controller.email.text.isEmpty) {
      Toasty.showtoast('Please Enter Your Email Address');
      return false;
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(controller.email.text)) {
      Toasty.showtoast('Please Enter Valid Email');
      return false;
    } else if (controller.password.text.isEmpty) {
      Toasty.showtoast('Please Enter Your Password');
      return false;
    } else if (controller.password.text.length < 6) {
      Toasty.showtoast('Password Must Contains 6 Characters');
      return false;
    } else {
      return true;
    }
  }
}
