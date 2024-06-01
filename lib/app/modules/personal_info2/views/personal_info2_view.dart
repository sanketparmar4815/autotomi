import 'package:autotomi/app/Model/roaming_city_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../common/Strings.dart';
import '../../../../common/asset.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import '../../bottombar/views/bottombar_view.dart';
import '../../home/views/home_view.dart';
import '../../personal_info3/views/personal_info3_view.dart';
import '../controllers/personal_info2_controller.dart';

class PersonalInfo2View extends GetView<PersonalInfo2Controller> {
  const PersonalInfo2View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalInfo2Controller>(
      assignId: true,
      init: PersonalInfo2Controller(),
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
                            hoverColor: color.transparent,
                            child: commonWidget.mediumText(stringsUtils.skip, fontsize: 16.0, tcolor: color.appColor),
                          ),
                    SizedBox(width: 15),
                  ],
                ),
                centerTitle: true,
              ),
              body: controller.isLoading.value == true
                  ? SizedBox()
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: hw.height * 0.04),
                                  commonWidget.customTextfield(
                                    hintText: stringsUtils.enter,
                                    controller: controller.guarantor,
                                    label: stringsUtils.guarantor,
                                  ),
                                  SizedBox(height: 16),
                                  commonWidget.customTextfield(
                                    hintText: stringsUtils.enter,
                                    controller: controller.email,
                                    label: stringsUtils.guarantor_Email,
                                  ),
                                  SizedBox(height: 16),
                                  commonWidget.customTextfield(
                                    hintText: stringsUtils.enter,
                                    controller: controller.address,
                                    label: stringsUtils.guarantor_Address,
                                  ),
                                  SizedBox(height: 16),
                                  commonWidget.regularText(stringsUtils.roaming_Cities, fontsize: 14.0),
                                  SizedBox(height: 16),
                                  ListView.builder(
                                    itemCount: controller.romingCityList.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Obx(() {
                                            return InkWell(
                                              onTap: () {
                                                if (controller.selectedIndices.contains(controller.romingCityList[index].cityId)) {
                                                  controller.selectedIndices.remove(controller.romingCityList[index].cityId);

                                                  print(controller.roamingCityID);
                                                } else {
                                                  controller.selectedIndices.add(controller.romingCityList[index].cityId);
                                                }

                                                print(controller.selectedIndices);
                                                // controller.isChecked.value = !controller.isChecked.value;
                                              },
                                              highlightColor: color.transparent,
                                              splashColor: color.transparent,
                                              child: Container(
                                                height: 35,
                                                width: hw.width,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    commonWidget.regularText(
                                                      controller.romingCityList[index].cityName!,
                                                      fontsize: 14.0,
                                                    ),
                                                    Image.asset(
                                                      controller.selectedIndices.contains(controller.romingCityList[index].cityId) ? assetsUrl.check : assetsUrl.uncheck,
                                                      height: 18,
                                                      width: 18,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                          index == 6 ? SizedBox() : Divider(),
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(height: hw.height * 0.025),
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
                                await controller.personalInfo_Api();
                              }
                            },
                            text: stringsUtils.save,
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
    if (controller.guarantor.text.isEmpty) {
      Toasty.showtoast("Please Enter Guarantor");
      return false;
    } else if (controller.email.text.isEmpty) {
      Toasty.showtoast("Please Enter Guarantor Email");
      return false;
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(controller.email.text)) {
      Toasty.showtoast('Please Enter Valid Email');
      return false;
    } else if (controller.address.text.isEmpty) {
      Toasty.showtoast("Please Select Proof of African Address");
      return false;
    } else if (controller.selectedIndices.isEmpty) {
      Toasty.showtoast("Please Select Roaming Cities");
      return false;
    } else {
      return true;
    }
  }
}
