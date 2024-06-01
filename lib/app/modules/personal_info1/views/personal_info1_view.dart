import 'package:country_picker/country_picker.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/Strings.dart';
import '../../../../common/asset.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import '../../bottombar/views/bottombar_view.dart';

import '../controllers/personal_info1_controller.dart';

class PersonalInfo1View extends GetView<PersonalInfo1Controller> {
  const PersonalInfo1View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersonalInfo1Controller controller = Get.put(PersonalInfo1Controller());
    return GetBuilder<PersonalInfo1Controller>(
      assignId: true,
      init: PersonalInfo1Controller(),
      builder: (logic) {
        bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
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
                titleText: "Former Country of Residence",
                fontsize: 18.0,
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
                                  commonWidget.regularText("${controller.countryVisitingTitle ?? ''} Phone No", fontsize: 14.0),
                                  SizedBox(height: 8),

                                  TextField(
                                    controller: controller.phoneController,
                                    keyboardType: TextInputType.phone,
                                    maxLength: 15,
                                    style: TextStyle(
                                      color: color.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Medium',
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Enter",
                                      counter: SizedBox(),
                                      contentPadding: EdgeInsets.only(top: 17, bottom: 17, left: 10, right: 10),
                                      hintStyle: TextStyle(
                                        color: color.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Medium',
                                      ),
                                      filled: true,
                                      fillColor: color.fillColor,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(right: 8.0, left: 10.0, top: 15),
                                        child: Text(
                                          controller.selectedCountryCode.toString() == 'null' ? "Select" : "+${controller.selectedCountryCode.toString()}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: color.black,
                                          ),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: color.transparent,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: color.appColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  commonWidget.customTextfield(
                                    hintText: stringsUtils.enter,
                                    controller: controller.Address,
                                    label: "${controller.countryVisitingTitle ?? ''} Address",
                                  ),
                                  SizedBox(height: 16),
                                  commonWidget.customTextfield(
                                    hintText: stringsUtils.enter,
                                    controller: controller.visitingPostCode,
                                    label: "${controller.countryVisitingTitle ?? ''} PostCode / ZipCode",
                                  ),
                                  SizedBox(height: 16),
                                  commonWidget.regularText("How long have you lived in this address?", fontsize: 14.0),
                                  SizedBox(height: 8),
                                  Container(
                                    width: hw.width,
                                    decoration: BoxDecoration(color: color.fillColor, borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                                      child: DropdownButton(
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                                        value: controller.howLongLivingAddress1,
                                        items: controller.howLongLivingAddress1List.map((String item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList(),
                                        onChanged: (String? selectedItem) {
                                          controller.howLongLivingAddress1 = selectedItem;
                                          controller.previousAddress1.clear();
                                          controller.previousAddressPostCode.clear();
                                          controller.update();
                                        },
                                        hint: commonWidget.mediumText(
                                          'Select ',
                                          fontsize: 14.0,
                                          tcolor: color.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  controller.howLongLivingAddress1 == "6 Month"
                                      ? SizedBox(height: 8)
                                      : controller.howLongLivingAddress1 == "1 Year"
                                          ? SizedBox(height: 8)
                                          : controller.howLongLivingAddress1 == "2 Year"
                                              ? SizedBox(height: 8)
                                              : SizedBox(height: 0),
                                  controller.howLongLivingAddress1 == "6 Month"
                                      ? commonWidget.customTextfield(
                                          hintText: stringsUtils.enter,
                                          controller: controller.previousAddress1,
                                          label: "Previous Address",
                                        )
                                      : controller.howLongLivingAddress1 == "1 Year"
                                          ? commonWidget.customTextfield(
                                              hintText: stringsUtils.enter,
                                              controller: controller.previousAddress1,
                                              label: "Previous Address",
                                            )
                                          : controller.howLongLivingAddress1 == "2 Year"
                                              ? commonWidget.customTextfield(
                                                  hintText: stringsUtils.enter,
                                                  controller: controller.previousAddress1,
                                                  label: "Previous Address",
                                                )
                                              : SizedBox(),
                                  controller.howLongLivingAddress1 == "6 Month"
                                      ? commonWidget.customTextfield(
                                          hintText: stringsUtils.enter,
                                          controller: controller.previousAddressPostCode,
                                          label: "Previous Address PostCode / ZipCode",
                                        )
                                      : controller.howLongLivingAddress1 == "1 Year"
                                          ? commonWidget.customTextfield(
                                              hintText: stringsUtils.enter,
                                              controller: controller.previousAddressPostCode,
                                              label: "Previous Address PostCode / ZipCode",
                                            )
                                          : controller.howLongLivingAddress1 == "2 Year"
                                              ? commonWidget.customTextfield(
                                                  hintText: stringsUtils.enter,
                                                  controller: controller.previousAddressPostCode,
                                                  label: "Previous Address PostCode / ZipCode",
                                                )
                                              : SizedBox(),
                                  SizedBox(height: 16),
                                  commonWidget.regularText("${stringsUtils.eligibility} (upload your driving license)", fontsize: 14.0),
                                  SizedBox(height: 16),
                                  controller.imagePath2 == null
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
                                              controller.fromCamera(argument: 2);
                                            },
                                            splashColor: color.transparent,
                                            highlightColor: color.transparent,
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
                                                      image: DecorationImage(image: FileImage(controller.image2), fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                SizedBox(
                                                  width: hw.width * 0.6,
                                                  child: commonWidget.semiBoldText(maxLines: 2, '${controller.imagePath2.toString().split('/').last.toString().split('\'').first}', fontsize: 10.0, overflow: TextOverflow.ellipsis, tcolor: color.black),
                                                ),
                                                Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    controller.imagePath2 = null;
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
                                  // SizedBox(height: 16),
                                  //
                                  // commonWidget.regularText("Have you driving in this country before you travel?", fontsize: 14.0),
                                  // SizedBox(height: 8),
                                  // Container(
                                  //   width: hw.width,
                                  //   decoration: BoxDecoration(color: color.fillColor, borderRadius: BorderRadius.circular(5)),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                                  //     child: DropdownButton(
                                  //       isExpanded: true,
                                  //       underline: SizedBox(),
                                  //       icon: Icon(Icons.keyboard_arrow_down_rounded),
                                  //       value: controller.haveYouDriving,
                                  //       items: controller.haveYouDrivingList.map((String item) {
                                  //         return DropdownMenuItem(
                                  //           value: item,
                                  //           child: Text(item),
                                  //         );
                                  //       }).toList(),
                                  //       onChanged: (String? selectedItem) {
                                  //         controller.haveYouDriving = selectedItem;
                                  //         controller.update();
                                  //       },
                                  //       hint: commonWidget.mediumText(
                                  //         'Select ',
                                  //         fontsize: 14.0,
                                  //         tcolor: color.black,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // controller.haveYouDriving == "Yes" ? SizedBox(height: 16) : SizedBox(height: 0),
                                  // controller.haveYouDriving == "Yes" ? commonWidget.regularText("How long have you driving in this country before you relocate?", fontsize: 14.0) : SizedBox(),
                                  // controller.haveYouDriving == "Yes" ? SizedBox(height: 8) : SizedBox(height: 0),
                                  // controller.haveYouDriving == "Yes"
                                  //     ? Container(
                                  //         width: hw.width,
                                  //         decoration: BoxDecoration(color: color.fillColor, borderRadius: BorderRadius.circular(5)),
                                  //         child: Padding(
                                  //           padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                                  //           child: DropdownButton(
                                  //             isExpanded: true,
                                  //             underline: SizedBox(),
                                  //             icon: Icon(Icons.keyboard_arrow_down_rounded),
                                  //             value: controller.selectHowLongDrivingRelocate,
                                  //             items: controller.howLongDrivingRelocateList.map((String item) {
                                  //               return DropdownMenuItem(
                                  //                 value: item,
                                  //                 child: Text(item),
                                  //               );
                                  //             }).toList(),
                                  //             onChanged: (String? selectedItem) {
                                  //               controller.selectHowLongDrivingRelocate = selectedItem;
                                  //               controller.previousAddressLongRelocate.clear();
                                  //               controller.previousPostCodeLongRelocate.clear();
                                  //               controller.update();
                                  //             },
                                  //             hint: commonWidget.mediumText(
                                  //               'Select ',
                                  //               fontsize: 14.0,
                                  //               tcolor: color.black,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       )
                                  //     : SizedBox(),
                                  // controller.selectHowLongDrivingRelocate == "6 Month"
                                  //     ? SizedBox(height: 8)
                                  //     : controller.selectHowLongDrivingRelocate == "1 Year"
                                  //         ? SizedBox(height: 8)
                                  //         : controller.selectHowLongDrivingRelocate == "2 Year"
                                  //             ? SizedBox(height: 8)
                                  //             : SizedBox(height: 0),
                                  // controller.selectHowLongDrivingRelocate == "6 Month"
                                  //     ? commonWidget.customTextfield(
                                  //         hintText: stringsUtils.enter,
                                  //         controller: controller.previousAddressLongRelocate,
                                  //         label: "Previous Address",
                                  //       )
                                  //     : controller.selectHowLongDrivingRelocate == "1 Year"
                                  //         ? commonWidget.customTextfield(
                                  //             hintText: stringsUtils.enter,
                                  //             controller: controller.previousAddressLongRelocate,
                                  //             label: "Previous Address",
                                  //           )
                                  //         : controller.selectHowLongDrivingRelocate == "2 Year"
                                  //             ? commonWidget.customTextfield(
                                  //                 hintText: stringsUtils.enter,
                                  //                 controller: controller.previousAddressLongRelocate,
                                  //                 label: "Previous Address",
                                  //               )
                                  //             : SizedBox(),
                                  // controller.selectHowLongDrivingRelocate == "6 Month"
                                  //     ? commonWidget.customTextfield(
                                  //         hintText: stringsUtils.enter,
                                  //         controller: controller.previousPostCodeLongRelocate,
                                  //         label: "Previous Address PostCode",
                                  //       )
                                  //     : controller.selectHowLongDrivingRelocate == "1 Year"
                                  //         ? commonWidget.customTextfield(
                                  //             hintText: stringsUtils.enter,
                                  //             controller: controller.previousPostCodeLongRelocate,
                                  //             label: "Previous Address PostCode",
                                  //           )
                                  //         : controller.selectHowLongDrivingRelocate == "2 Year"
                                  //             ? commonWidget.customTextfield(
                                  //                 hintText: stringsUtils.enter,
                                  //                 controller: controller.previousPostCodeLongRelocate,
                                  //                 label: "Previous Address PostCode",
                                  //               )
                                  //             : SizedBox(),
                                  SizedBox(height: 16),
                                  commonWidget.regularText("When was the last time you drove in this country?", fontsize: 14.0),
                                  SizedBox(height: 8),
                                  Container(
                                    width: hw.width,
                                    decoration: BoxDecoration(color: color.fillColor, borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                                      child: DropdownButton(
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                                        value: controller.whenWasLast,
                                        items: controller.whenWasLastList.map((String item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList(),
                                        onChanged: (String? selectedItem) {
                                          controller.whenWasLast = selectedItem;
                                          controller.previousPostCodeWhenLastTime.clear();
                                          controller.previousAddressWhenLastTime.clear();
                                          controller.update();
                                        },
                                        hint: commonWidget.mediumText(
                                          'Select ',
                                          fontsize: 14.0,
                                          tcolor: color.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  controller.whenWasLast == "6 Month"
                                      ? SizedBox(height: 8)
                                      : controller.whenWasLast == "1 Year"
                                          ? SizedBox(height: 8)
                                          : controller.whenWasLast == "2 Year"
                                              ? SizedBox(height: 8)
                                              : SizedBox(height: 0),
                                  controller.whenWasLast == "6 Month"
                                      ? commonWidget.customTextfield(
                                          hintText: stringsUtils.enter,
                                          controller: controller.previousAddressWhenLastTime,
                                          label: "Previous Address",
                                        )
                                      : controller.whenWasLast == "1 Year"
                                          ? commonWidget.customTextfield(
                                              hintText: stringsUtils.enter,
                                              controller: controller.previousAddressWhenLastTime,
                                              label: "Previous Address",
                                            )
                                          : controller.whenWasLast == "2 Year"
                                              ? commonWidget.customTextfield(
                                                  hintText: stringsUtils.enter,
                                                  controller: controller.previousAddressWhenLastTime,
                                                  label: "Previous Address",
                                                )
                                              : SizedBox(),
                                  controller.whenWasLast == "6 Month"
                                      ? commonWidget.customTextfield(
                                          hintText: stringsUtils.enter,
                                          controller: controller.previousPostCodeWhenLastTime,
                                          label: "Previous Address PostCode / ZipCode",
                                        )
                                      : controller.whenWasLast == "1 Year"
                                          ? commonWidget.customTextfield(
                                              hintText: stringsUtils.enter,
                                              controller: controller.previousPostCodeWhenLastTime,
                                              label: "Previous Address PostCode / ZipCode",
                                            )
                                          : controller.whenWasLast == "2 Year"
                                              ? commonWidget.customTextfield(
                                                  hintText: stringsUtils.enter,
                                                  controller: controller.previousPostCodeWhenLastTime,
                                                  label: "Previous Address PostCode / ZipCode",
                                                )
                                              : SizedBox(),
                                  SizedBox(height: 16),
                                  commonWidget.regularText("where will you be staying during your visit", fontsize: 14.0),
                                  SizedBox(height: 8),
                                  Container(
                                    width: hw.width,
                                    decoration: BoxDecoration(color: color.fillColor, borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                                      child: DropdownButton(
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                                        value: controller.whereWillYouBeStaying,
                                        items: controller.whereWillYouBeStayingList.map((String item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList(),
                                        onChanged: (String? selectedItem) {
                                          controller.whereWillYouBeStaying = selectedItem;
                                          controller.update();
                                        },
                                        hint: commonWidget.mediumText(
                                          'Select ',
                                          fontsize: 14.0,
                                          tcolor: color.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  controller.whereWillYouBeStaying != null
                                      ? commonWidget.customTextfield(
                                          hintText: stringsUtils.enter,
                                          controller: controller.nameOwner,
                                          label: "Name of Owner / Place",
                                        )
                                      : SizedBox(),
                                  controller.whereWillYouBeStaying != null
                                      ? commonWidget.customTextfield(
                                          hintText: stringsUtils.enter,
                                          controller: controller.OwenerAddress,
                                          label: "Address",
                                        )
                                      : SizedBox(),
                                  controller.whereWillYouBeStaying != null
                                      ? commonWidget.customTextfield(
                                          hintText: stringsUtils.enter,
                                          controller: controller.OwenerPostCode,
                                          label: "PostCode / ZipCode",
                                        )
                                      : SizedBox(),
                                  controller.whereWillYouBeStaying != null ? commonWidget.regularText("Owner Phone Number", fontsize: 14.0) : SizedBox(),
                                  controller.whereWillYouBeStaying != null ? SizedBox(height: 8) : SizedBox(),
                                  controller.whereWillYouBeStaying != null
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                controller: controller.OwenerNumber,
                                                keyboardType: TextInputType.phone,
                                                maxLength: 15,
                                                style: TextStyle(
                                                  color: color.black,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Medium',
                                                ),
                                                decoration: InputDecoration(
                                                  prefixIcon: InkWell(
                                                    onTap: () {
                                                      showCountryPicker(
                                                        showPhoneCode: true,
                                                        showSearch: true,
                                                        context: context,
                                                        onSelect: (Country country) {
                                                          controller.selectedCountryCodeOwner = country.phoneCode;
                                                          print(controller.selectedCountryCodeOwner);
                                                          print("rutik");
                                                          controller.update();
                                                        },
                                                        countryListTheme: CountryListThemeData(
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(20.0),
                                                            topRight: Radius.circular(20.0),
                                                          ),
                                                          searchTextStyle: TextStyle(color: Colors.blue, fontSize: 18),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 67,
                                                      child: Row(
                                                        children: [
                                                          SizedBox(width: 6),
                                                          Text(
                                                            controller.selectedCountryCodeOwner.toString() == 'null' ? "Select" : "+${controller.selectedCountryCodeOwner.toString()}",
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              fontSize: 14.0,
                                                              color: color.black,
                                                            ),
                                                          ),
                                                          // Spacer(),
                                                          Icon(
                                                            Icons.keyboard_arrow_down_sharp,
                                                            color: Colors.black,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  hintText: "Enter",
                                                  counter: SizedBox(),
                                                  contentPadding: EdgeInsets.only(top: 17, bottom: 17, left: 10, right: 10),
                                                  hintStyle: TextStyle(
                                                    color: color.black,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Medium',
                                                  ),
                                                  filled: true,
                                                  fillColor: color.fillColor,
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: color.transparent,
                                                    ),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5),
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: color.appColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                  // SizedBox(height: 16),
                                  // commonWidget.regularText("Select the state/cities you will be roaming", fontsize: 14.0),
                                  // SizedBox(height: 11),
                                  // ListView.builder(
                                  //   itemCount: controller.romingCityList.length,
                                  //   shrinkWrap: true,
                                  //   physics: NeverScrollableScrollPhysics(),
                                  //   itemBuilder: (context, index) {
                                  //     return Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         InkWell(
                                  //           onTap: () {
                                  //             if (controller.selectedIndices.contains(controller.romingCityList[index].cityId)) {
                                  //               controller.selectedIndices.remove(controller.romingCityList[index].cityId);
                                  //             } else {
                                  //               controller.selectedIndices.add(controller.romingCityList[index].cityId);
                                  //             }
                                  //             controller.update();
                                  //           },
                                  //           highlightColor: color.transparent,
                                  //           splashColor: color.transparent,
                                  //           child: Container(
                                  //             height: 35,
                                  //             width: hw.width,
                                  //             child: Row(
                                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //               children: [
                                  //                 commonWidget.regularText(
                                  //                   controller.romingCityList[index].cityName.toString(),
                                  //                   fontsize: 14.0,
                                  //                 ),
                                  //                 Image.asset(
                                  //                   controller.selectedIndices.contains(controller.romingCityList[index].cityId) ? assetsUrl.check : assetsUrl.uncheck,
                                  //                   height: 18,
                                  //                   width: 18,
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         Divider(),
                                  //         // index == 6 ? SizedBox() : Divider(),
                                  //       ],
                                  //     );
                                  //   },
                                  // ),
                                  SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                        ),
                        keyboardIsOpen
                            ? SizedBox()
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: commonWidget.customButton(
                                  onTap: () async {
                                    if (validation()) {
                                      print("rutik");
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
    if (controller.phoneController.text.isEmpty) {
      Toasty.showtoast("Please Enter ${controller.countryVisitingTitle ?? ''} Phone Number");
      return false;
    } else if (controller.Address.text.isEmpty) {
      Toasty.showtoast("Please Enter Your ${controller.countryVisitingTitle ?? ''} Address");
      return false;
    } else if (controller.visitingPostCode.text.isEmpty) {
      Toasty.showtoast("Please Enter Your ${controller.countryVisitingTitle ?? ''} PostCode/ZipCode");
      return false;
    } else if (controller.howLongLivingAddress1 == null) {
      Toasty.showtoast("Please Select Living Address");
      return false;
    } else if ((controller.howLongLivingAddress1 == '6 Month' || controller.howLongLivingAddress1 == '1 Year' || controller.howLongLivingAddress1 == '2 Year') && controller.previousAddress1.text.isEmpty) {
      Toasty.showtoast("Please Enter Previous Address");
      return false;
    } else if ((controller.howLongLivingAddress1 == '6 Month' || controller.howLongLivingAddress1 == '1 Year' || controller.howLongLivingAddress1 == '2 Year') && controller.previousAddressPostCode.text.isEmpty) {
      Toasty.showtoast("Please Enter Previous Address PostCode");
      return false;
    } else if (controller.imagePath2 == null) {
      Toasty.showtoast("Please Upload Driving License");
      return false;
    } /*else if (controller.haveYouLive == null) {
      Toasty.showtoast("Please Select Have You Live this Country");
      return false;
    }*/
    else if (controller.haveYouDriving == "Yes" && controller.selectHowLongDrivingRelocate == null) {
      Toasty.showtoast("Please Select How long have you driving in this country before you relocate");
      return false;
    } else if ((controller.selectHowLongDrivingRelocate == '6 Month' || controller.selectHowLongDrivingRelocate == '1 Year' || controller.selectHowLongDrivingRelocate == '2 Year') && controller.previousAddressLongRelocate.text.isEmpty) {
      Toasty.showtoast("Please Enter Previous Address");
      return false;
    } else if ((controller.selectHowLongDrivingRelocate == '6 Month' || controller.selectHowLongDrivingRelocate == '1 Year' || controller.selectHowLongDrivingRelocate == '2 Year') && controller.previousPostCodeLongRelocate.text.isEmpty) {
      Toasty.showtoast("Please Enter Previous Address PostCode");
      return false;
    } else if (controller.whenWasLast == null) {
      Toasty.showtoast("Please Select When Was Last time Visited this Country");
      return false;
    } else if ((controller.whenWasLast == '6 Month' || controller.whenWasLast == '1 Year' || controller.whenWasLast == '2 Year') && controller.previousAddressWhenLastTime.text.isEmpty) {
      Toasty.showtoast("Please Enter Previous Address");
      return false;
    } else if ((controller.whenWasLast == '6 Month' || controller.whenWasLast == '1 Year' || controller.whenWasLast == '2 Year') && controller.previousPostCodeWhenLastTime.text.isEmpty) {
      Toasty.showtoast("Please Enter Previous Address PostCode");
      return false;
    } else if (controller.whereWillYouBeStaying == null) {
      Toasty.showtoast("Please Select Where Will You be staying during visit");
      return false;
    } else if (controller.whereWillYouBeStaying != null && controller.nameOwner.text.isEmpty) {
      Toasty.showtoast("Please Enter Name of Owner");
      return false;
    } else if (controller.whereWillYouBeStaying != null && controller.OwenerAddress.text.isEmpty) {
      Toasty.showtoast("Please Enter Owner Address");
      return false;
    } else if (controller.whereWillYouBeStaying != null && controller.OwenerPostCode.text.isEmpty) {
      Toasty.showtoast("Please Enter Owner Address PostCode");
      return false;
    } else if (controller.whereWillYouBeStaying != null && controller.OwenerNumber.text.isEmpty) {
      Toasty.showtoast("Please Enter Owner Phone Number");
      return false;
    } else {
      return true;
    }
  }
}
