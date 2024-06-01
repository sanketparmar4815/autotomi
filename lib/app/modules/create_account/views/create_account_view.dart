import 'package:country_picker/country_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../controllers/create_account_controller.dart';
import 'package:autotomi/common/asset.dart';
import '../../../../common/constant.dart';
import '../../../../common/Strings.dart';
import '../../../../common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountView extends GetView<CreateAccountController> {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateAccountController>(
      assignId: true,
      init: CreateAccountController(),
      builder: (logic) {
        bool keyBoardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
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
                titleText: stringsUtils.create_Account,
                actions: SizedBox(),
                leading: SizedBox(),
                centerTitle: true,
                backgroundColor: color.white,
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
                            Center(
                              child: InkWell(
                                onTap: () async {
                                  await controller.checkPermission();
                                  await controller.isPermission.value == true
                                      ? showDialog(
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
                                                                // controller.checkPermission();
                                                                controller.fromCamera(argument: 1);
                                                                controller.update();
                                                                Get.back();
                                                              } else if (index == 2) {
                                                                controller.fromCamera(argument: 2);
                                                                Get.back();
                                                              } else {
                                                                Get.back();
                                                              }
                                                            },
                                                            splashColor: color.transparent,
                                                            hoverColor: color.transparent,
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
                                                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                                        )
                                      : SizedBox();
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      controller.image == null
                                          ? Image.asset(assetsUrl.plashHolder, height: 72, width: 72)
                                          : ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: Container(
                                                height: 72,
                                                width: 72,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(image: FileImage(controller.image), fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                      CircleAvatar(
                                        radius: 11,
                                        backgroundColor: color.appColor,
                                        child: Center(
                                          child: Icon(Icons.add, color: color.white, size: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            commonWidget.customTextfield(
                              hintText: stringsUtils.first_Name,
                              controller: controller.firstName,
                              label: stringsUtils.first_Name,
                            ),
                            SizedBox(height: 16),
                            commonWidget.customTextfield(
                              hintText: stringsUtils.last_Name,
                              controller: controller.lastName,
                              label: stringsUtils.last_Name,
                            ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Padding(
                            //       padding: EdgeInsets.only(bottom: 8.0),
                            //       child: InkWell(
                            //         onTap: () {
                            //           showCountryPicker(
                            //             showPhoneCode: true,
                            //             showSearch: true,
                            //             context: context,
                            //             onSelect: (Country country) {
                            //               controller.selectedCountryCode = country.phoneCode;
                            //               controller.countryofresidence.text = country.name;
                            //               print(controller.selectedCountryCode);
                            //               print("rutik");
                            //               controller.update();
                            //             },
                            //             countryListTheme: CountryListThemeData(
                            //               borderRadius: BorderRadius.only(
                            //                 topLeft: Radius.circular(20.0),
                            //                 topRight: Radius.circular(20.0),
                            //               ),
                            //               searchTextStyle: TextStyle(color: Colors.blue, fontSize: 18),
                            //             ),
                            //           );
                            //         },
                            //         child: Container(
                            //           alignment: Alignment.centerLeft,
                            //           width: Get.width * 0.18,
                            //           height: 50,
                            //           decoration: BoxDecoration(
                            //             color: color.fillColor,
                            //             borderRadius: BorderRadius.only(
                            //               topLeft: Radius.circular(5),
                            //               bottomLeft: Radius.circular(5),
                            //             ),
                            //           ),
                            //           child: Row(
                            //             children: [
                            //               SizedBox(width: 6),
                            //               Text(
                            //                 controller.selectedCountryCode.toString() == 'null' ? "Select" : "+${controller.selectedCountryCode.toString()}",
                            //                 overflow: TextOverflow.ellipsis,
                            //                 maxLines: 2,
                            //                 style: TextStyle(
                            //                   fontSize: 14.0,
                            //                   color: color.black,
                            //                 ),
                            //               ),
                            //               // Spacer(),
                            //               Icon(Icons.keyboard_arrow_down_sharp)
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: TextField(
                            //         controller: controller.phoneController,
                            //         keyboardType: TextInputType.phone,
                            //         maxLength: 15,
                            //         style: TextStyle(
                            //           color: color.black,
                            //           fontSize: 14.0,
                            //           fontWeight: FontWeight.w500,
                            //           fontFamily: 'Medium',
                            //         ),
                            //         decoration: InputDecoration(
                            //           hintText: "Enter",
                            //           counter: SizedBox(),
                            //           contentPadding: EdgeInsets.only(top: 17, bottom: 17, left: 10, right: 10),
                            //           hintStyle: TextStyle(
                            //             color: color.black,
                            //             fontSize: 14.0,
                            //             fontWeight: FontWeight.w500,
                            //             fontFamily: 'Medium',
                            //           ),
                            //           filled: true,
                            //           fillColor: color.fillColor,
                            //           enabledBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.only(
                            //               topRight: Radius.circular(5),
                            //               bottomRight: Radius.circular(5),
                            //             ),
                            //             borderSide: BorderSide(
                            //               width: 1,
                            //               color: color.transparent,
                            //             ),
                            //           ),
                            //           focusedBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(5),
                            //             borderSide: BorderSide(
                            //               width: 1,
                            //               color: color.appColor,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: 16),
                            commonWidget.regularText(stringsUtils.country_of_Residence, fontsize: 14.0),
                            SizedBox(height: 8),
                            InkWell(
                              onTap: () {
                                showCountryPicker(
                                  showSearch: true,
                                  context: context,
                                  onSelect: (Country country) {
                                    controller.countryofresidence.text = country.name;
                                    controller.selectedCountryCode = country.phoneCode;
                                    print(controller.selectedCountryCode);

                                    print("rutik");
                                    print('Select country: ${controller.countryofresidence.text}');
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
                                alignment: Alignment.centerLeft,
                                width: Get.width,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: color.fillColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: hw.width * 0.7,
                                        child: Text(
                                          controller.countryofresidence.text.isEmpty ? "Select" : controller.countryofresidence.text,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: color.black,
                                          ),
                                        ),
                                      ),
                                      Icon(Icons.keyboard_arrow_down_sharp)
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 16),
                            commonWidget.regularText(stringsUtils.phone_Number, fontsize: 14.0),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextField(
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
                                      prefixIcon: InkWell(
                                        onTap: () {
                                          showCountryPicker(
                                            showPhoneCode: true,
                                            showSearch: true,
                                            context: context,
                                            onSelect: (Country country) {
                                              controller.selectedCountryCode = country.phoneCode;
                                              controller.countryofresidence.text = country.name;
                                              print(controller.selectedCountryCode);
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
                                                controller.selectedCountryCode.toString() == 'null' ? "Select" : "+${controller.selectedCountryCode.toString()}",
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
                            ),
                            SizedBox(height: 8),
                            commonWidget.regularText('Former Country of Residence(your home town)', fontsize: 14.0),
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
                                  value: controller.selectedCountry,
                                  items: controller.countryList.map((item) {
                                    return DropdownMenuItem(
                                      value: item["country_id"],
                                      child: Text(item['country']),
                                    );
                                  }).toList(),
                                  onChanged: (selectedItem) {
                                    print("selectedItem=====>>${selectedItem}");

                                    controller.selectedCountry = selectedItem;

                                    for (int i = 0; i < controller.countryList.length; i++) {
                                      if (controller.countryList[i]['country_id'].toString() == controller.selectedCountry.toString()) {
                                        controller.countryCode = controller.countryList[i]['code'];
                                        box.write('country_id', controller.countryList[i]['country_id']);
                                        box.write('country_name', controller.countryList[i]['country']);
                                        print(controller.countryList[i]['name']);
                                        print(controller.countryCode);
                                        print("controller.countryCode");
                                      }
                                    }

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
                            commonWidget.regularText('Marital Status', fontsize: 14.0),
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
                                  value: controller.selectMaritalStatus,
                                  items: controller.maritalStatus.map((String item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (String? selectedItem) {
                                    controller.selectMaritalStatus = selectedItem;
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
                            commonWidget.regularText("Do You Have Kids", fontsize: 14.0),
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
                                  value: controller.selectKids,
                                  items: controller.selectKidsStatus.map((String item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (String? selectedItem) {
                                    controller.selectKids = selectedItem;
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
                            commonWidget.customTextfield(
                              hintText: "Enter",
                              controller: controller.employmentStatus,
                              label: "Employment Status",
                            ),
                            SizedBox(height: 16),
                            commonWidget.customTextfield(
                              hintText: "Enter",
                              controller: controller.profession,
                              label: "Profession",
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                  keyBoardOpen
                      ? SizedBox()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: commonWidget.customButton(
                            onTap: () async {
                              if (validation()) {
                                box.write('country_visiting_code', controller.countryCode);
                                await controller.createAccount_Api();
                              }
                            },
                            text: stringsUtils.next,
                          ),
                        ),
                  SizedBox(height: 10),
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
      Toasty.showtoast("Please Select Profile Picture");
      return false;
    } else if (controller.firstName.text.isEmpty) {
      Toasty.showtoast("Please Enter Your First Name");
      return false;
    } else if (controller.lastName.text.isEmpty) {
      Toasty.showtoast("Please Enter Your Last Name");
      return false;
    } else if (controller.phoneController.text.isEmpty) {
      Toasty.showtoast("Please Enter Your Number");
      return false;
    } else if (controller.countryofresidence.text.isEmpty) {
      Toasty.showtoast("Please Select Country of Residence");
      return false;
    } else if (controller.selectedCountry == null) {
      Toasty.showtoast("Please Select Former Country of Residence");
      return false;
    } else if (controller.selectMaritalStatus == null) {
      Toasty.showtoast("Please Marital Status");
      return false;
    } else if (controller.selectKids == null) {
      Toasty.showtoast("Please Select Do You Have Kids");
      return false;
    } else if (controller.employmentStatus.text.isEmpty) {
      Toasty.showtoast("Please Enter Employment Status");
      return false;
    } else if (controller.profession.text.isEmpty) {
      Toasty.showtoast("Please Enter Profession");
      return false;
    } else {
      return true;
    }
  }
}
