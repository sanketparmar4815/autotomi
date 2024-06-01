import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/login/views/login_view.dart';
import 'package:autotomi/app/modules/rentcar/views/rentcar_view.dart';
import 'package:autotomi/app/modules/support/views/support_view.dart';
import 'package:autotomi/app/routes/app_pages.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../common/asset.dart';
import '../controllers/home_controller.dart';

int isReturnCar = 0;

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return GetBuilder<HomeController>(
        assignId: true,
        init: HomeController(),
        builder: (logic) {
          return Obx(() {
            return ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              opacity: 0,
              progressIndicator: customerIndicator,
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: color.appColor,
                    title: commonWidget.semiBoldText(
                      stringsUtils.Dashboard,
                      fontsize: 29.0,
                      tcolor: Colors.white,
                    ),
                    actions: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.NOTIFICATION);
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Image.asset(
                            assetsUrl.notificationIcon,
                            scale: 3.8,
                          ),
                        ),
                      ),
                    ],
                    centerTitle: false,
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            height: Get.width * 1.40,
                            width: Get.width,
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                // mainAxisExtent: 150,
                              ),
                              itemCount: controller.dashboardList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (index == 0) {
                                      box.remove('country_name_filter');
                                      box.remove('country_id_filter');
                                      box.remove('country_visiting_code_filter');
                                      Get.to(() => RentcarView());
                                    } else if (index == 1) {
                                      if (box.read('user_id') == 0) {
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
                                                      commonWidget.semiBoldText('Whoops, you need an account to do that', fontsize: 16.0, textAlign: TextAlign.center, height: 1.5),
                                                      SizedBox(height: hw.height * 0.016),
                                                      Divider(),
                                                      SizedBox(height: hw.height * 0.016),
                                                      commonWidget.customButton(
                                                        onTap: () {
                                                          Get.offAll(() => LoginView());
                                                        },
                                                        height: 48.0,
                                                        text: "Signup or Signin",
                                                        textfontsize: 16.0,
                                                      ),
                                                      SizedBox(height: hw.height * 0.030),
                                                      InkWell(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        splashColor: color.transparent,
                                                        highlightColor: color.transparent,
                                                        child: Container(
                                                          width: hw.width,
                                                          height: 30.0,
                                                          child: Center(child: commonWidget.semiBoldText('Later', fontsize: 16.0)),
                                                        ),
                                                      ),
                                                      SizedBox(height: hw.height * 0.020),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        isReturnCar = 2;
                                        controller.update();
                                        Get.offAllNamed(Routes.BOTTOMBAR, arguments: 1);
                                      }
                                    } else if (index == 2) {
                                      box.read('user_id') == 0
                                          ? showDialog(
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
                                                          commonWidget.semiBoldText('Whoops, you need an account to do that', fontsize: 16.0, textAlign: TextAlign.center, height: 1.5),
                                                          SizedBox(height: hw.height * 0.016),
                                                          Divider(),
                                                          SizedBox(height: hw.height * 0.016),
                                                          commonWidget.customButton(
                                                            onTap: () {
                                                              Get.offAll(() => LoginView());
                                                            },
                                                            height: 48.0,
                                                            text: "Signup or Signin",
                                                            textfontsize: 16.0,
                                                          ),
                                                          SizedBox(height: hw.height * 0.030),
                                                          InkWell(
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                            splashColor: color.transparent,
                                                            highlightColor: color.transparent,
                                                            child: Container(
                                                              width: hw.width,
                                                              height: 30.0,
                                                              child: Center(child: commonWidget.semiBoldText('Later', fontsize: 16.0)),
                                                            ),
                                                          ),
                                                          SizedBox(height: hw.height * 0.020),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : Get.offAllNamed(Routes.BOTTOMBAR, arguments: 1);
                                    } else if (index == 3) {
                                      box.read('user_id') == 0
                                          ? showDialog(
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
                                                          commonWidget.semiBoldText('Whoops, you need an account to do that', fontsize: 16.0, textAlign: TextAlign.center, height: 1.5),
                                                          SizedBox(height: hw.height * 0.016),
                                                          Divider(),
                                                          SizedBox(height: hw.height * 0.016),
                                                          commonWidget.customButton(
                                                            onTap: () {
                                                              Get.offAll(() => LoginView());
                                                            },
                                                            height: 48.0,
                                                            text: "Signup or Signin",
                                                            textfontsize: 16.0,
                                                          ),
                                                          SizedBox(height: hw.height * 0.030),
                                                          InkWell(
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                            splashColor: color.transparent,
                                                            highlightColor: color.transparent,
                                                            child: Container(
                                                              width: hw.width,
                                                              height: 30.0,
                                                              child: Center(child: commonWidget.semiBoldText('Later', fontsize: 16.0)),
                                                            ),
                                                          ),
                                                          SizedBox(height: hw.height * 0.020),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : Get.to(() => SupportView());
                                      //Get.toNamed(Routes.CONTACT_US, arguments: {'flag': 1});
                                    } else {
                                      Get.toNamed(Routes.HOW_ITS_WORK);
                                    }
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffF5F5F5),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          controller.dashboardList[index]['image'],
                                          scale: 4,
                                        ),
                                        SizedBox(height: index == 2 ? 22 : 15),
                                        commonWidget.semiBoldText(
                                          controller.dashboardList[index]['name'],
                                          fontsize: 16.0,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          commonWidget.semiBoldText(
                            stringsUtils.MyProfile,
                            fontsize: 16.0,
                          ),
                          SizedBox(height: 10),
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
                                            "${controller.firstName ?? 'Welcome'} ${controller.lastName ?? ''}",
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
                                          box.read('user_id') == 0 ? '' : '+${controller.countryCode ?? ''}',
                                          fontsize: 14.0,
                                          tcolor: color.white,
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          width: Get.width * 0.3,
                                          child: commonWidget.mediumText(
                                            controller.phoneNumber ?? 'Your are in guest mode',
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
                                box.read('is_profile') == 2
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
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  )),
            );
          });
        });
  }
}
