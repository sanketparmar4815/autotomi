import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      assignId: true,
      init: EditProfileController(),
      builder: (logic) {
        bool keyBoardopen = MediaQuery.of(context).viewInsets.bottom != 0;
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
                titleText: stringsUtils.edit_Profile,
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
                            Center(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9.0))),
                                        contentPadding: EdgeInsets.only(top: 10.0),
                                        content: Container(
                                            width: 300.0,
                                            child: ListView.builder(
                                              itemCount: controller.addPhotoList.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        if (index == 0) {
                                                        } else if (index == 1) {
                                                          controller.fromCamera(argument: 1);
                                                          Get.back();
                                                        } else if (index == 2) {
                                                          controller.fromCamera(argument: 2);
                                                          Get.back();
                                                        } else {
                                                          Get.back();
                                                        }
                                                      },
                                                      splashColor: color.transparent,
                                                      highlightColor: color.transparent,
                                                      child: index == 0
                                                          ? Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                                                              child: Container(
                                                                height: 30,
                                                                width: hw.width,
                                                                // color: color.appColor,
                                                                child: commonWidget.boldText(
                                                                  controller.addPhotoList[index],
                                                                  fontsize: 16.0,
                                                                ),
                                                              ),
                                                            )
                                                          : Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                                                              child: Container(
                                                                width: hw.width,
                                                                height: 30,
                                                                // color: color.appColor,
                                                                child: commonWidget.mediumText(
                                                                  controller.addPhotoList[index],
                                                                  fontsize: 14.0,
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                    index == 3 ? SizedBox() : Divider(),
                                                  ],
                                                );
                                              },
                                            )),
                                      );
                                    },
                                  );
                                },
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      controller.profile_pic == null
                                          ? Image.asset(assetsUrl.plashHolder, height: 72, width: 72)
                                          : controller.imagePath != null
                                              ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: Container(
                                                    height: 72,
                                                    width: 72,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(image: FileImage(controller.image), fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                )
                                              : CachedImageContainer(
                                                  image: "$BaseUrl${controller.profile_pic}",
                                                  fit: BoxFit.cover,
                                                  circular: 90.0,
                                                  topCorner: 90.0,
                                                  bottomCorner: 90.0,
                                                  height: 66,
                                                  width: 66,
                                                  placeholder: assetsUrl.plashHolder,
                                                  // flag: 1,
                                                ),
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: color.appColor,
                                        child: Center(
                                          child: Icon(Icons.add, color: color.white, size: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ),
                            SizedBox(height: hw.height * 0.04),
                            commonWidget.regularText('Phone Number', fontsize: 14.0),
                            SizedBox(height: 8),
                            commonWidget.intlPhoneField(
                              hintText: "Phone No.",
                              showDropdownIcon: true,
                              controller: controller.phoneController,
                              initialCountryCode: controller.isoCode,
                              onCountryChanged: (Country) {
                                print(Country.code);
                                print(Country.dialCode);
                                print(Country.minLength);
                                print(Country.maxLength);
                                print("nemil");
                                controller.isoCode = Country.code;
                                controller.selectedCountryCode = Country.dialCode;
                                controller.update();
                              },
                            ),
                            SizedBox(height: 16),
                            commonWidget.customTextfield(
                              hintText: stringsUtils.enter,
                              controller: controller.firsName,
                              label: stringsUtils.first_Name,
                            ),
                            SizedBox(height: 16),
                            commonWidget.customTextfield(
                              hintText: stringsUtils.enter,
                              controller: controller.lastName,
                              label: stringsUtils.last_Name,
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                  keyBoardopen
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: commonWidget.customButton(
                            onTap: () {
                              controller.editProfile_Api(getData: 0);
                              // Get.back();
                            },
                            text: stringsUtils.edit,
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
}
