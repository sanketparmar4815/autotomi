import 'package:autotomi/app/modules/pickup_successful/views/pickup_successful_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import '../controllers/pin_controller.dart';

class PinView extends GetView<PinController> {
  const PinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PinController>(
      assignId: true,
      init: PinController(),
      builder: (logic) {
        return Obx(() {
          return ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            opacity: 0,
            progressIndicator: customerIndicator,
            child: Scaffold(
              backgroundColor: color.white,
              appBar: commonWidget.customAppbar(
                fontsize: 20.0,
                arroOnTap: () {
                  Get.back();
                },
                titleText: controller.flag == 2 || controller.flag == 3 ? "Return" : 'Pickup',
                actions: SizedBox(),
                centerTitle: false,
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
                            SizedBox(height: hw.height * 0.02),
                            commonWidget.customTextfield(
                              controller: controller.agentName,
                              hintText: 'Enter',
                              label: 'Autotomi Agent Name',
                            ),
                            SizedBox(height: hw.height * 0.025),
                            commonWidget.regularText(
                              'Acceptance Code',
                              tcolor: color.black,
                              fontsize: 14.0,
                            ),
                            SizedBox(height: hw.height * 0.025),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: commonWidget.customButton(
                      onTap: () {
                        if (validation()) {
                          controller.getCarKey_Api();
                        }
                      },
                      text: controller.flag == 2 || controller.flag == 3 ? 'Return' : 'Get Car Key',
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
    if (controller.agentName.text.isEmpty) {
      Toasty.showtoast("Please Enter Agent Name");
      return false;
    } else if (controller.pin.text.isEmpty) {
      Toasty.showtoast("Please Enter Code");
      return false;
    } else {
      return true;
    }
  }
}
