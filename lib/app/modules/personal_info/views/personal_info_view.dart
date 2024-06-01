import '../../personal_info1/views/personal_info1_view.dart';
import '../controllers/personal_info_controller.dart';
import 'package:figma_squircle/figma_squircle.dart';
import '../../bottombar/views/bottombar_view.dart';
import 'package:autotomi/common/asset.dart';
import '../../../../common/constant.dart';
import '../../../../common/Strings.dart';
import '../../../../common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfoView extends GetView<PersonalInfoController> {
  const PersonalInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersonalInfoController controller = Get.put(PersonalInfoController());
    return GetBuilder<PersonalInfoController>(
      assignId: true,
      init: PersonalInfoController(),
      builder: (logic) {
        bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
        return Scaffold(
          backgroundColor: color.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            leading: controller.flag == 1
                ? SizedBox()
                : InkWell(
                    onTap: () {
                      Get.back();
                    },
                    splashColor: color.transparent,
                    highlightColor: color.transparent,
                    child: Image.asset(
                      assetsUrl.ArrowbackIcon,
                      scale: 3.5,
                    ),
                  ),
            title: commonWidget.semiBoldText(
              "Country Of Residence Info",
              fontsize: 18.0,
            ),
            actions: [
              Row(
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
            ],
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
                        SizedBox(height: 16),
                        commonWidget.customTextfield(
                          hintText: stringsUtils.enter,
                          controller: controller.ukAddress,
                          label: "Address",
                        ),
                        SizedBox(height: 16),
                        commonWidget.customTextfield(
                          hintText: stringsUtils.enter,
                          controller: controller.flatNo,
                          label: "Flat Number",
                        ),
                        SizedBox(height: 16),
                        commonWidget.customTextfield(
                          hintText: stringsUtils.enter,
                          controller: controller.postCode,
                          label: "PostCode / ZipCode",
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: Get.width,
                          child: commonWidget.regularText(
                            "Proof Of ID (residence permit,international passport)",
                            fontsize: 14.0,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(height: 10),
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
                                    controller.fromCamera(argument: 1);
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
                                  padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                                        child: commonWidget.semiBoldText(
                                          maxLines: 2,
                                          '${controller.imagePath.toString().split('/').last.toString().split('\'').first}',
                                          fontsize: 10.0,
                                          overflow: TextOverflow.ellipsis,
                                          tcolor: color.black,
                                        ),
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
                        SizedBox(height: 16),
                        Container(
                          width: Get.width,
                          child: commonWidget.regularText(
                            "Proof Of Residence (upload your BRP, international passport or ILR )",
                            fontsize: 14.0,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(height: 10),
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
                                  padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                                        child: commonWidget.semiBoldText(
                                          maxLines: 2,
                                          '${controller.imagePath2.toString().split('/').last.toString().split('\'').first}',
                                          fontsize: 10.0,
                                          overflow: TextOverflow.ellipsis,
                                          tcolor: color.black,
                                        ),
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
                        SizedBox(height: 16),
                        commonWidget.regularText("How long have you lived in this address?", fontsize: 14.0),
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
                              value: controller.howLongHaveLiving,
                              items: controller.howLongHaveLivingList.map((String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (String? selectedItem) {
                                controller.howLongHaveLiving = selectedItem;
                                controller.previousAddress.clear();
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
                        SizedBox(height: 16),
                        controller.howLongHaveLiving == "6 Month"
                            ? commonWidget.customTextfield(
                                hintText: stringsUtils.enter,
                                controller: controller.previousAddress,
                                label: "Previous Address",
                              )
                            : controller.howLongHaveLiving == "1 Year"
                                ? commonWidget.customTextfield(
                                    hintText: stringsUtils.enter,
                                    controller: controller.previousAddress,
                                    label: "Previous Address",
                                  )
                                : controller.howLongHaveLiving == "2 Year"
                                    ? commonWidget.customTextfield(
                                        hintText: stringsUtils.enter,
                                        controller: controller.previousAddress,
                                        label: "Previous Address",
                                      )
                                    : SizedBox(),
                        controller.howLongHaveLiving == "6 Month"
                            ? commonWidget.customTextfield(
                                hintText: stringsUtils.enter,
                                controller: controller.previousAddressPostCode,
                                label: "Previous Address PostCode / ZipCode",
                              )
                            : controller.howLongHaveLiving == "1 Year"
                                ? commonWidget.customTextfield(
                                    hintText: stringsUtils.enter,
                                    controller: controller.previousAddressPostCode,
                                    label: "Previous Address PostCode / ZipCode",
                                  )
                                : controller.howLongHaveLiving == "2 Year"
                                    ? commonWidget.customTextfield(
                                        hintText: stringsUtils.enter,
                                        controller: controller.previousAddressPostCode,
                                        label: "Previous Address PostCode / ZipCode",
                                      )
                                    : SizedBox(),
                        SizedBox(height: 10),
                        commonWidget.customTextfield(
                          hintText: stringsUtils.enter,
                          controller: controller.guarantor,
                          label: stringsUtils.guarantor,
                        ),
                        SizedBox(height: 16),
                        commonWidget.customTextfield(
                          hintText: stringsUtils.enter,
                          controller: controller.emailGuarantor,
                          label: stringsUtils.guarantor_Email,
                        ),
                        SizedBox(height: 16),
                        commonWidget.customTextfield(
                          hintText: stringsUtils.enter,
                          controller: controller.guarantorAddress,
                          label: stringsUtils.guarantor_Address,
                        ),
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
                            await Get.to(() => PersonalInfo1View(), arguments: {
                              'flag': controller.flag,
                              'ukAddress': controller.ukAddress.text,
                              'flat_no': controller.flatNo.text,
                              'post_code': controller.postCode.text,
                              'proofIDImage': controller.imagePath.toString(),
                              'proofOfResideceImage': controller.imagePath2.toString(),
                              'how_long_living': controller.howLongHaveLiving.toString(),
                              'previous_address': controller.previousAddress.text.isEmpty ? "" : controller.previousAddress.text,
                              'previous_address_postcode': controller.previousAddressPostCode.text.isEmpty ? "" : controller.previousAddressPostCode.text,
                              'guarantor': controller.guarantor.text,
                              'guarantor_email': controller.emailGuarantor.text,
                              'guarantor_address': controller.guarantorAddress.text,
                            });
                          }
                        },
                        text: stringsUtils.next,
                      ),
                    ),
              SizedBox(height: hw.height * 0.025),
            ],
          ),
        );
      },
    );
  }

  bool validation() {
    if (controller.ukAddress.text.isEmpty) {
      Toasty.showtoast("Please Enter Your Address");
      return false;
    } else if (controller.flatNo.text.isEmpty) {
      Toasty.showtoast("Please Enter Flat Number");
      return false;
    } else if (controller.postCode.text.isEmpty) {
      Toasty.showtoast("Please Enter PostCode / ZipCode");
      return false;
    } else if (controller.imagePath == null) {
      Toasty.showtoast("Please Upload Proof Of ID");
      return false;
    } else if (controller.imagePath2 == null) {
      Toasty.showtoast("Please Upload Residence Of Proof");
      return false;
    } else if (controller.howLongHaveLiving == null) {
      Toasty.showtoast("Please Select Living Address");
      return false;
    } else if ((controller.howLongHaveLiving == '6 Month' || controller.howLongHaveLiving == '1 Year' || controller.howLongHaveLiving == '2 Year') && controller.previousAddress.text.isEmpty) {
      Toasty.showtoast("Please Enter Previous Address");
      return false;
    } else if ((controller.howLongHaveLiving == '6 Month' || controller.howLongHaveLiving == '1 Year' || controller.howLongHaveLiving == '2 Year') && controller.previousAddressPostCode.text.isEmpty) {
      Toasty.showtoast("Please Enter Previous Address PostCode");
      return false;
    } else if (controller.guarantor.text.isEmpty) {
      Toasty.showtoast("Please Enter Guarantor");
      return false;
    } else if (controller.emailGuarantor.text.isEmpty) {
      Toasty.showtoast("Please Enter Guarantor Email");
      return false;
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(controller.emailGuarantor.text)) {
      Toasty.showtoast('Please Enter Valid Email');
      return false;
    } else if (controller.guarantorAddress.text.isEmpty) {
      Toasty.showtoast("Please Enter Guarantor Address");
      return false;
    } else {
      return true;
    }
  }

// controller.imagePath3 == null
// ? Container(
// height: 40,
// width: hw.width,
// decoration: ShapeDecoration(
// color: color.appColor.withOpacity(0.1),
// shape: SmoothRectangleBorder(
// borderRadius: SmoothBorderRadius(
// cornerRadius: 8,
// cornerSmoothing: 1,
// ),
// ),
// ),
// child: InkWell(
// onTap: () {
// controller.fromCamera(argument: 3);
// },
// splashColor: color.transparent,
// hoverColor: color.transparent,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Image.asset(
// assetsUrl.camera,
// scale: 3.5,
// ),
// SizedBox(width: 7),
// commonWidget.semiBoldText(stringsUtils.upload, fontsize: 16.0, tcolor: color.appColor),
// ],
// ),
// ),
// )
//     : Container(
// height: 48,
// width: hw.width,
// decoration: ShapeDecoration(
// color: color.fillColor,
// shape: SmoothRectangleBorder(
// borderRadius: SmoothBorderRadius(
// cornerRadius: 8,
// cornerSmoothing: 1,
// ),
// ),
// ),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 12.0),
// child: Row(
// children: [
// ClipRRect(
// borderRadius: BorderRadius.circular(4),
// child: Container(
// height: 26,
// width: 26,
// decoration: BoxDecoration(
// image: DecorationImage(image: FileImage(controller.image3), fit: BoxFit.cover),
// ),
// ),
// ),
// SizedBox(width: 10),
// SizedBox(
// width: hw.width * 0.6,
// child: commonWidget.semiBoldText(
// maxLines: 2,
// '${controller.imagePath3.toString().split('/').last.toString().split('\'').first}',
// fontsize: 10.0,
// overflow: TextOverflow.ellipsis,
// tcolor: color.black,
// ),
// ),
// Spacer(),
// InkWell(
// onTap: () {
// controller.imagePath3 = null;
// controller.update();
// },
// splashColor: color.transparent,
// hoverColor: color.transparent,
// child: CircleAvatar(
// radius: 10,
// backgroundColor: color.appColor,
// child: Icon(Icons.clear, color: color.white, size: 12),
// ),
// ),
// ],
// ),
// ),
// ),
}
