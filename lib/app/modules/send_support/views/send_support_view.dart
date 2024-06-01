import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controllers/send_support_controller.dart';

class SendSupportView extends GetView<SendSupportController> {
  const SendSupportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SendSupportController>(
        init: SendSupportController(),
        builder: (logic) {
          bool keyBoardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
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
                  backgroundColor: Colors.white,
                  appBar: commonWidget.customAppbar(
                    arroOnTap: () {
                      Get.back();
                    },
                    actions: SizedBox(),
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    titleText: controller.flag == 1 ? "Contact Us" : stringsUtils.Support,
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                commonWidget.customTextfield(
                                  controller: controller.subjectText,
                                  label: stringsUtils.Subject,
                                  hintText: stringsUtils.YourSubject,
                                ),
                                SizedBox(height: 10),
                                commonWidget.customTextfield(
                                  controller: controller.messageText,
                                  label: stringsUtils.Message,
                                  hintText: stringsUtils.Enterhere,
                                  maxLines: 6,
                                ),
                                SizedBox(height: Get.height * 0.35),
                              ],
                            ),
                          ),
                        ),
                        keyBoardOpen
                            ? SizedBox()
                            : SafeArea(
                                child: commonWidget.customButton(
                                  onTap: () async {
                                    if (validation()) {
                                      await controller.createSupportTicket_Api();
                                    }
                                  },
                                  height: 48.0,
                                  text: stringsUtils.Submit,
                                  textfontsize: 16.0,
                                ),
                              ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  bool validation() {
    if (controller.subjectText.text.isEmpty) {
      Toasty.showtoast("please enter subject");
      return false;
    } else if (controller.messageText.text.isEmpty) {
      Toasty.showtoast("please enter message");
      return false;
    }
    return true;
  }
}
