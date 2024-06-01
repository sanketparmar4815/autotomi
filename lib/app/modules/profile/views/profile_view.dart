import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/change_password/views/change_password_view.dart';

import 'package:autotomi/app/modules/edit_profile/views/edit_profile_view.dart';

import 'package:autotomi/app/modules/personal_info/views/personal_info_view.dart';

import 'package:autotomi/app/modules/send_support/views/send_support_view.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:autotomi/common/PrefsKey.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../completed_ride/views/completed_ride_view.dart';
import '../controllers/profile_controller.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());
    return GetBuilder<ProfileController>(
      assignId: true,
      init: ProfileController(),
      builder: (logic) {
        return Obx(() {
          return ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            opacity: 0,
            progressIndicator: customerIndicator,
            child: Scaffold(
              appBar: commonWidget.customAppbar(
                leading: SizedBox(),
                titleText: stringsUtils.profile,
                actions: SizedBox(),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: hw.height * 0.02),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(19),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Color(0xff3EB765),
                              Color(0xff7CD298),
                            ],
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CachedImageContainer(
                              image: "$BaseUrl${controller.profilePic}",
                              fit: BoxFit.cover,
                              circular: 90.0,
                              topCorner: 90.0,
                              bottomCorner: 90.0,
                              height: 66,
                              width: 66,
                              placeholder: assetsUrl.plashHolder,
                              // flag: 1,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: Get.width * 0.4,
                                      child: commonWidget.mediumText(
                                        '${controller.firstName ?? ' '} ${controller.lastName ?? ''}',
                                        fontsize: 20.0,
                                        tcolor: color.white,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3),
                                Row(
                                  children: [
                                    commonWidget.mediumText(
                                      '+${controller.countryCode ?? ''}',
                                      fontsize: 14.0,
                                      tcolor: color.white,
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      width: Get.width * 0.3,
                                      child: commonWidget.mediumText(
                                        controller.phoneNumber ?? '',
                                        fontsize: 14.0,
                                        tcolor: color.white,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            box.read('is_profile') == 3
                                ? Image.asset(
                                    assetsUrl.whittickIcon,
                                    scale: 4.5,
                                  )
                                : CircularPercentIndicator(
                                    radius: 30,
                                    lineWidth: 4,
                                    percent: box.read('is_profile') == 1 ? 0.5 : 1.0,
                                    progressColor: Colors.white,
                                    backgroundColor: Colors.white.withOpacity(.25),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    center: commonWidget.semiBoldText(
                                      box.read('is_profile') == 1 ? "50%" : " 100%",
                                      fontsize: 18.0,
                                      tcolor: Colors.white,
                                    ),
                                  )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                          child: commonWidget.mediumText(
                              box.read('is_profile') == 1
                                  ? stringsUtils.basic_Member
                                  : box.read('is_profile') == 2
                                      ? "Standard Member"
                                      : "Classic Member",
                              fontsize: 14.0,
                              tcolor: color.appColor)),
                      SizedBox(height: hw.height * 0.02),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: color.grey.withOpacity(0.4)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: box.read(PrefsKey.login_type) == 1 || box.read(PrefsKey.login_type) == 2 ? controller.basicMemberList1.length : controller.basicMemberList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          box.read(PrefsKey.login_type) == 1 || box.read(PrefsKey.login_type) == 2
                                              ? index == 0
                                                  ? box.read('is_profile') == 1
                                                      ? Get.to(() => PersonalInfoView(), arguments: {'flag': 2})
                                                      : SizedBox()
                                                  : index == 1
                                                      ? Get.to(() => EditProfileView())!.then((value) {
                                                          print("value======$value");
                                                          if (value != null) {
                                                            controller.profilePic = value['profile_pic'];
                                                            controller.firstName = value['first_name'];
                                                            controller.lastName = value['last_name'];

                                                            controller.countryCode = value['country_code'];
                                                            controller.phoneNumber = value['phone_number'];
                                                            controller.update();
                                                          }
                                                        })
                                                      : index == 2
                                                          ? Get.to(() => CompletedRideView())
                                                          : index == 3
                                                              ? Get.to(() => SendSupportView(), arguments: {'flag': 1})
                                                              : index == 4 || index == 5
                                                                  ? urlLaunch()
                                                                  : showDialog(
                                                                      context: context,
                                                                      builder: (BuildContext context) {
                                                                        return AlertDialog(
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.all(
                                                                              Radius.circular(9.0),
                                                                            ),
                                                                          ),
                                                                          contentPadding: EdgeInsets.only(top: 10.0),
                                                                          content: Container(
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(9),
                                                                            ),
                                                                            child: Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  SizedBox(height: hw.height * 0.016),
                                                                                  Image.asset(assetsUrl.delete, height: 85, width: 85),
                                                                                  SizedBox(height: hw.height * 0.016),
                                                                                  commonWidget.semiBoldText('Are you sure want to Delete\nthis account?', fontsize: 16.0, textAlign: TextAlign.center, height: 1.5),
                                                                                  SizedBox(height: hw.height * 0.016),
                                                                                  commonWidget.customButton(
                                                                                    onTap: () {
                                                                                      Get.back();
                                                                                      controller.deleteAccount_Api();
                                                                                    },
                                                                                    height: 48.0,
                                                                                    text: stringsUtils.yes,
                                                                                    textfontsize: 16.0,
                                                                                  ),
                                                                                  SizedBox(height: hw.height * 0.016),
                                                                                  Divider(),
                                                                                  SizedBox(height: hw.height * 0.016),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      Get.back();
                                                                                    },
                                                                                    splashColor: color.transparent,
                                                                                    highlightColor: color.transparent,
                                                                                    child: Container(
                                                                                      width: hw.width,
                                                                                      height: 30.0,
                                                                                      child: Center(child: commonWidget.semiBoldText('Cancel', fontsize: 16.0)),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(height: 15),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    )
                                              : index == 0
                                                  ? box.read('is_profile') == 1
                                                      ? Get.to(() => PersonalInfoView(), arguments: {'flag': 2})
                                                      : SizedBox()
                                                  : index == 1
                                                      ? Get.to(() => EditProfileView())!.then((value) {
                                                          print("value======$value");
                                                          if (value != null) {
                                                            controller.profilePic = value['profile_pic'];
                                                            controller.firstName = value['first_name'];
                                                            controller.lastName = value['last_name'];
                                                            controller.countryCode = value['country_code'];
                                                            controller.phoneNumber = value['phone_number'];
                                                            controller.update();
                                                          }
                                                        })
                                                      : index == 2
                                                          ? Get.to(() => CompletedRideView())
                                                          : index == 3
                                                              ? Get.to(() => ChangePasswordView())
                                                              : index == 4
                                                                  ? Get.to(() => SendSupportView(), arguments: {'flag': 1})
                                                                  : index == 5 || index == 6
                                                                      ? urlLaunch()
                                                                      : index == 7
                                                                          ? showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return AlertDialog(
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.all(
                                                                                      Radius.circular(9.0),
                                                                                    ),
                                                                                  ),
                                                                                  contentPadding: EdgeInsets.only(top: 10.0),
                                                                                  content: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(9),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          SizedBox(height: hw.height * 0.016),
                                                                                          Image.asset(assetsUrl.delete, height: 85, width: 85),
                                                                                          SizedBox(height: hw.height * 0.016),
                                                                                          commonWidget.semiBoldText('Are you sure want to Delete\nthis account?', fontsize: 16.0, textAlign: TextAlign.center, height: 1.5),
                                                                                          SizedBox(height: hw.height * 0.016),
                                                                                          commonWidget.customButton(
                                                                                            onTap: () {
                                                                                              Get.back();
                                                                                              controller.deleteAccount_Api();
                                                                                            },
                                                                                            height: 48.0,
                                                                                            text: stringsUtils.yes,
                                                                                            textfontsize: 16.0,
                                                                                          ),
                                                                                          SizedBox(height: hw.height * 0.016),
                                                                                          Divider(),
                                                                                          SizedBox(height: hw.height * 0.016),
                                                                                          InkWell(
                                                                                            onTap: () {
                                                                                              Get.back();
                                                                                            },
                                                                                            splashColor: color.transparent,
                                                                                            highlightColor: color.transparent,
                                                                                            child: Container(
                                                                                              width: hw.width,
                                                                                              height: 30.0,
                                                                                              child: Center(child: commonWidget.semiBoldText('Cancel', fontsize: 16.0)),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(height: 15),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            )
                                                                          : '';
                                        },
                                        splashColor: color.transparent,
                                        highlightColor: color.transparent,
                                        child: Container(
                                          width: hw.width,
                                          height: 30,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              box.read('is_profile') == 2 && index == 0
                                                  ? commonWidget.regularText(
                                                      "Upgraded Profile",
                                                      fontsize: 14.0,
                                                    )
                                                  : commonWidget.regularText(
                                                      box.read(PrefsKey.login_type) == 1 || box.read(PrefsKey.login_type) == 2 ? controller.basicMemberList1[index] : controller.basicMemberList[index],
                                                      fontsize: 14.0,
                                                    ),
                                              Image.asset(
                                                box.read('is_profile') == 2 && index == 0 ? assetsUrl.greentickIcon : assetsUrl.arrowRightIcon,
                                                scale: 3.5,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey.withOpacity(.3),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(height: 5),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9.0))),
                                        contentPadding: EdgeInsets.only(top: 10.0),
                                        content: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(9),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(height: hw.height * 0.016),
                                                Image.asset(assetsUrl.signout, height: 85, width: 85),
                                                SizedBox(height: hw.height * 0.016),
                                                commonWidget.semiBoldText('Are you sure want to Sign Out\nthis account?', fontsize: 16.0, textAlign: TextAlign.center, height: 1.5),
                                                SizedBox(height: hw.height * 0.016),
                                                commonWidget.customButton(
                                                  onTap: () {
                                                    Get.back();
                                                    controller.logOut_Api();
                                                    // Get.offAll(() => LoginView());
                                                  },
                                                  height: 48.0,
                                                  text: stringsUtils.yes,
                                                  textfontsize: 16.0,
                                                ),
                                                SizedBox(height: hw.height * 0.016),
                                                Divider(),
                                                SizedBox(height: hw.height * 0.016),
                                                InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  splashColor: color.transparent,
                                                  highlightColor: color.transparent,
                                                  child: Container(
                                                    width: hw.width,
                                                    height: 30.0,
                                                    child: Center(child: commonWidget.semiBoldText('Cancel', fontsize: 16.0)),
                                                  ),
                                                ),
                                                SizedBox(height: 15)
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                splashColor: color.transparent,
                                highlightColor: color.transparent,
                                child: Row(
                                  children: [commonWidget.regularText('Sign Out', fontsize: 15.0, tcolor: Color(0xffFF0F0F)), SizedBox(width: 6), Image.asset(assetsUrl.sign_Out, height: 16, width: 16)],
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
            ),
          );
        });
      },
    );
  }

  urlLaunch() async {
    var nativeUrl = "https://www.google.com/search?q=www.google.com&rlz=1C5CHFA_enIN972IN972&oq=www.google.com&gs_lcrp=EgZjaHJvbWUyBggAEEUYPDIGCAEQRRg5MgcIAhAAGIAEMgoIAxAAGLEDGIAEMgoIBBAAGLEDGIAEMgQIBRAFMgYIBhAFGCwyBggHEEUYPNIBCTEyMDU1ajFqN6gCALACAA&sourceid=chrome&ie=UTF-8";
    var webUrl = "https://www.google.com/search?q=www.google.com&rlz=1C5CHFA_enIN972IN972&oq=www.google.com&gs_lcrp=EgZjaHJvbWUyBggAEEUYPDIGCAEQRRg5MgcIAhAAGIAEMgoIAxAAGLEDGIAEMgoIBBAAGLEDGIAEMgQIBRAFMgYIBhAFGCwyBggHEEUYPNIBCTEyMDU1ajFqN6gCALACAA&sourceid=chrome&ie=UTF-8";
    if (await canLaunchUrl(Uri.parse(nativeUrl))) {
      await launchUrl(Uri.parse(nativeUrl), mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    }
  }
}
