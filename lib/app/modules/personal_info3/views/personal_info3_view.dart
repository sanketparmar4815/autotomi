import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../common/Strings.dart';
import '../../../../common/asset.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import '../../bottombar/views/bottombar_view.dart';
import '../../home/views/home_view.dart';
import '../../personal_info4/views/personal_info4_view.dart';
import '../controllers/personal_info3_controller.dart';

class PersonalInfo3View extends GetView<PersonalInfo3Controller> {
  const PersonalInfo3View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalInfo3Controller>(
      assignId: true,
      init: PersonalInfo3Controller(),
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
                titleText: stringsUtils.personal_Info,
                actions: Row(
                  children: [
                    controller.flag == 2
                        ? SizedBox()
                        : InkWell(
                            onTap: () {
                              Get.offAll(() => BottombarView());
                            },
                            splashColor: color.transparent,
                            highlightColor: color.transparent,
                            child: commonWidget.mediumText(stringsUtils.skip, fontsize: 16.0, tcolor: color.appColor),
                          ),
                    SizedBox(width: 15),
                  ],
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: hw.height * 0.035),
                          commonWidget.regularText(stringsUtils.statement_Of_Account, fontsize: 14.0),
                          SizedBox(height: 16),
                          controller.imagePath == null
                              ? Container(
                                  height: 40,
                                  width: hw.width,
                                  decoration: ShapeDecoration(
                                    color: color.appColor.withOpacity(0.1),
                                    shape: SmoothRectangleBorder(
                                      borderRadius: SmoothBorderRadius(
                                        cornerRadius: 8,
                                        cornerSmoothing: 1,
                                      ),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      controller.fromCamera();
                                    },
                                    splashColor: color.transparent,
                                    hoverColor: color.transparent,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          assetsUrl.camera,
                                          scale: 3.5,
                                        ),
                                        SizedBox(width: 7),
                                        commonWidget.semiBoldText(stringsUtils.upload, fontsize: 16.0, tcolor: color.appColor),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 48,
                                  width: hw.width,
                                  decoration: ShapeDecoration(
                                    color: color.fillColor,
                                    shape: SmoothRectangleBorder(
                                      borderRadius: SmoothBorderRadius(
                                        cornerRadius: 8,
                                        cornerSmoothing: 1,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(4),
                                          child: Container(
                                            height: 26,
                                            width: 26,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(image: FileImage(controller.image), fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        SizedBox(
                                          width: hw.width * 0.6,
                                          child: commonWidget.semiBoldText(maxLines: 2, '${controller.imagePath.toString().split('/').last.toString().split('\'').first}', fontsize: 10.0, overflow: TextOverflow.ellipsis, tcolor: color.black),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            controller.imagePath = null;
                                            controller.update();
                                          },
                                          splashColor: color.transparent,
                                          hoverColor: color.transparent,
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: color.appColor,
                                            child: Icon(Icons.clear, color: color.white, size: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: commonWidget.customButton(
                      onTap: () async {
                        if (validation()) {
                          await controller.accountStatementUpdate_Api();
                        }
                      },
                      text: stringsUtils.next,
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
    if (controller.imagePath == null) {
      Toasty.showtoast("Please Upload Account Statement");
      return false;
    } else {
      return true;
    }
  }
}
