import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(
      assignId: true,
      init: ContactUsController(),
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
                titleText: controller.flag == 1 ? stringsUtils.Support : stringsUtils.contact_Us,
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
                            SizedBox(height: hw.height * 0.03),
                            commonWidget.customTextfield(
                              hintText: 'Your Subject',
                              controller: controller.subject,
                              label: stringsUtils.subject,
                            ),
                            SizedBox(height: 5),
                            commonWidget.customTextfield(
                              hintText: 'Enter here...',
                              controller: controller.message,
                              label: stringsUtils.message,
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: commonWidget.customButton(
                      onTap: () async {
                        if (validation()) {
                          await controller.contactUs_Api();
                        }
                      },
                      text: stringsUtils.submit,
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
    if (controller.subject.text.isEmpty) {
      Toasty.showtoast("Enter Subject");
      return false;
    } else if (controller.message.text.isEmpty) {
      Toasty.showtoast("Enter Message");
      return false;
    } else {
      return true;
    }
  }
}
