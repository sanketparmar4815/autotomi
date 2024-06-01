import 'package:autotomi/app/modules/bottombar/views/bottombar_view.dart';
import 'package:autotomi/app/modules/chat_support/views/chat_support_view.dart';
import 'package:autotomi/app/modules/home/views/home_view.dart';
import 'package:autotomi/app/modules/send_support/views/send_support_view.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controllers/support_controller.dart';

class SupportView extends GetView<SupportController> {
  const SupportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SupportController controller = Get.put(SupportController());
    return GetBuilder<SupportController>(
        init: SupportController(),
        builder: (logic) {
          return Obx(() {
            return ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              opacity: 0,
              progressIndicator: customerIndicator,
              child: WillPopScope(
                onWillPop: () {
                  return controller.onWillPopScope();
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: commonWidget.customAppbar(
                    arroOnTap: () {
                      if (controller.flag == 4) {
                        print("enter flag 1");
                        Get.back();
                      } else {
                        print("enter flag 2");
                        Get.back();
                      }
                    },
                    actions: Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => SendSupportView())!.then((value) {
                            if (value != null) {
                              controller.inProgressCompleted_Api();
                            }
                          });
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: color.appColor,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    titleText: stringsUtils.Support,
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 12),
                        TabBar(
                          indicatorPadding: EdgeInsets.zero,
                          indicatorSize: TabBarIndicatorSize.tab,
                          // unselectedLabelStyle: TextStyle(fontSize: 16.0, fontFamily: "DMSansMedium"),
                          physics: BouncingScrollPhysics(),
                          controller: controller.tabController,
                          labelStyle: TextStyle(
                            fontSize: 16,
                            color: color.appColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'SemiBold',
                          ),
                          unselectedLabelColor: color.black.withOpacity(0.4),
                          indicatorColor: color.appColor,

                          labelColor: color.black,

                          // controller: controller.tabController,
                          // indicatorColor: color.appColor,
                          // labelColor: color.black,
                          // labelStyle: TextStyle(
                          //   fontSize: 16,
                          //   color: color.black,
                          //   fontWeight: FontWeight.w600,
                          //   fontFamily: 'SemiBold',
                          // ),
                          // unselectedLabelColor: color.black.withOpacity(0.4),
                          tabs: [
                            Tab(text: 'InProgress'),
                            Tab(text: 'Completed'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: controller.tabController,
                            physics: BouncingScrollPhysics(),
                            children: [
                              inProgress(),
                              Completed(),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  inProgress() {
    return SingleChildScrollView(
      controller: controller.scroll_controller,
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          controller.supportList.length == 0 && controller.isLoading.value == false
              ? Column(
                  children: [
                    SizedBox(height: Get.height * 0.25),
                    commonWidget.semiBoldText(
                      "No Data Found",
                      fontsize: 16.0,
                      tcolor: color.black,
                    ),
                  ],
                )
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.supportList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => ChatSupportView(), arguments: {'ticket_id': controller.supportList[index].ticketId, 'flag': 0});
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 11, top: 10),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          color: color.fillColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                commonWidget.semiBoldText(
                                  "Ticket Id :- ${controller.supportList[index].ticketId}",
                                  fontsize: 16.0,
                                  tcolor: color.black,
                                ),
                                commonWidget.semiBoldText(
                                  "InProgress",
                                  fontsize: 16.0,
                                  tcolor: color.red_color,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            commonWidget.semiBoldText(
                              "Subject",
                              fontsize: 16.0,
                              tcolor: color.black,
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: Get.width / 1.1,
                              child: commonWidget.mediumText(
                                "${controller.supportList[index].subject}",
                                fontsize: 14.0,
                                tcolor: color.black,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 10),
                            commonWidget.semiBoldText(
                              "Message",
                              fontsize: 16.0,
                              tcolor: color.black,
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: Get.width / 1.1,
                              child: commonWidget.mediumText(
                                "${controller.supportList[index].message}",
                                fontsize: 14.0,
                                tcolor: color.black,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
          Obx(() {
            return controller.isLoadMoreRunning.value == true ? Center(child: customerIndicator) : Container();
          }),
        ],
      ),
    );
  }

  Completed() {
    return SingleChildScrollView(
      controller: controller.scroll_controller,
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          controller.supportList.length == 0 && controller.isLoading.value == false
              ? Column(
                  children: [
                    SizedBox(height: Get.height * 0.25),
                    commonWidget.semiBoldText(
                      "No Data Found",
                      fontsize: 16.0,
                      tcolor: color.black,
                    ),
                  ],
                )
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.supportList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => ChatSupportView(), arguments: {'ticket_id': controller.supportList[index].ticketId, 'flag': 1});
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 11, top: 10),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          color: color.fillColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                commonWidget.semiBoldText(
                                  "Ticket Id :- ${controller.supportList[index].ticketId}",
                                  fontsize: 16.0,
                                  tcolor: color.black,
                                ),
                                commonWidget.semiBoldText(
                                  "Completed",
                                  fontsize: 16.0,
                                  tcolor: color.appColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            commonWidget.semiBoldText(
                              "Subject",
                              fontsize: 16.0,
                              tcolor: color.black,
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: Get.width / 1.1,
                              child: commonWidget.mediumText(
                                "${controller.supportList[index].subject}",
                                fontsize: 14.0,
                                tcolor: color.black,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 10),
                            commonWidget.semiBoldText(
                              "Message",
                              fontsize: 16.0,
                              tcolor: color.black,
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: Get.width / 1.1,
                              child: commonWidget.mediumText(
                                "${controller.supportList[index].message}",
                                fontsize: 14.0,
                                tcolor: color.black,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
          Obx(() {
            return controller.isLoadMoreRunning.value == true ? Center(child: customerIndicator) : Container();
          }),
        ],
      ),
    );
  }
}
