import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controllers/send_request_admin_controller.dart';

class SendRequestAdminView extends GetView<SendRequestAdminController> {
  const SendRequestAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SendRequestAdminController>(
        init: SendRequestAdminController(),
        builder: (logic) {
          bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
          return Obx(() {
            return ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              opacity: 0,
              progressIndicator: customerIndicator,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Scaffold(
                  backgroundColor: color.white,
                  appBar: commonWidget.customAppbar(
                    fontsize: 20.0,
                    arroOnTap: () {
                      Get.back();
                    },
                    titleText: 'Send Request Admin',
                    actions: SizedBox(),
                    centerTitle: true,
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 0.04),
                        commonWidget.customTextfield(
                          controller: controller.sendRequestAdmin,
                          label: "We would like to know the reason why you want to reserve two cars since you cannot drive two cars at a time.",
                          hintText: "Enter",
                          maxLines: 7,
                        ),
                        Spacer(),
                        keyboardIsOpen
                            ? SizedBox()
                            : commonWidget.customButton(
                                onTap: () {
                                  if (controller.sendRequestAdmin.text.isEmpty) {
                                    Toasty.showtoast("please enter reason why you want to reserve two cars");
                                  } else {
                                    controller.sendRequestAdmin_Api();
                                  }
                                },
                                text: "Submit",
                                Ccolor: color.appColor,
                              ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }
}
