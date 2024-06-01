import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../controllers/notification_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (logic) {
          return Obx(() {
            return ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              opacity: 0,
              progressIndicator: customerIndicator,
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: commonWidget.customAppbar(
                    arroOnTap: () {
                      Get.back();
                    },
                    actions: SizedBox(),
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    titleText: stringsUtils.Notifications,
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        // ListView.builder(
                        //   physics: NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   itemCount: controller.firstList.length,
                        //   itemBuilder: (context, index) {
                        //     return Container(
                        //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 11),
                        //       margin: EdgeInsets.only(bottom: 10),
                        //       decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(13),
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey.withOpacity(0.3),
                        //             blurRadius: 1.0,
                        //             spreadRadius: 0.5,
                        //             offset: Offset(01, 0),
                        //           ),
                        //         ],
                        //       ),
                        //       child: Row(
                        //         children: [
                        //           ClipRRect(
                        //             borderRadius: BorderRadius.circular(4),
                        //             child: Image.asset(
                        //               controller.firstList[index]['image'],
                        //               height: 40,
                        //               width: 40,
                        //               fit: BoxFit.cover,
                        //             ),
                        //           ),
                        //           SizedBox(width: 8),
                        //           Container(
                        //             width: Get.width * 0.6,
                        //             child: commonWidget.mediumText(
                        //               controller.firstList[index]['text'],
                        //               fontsize: 14.0,
                        //               overflow: TextOverflow.ellipsis,
                        //               maxLines: 2,
                        //             ),
                        //           ),
                        //           SizedBox(width: 8),
                        //           commonWidget.mediumText(
                        //             "2 min",
                        //             fontsize: 14.0,
                        //           )
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // ),

                        controller.notificationList.length == 0 && controller.isLoading.value == false
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 200),
                                  Center(
                                    child: commonWidget.semiBoldText(
                                      "No Data Found",
                                      fontsize: 20.0,
                                    ),
                                  ),
                                ],
                              )
                            : Expanded(
                                child: GroupedListView<dynamic, String>(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  reverse: false,
                                  elements: controller.notificationList,
                                  groupBy: (element) => controller.formatDate(DateTime.parse(element.createdAt.toString())),
                                  groupComparator: (value1, value2) => value2.compareTo(value1),
                                  groupSeparatorBuilder: (String groupByValue) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5),
                                      commonWidget.mediumText(
                                        DateFormat("dd/MM/yyyy").format(DateTime.parse(groupByValue)) == controller.formattedDate
                                            ? "Today"
                                            : DateFormat("dd/MM/yyyy").format(DateTime.parse(groupByValue)) == controller.formattedDateYest
                                                ? "Yesterday"
                                                : DateFormat("dd/MM/yyyy").format(DateTime.parse(groupByValue)),
                                        fontsize: 16.0,
                                      ),
                                      SizedBox(height: 5),
                                    ],
                                  ),
                                  itemBuilder: (context, dynamic element) {
                                    return Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 11),
                                          margin: EdgeInsets.only(bottom: 15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(13),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.3),
                                                blurRadius: 1.0,
                                                spreadRadius: 0.5,
                                                offset: Offset(01, 0),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(4),
                                                child: CachedImageContainer(
                                                  image: element.notificationType == 3 ? "$BaseUrl${element.carImage}" : "$BaseUrl${element.profilePic}",
                                                  fit: BoxFit.cover,
                                                  height: 40,
                                                  width: 40,
                                                  placeholder: assetsUrl.plashHolder,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Container(
                                                width: Get.width * 0.440,
                                                //color: Colors.blue,
                                                child: commonWidget.mediumText(
                                                  element.notificationText,
                                                  fontsize: 14.0,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              Spacer(),
                                              commonWidget.mediumText(
                                                timeago.format(DateTime.parse(element.createdAt.toString())),
                                                fontsize: 14.0,
                                              )
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: -6,
                                          child: InkWell(
                                            onTap: () {
                                              print("element.notificationId   ${element.notificationId}");
                                              controller.notificationRemove_api(notificationId: element.notificationId);
                                            },
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            child: CircleAvatar(
                                              radius: 9,
                                              backgroundColor: Colors.red,
                                              child: Icon(
                                                Icons.clear,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                  order: GroupedListOrder.ASC, // optional
                                ),
                              ),
                      ],
                    ),
                  )),
            );
          });
        });
  }
}

// import 'package:autotomi/app/data/NetworkClint.dart';
// import 'package:autotomi/common/CachedImageContainer.dart';
// import 'package:autotomi/common/Strings.dart';
// import 'package:autotomi/common/asset.dart';
// import 'package:autotomi/common/constant.dart';
// import 'package:autotomi/common/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:grouped_list/grouped_list.dart';
// import 'package:intl/intl.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import '../controllers/notification_controller.dart';
// import 'package:timeago/timeago.dart' as timeago;
//
// class NotificationView extends GetView<NotificationController> {
//   const NotificationView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<NotificationController>(
//         init: NotificationController(),
//         builder: (logic) {
//           return Obx(() {
//             return ModalProgressHUD(
//               inAsyncCall: controller.isLoading.value,
//               opacity: 0,
//               progressIndicator: customerIndicator,
//               child: Scaffold(
//                   backgroundColor: Colors.white,
//                   appBar: commonWidget.customAppbar(
//                     arroOnTap: () {
//                       Get.back();
//                     },
//                     actions: SizedBox(),
//                     backgroundColor: Colors.white,
//                     centerTitle: true,
//                     titleText: stringsUtils.Notifications,
//                   ),
//                   body: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 10),
//                         // ListView.builder(
//                         //   physics: NeverScrollableScrollPhysics(),
//                         //   shrinkWrap: true,
//                         //   itemCount: controller.firstList.length,
//                         //   itemBuilder: (context, index) {
//                         //     return Container(
//                         //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 11),
//                         //       margin: EdgeInsets.only(bottom: 10),
//                         //       decoration: BoxDecoration(
//                         //         color: Colors.white,
//                         //         borderRadius: BorderRadius.circular(13),
//                         //         boxShadow: [
//                         //           BoxShadow(
//                         //             color: Colors.grey.withOpacity(0.3),
//                         //             blurRadius: 1.0,
//                         //             spreadRadius: 0.5,
//                         //             offset: Offset(01, 0),
//                         //           ),
//                         //         ],
//                         //       ),
//                         //       child: Row(
//                         //         children: [
//                         //           ClipRRect(
//                         //             borderRadius: BorderRadius.circular(4),
//                         //             child: Image.asset(
//                         //               controller.firstList[index]['image'],
//                         //               height: 40,
//                         //               width: 40,
//                         //               fit: BoxFit.cover,
//                         //             ),
//                         //           ),
//                         //           SizedBox(width: 8),
//                         //           Container(
//                         //             width: Get.width * 0.6,
//                         //             child: commonWidget.mediumText(
//                         //               controller.firstList[index]['text'],
//                         //               fontsize: 14.0,
//                         //               overflow: TextOverflow.ellipsis,
//                         //               maxLines: 2,
//                         //             ),
//                         //           ),
//                         //           SizedBox(width: 8),
//                         //           commonWidget.mediumText(
//                         //             "2 min",
//                         //             fontsize: 14.0,
//                         //           )
//                         //         ],
//                         //       ),
//                         //     );
//                         //   },
//                         // ),
//
//                         Expanded(
//                           child: GroupedListView<dynamic, String>(
//                             physics: BouncingScrollPhysics(),
//                             shrinkWrap: true,
//                             reverse: false,
//                             elements: controller.notificationList,
//                             groupBy: (element) => controller.formatDate(DateTime.parse(element.createdAt.toString())),
//                             groupComparator: (value1, value2) => value2.compareTo(value1),
//                             groupSeparatorBuilder: (String groupByValue) => Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(height: 5),
//                                 commonWidget.mediumText(
//                                   DateFormat("dd/MM/yyyy").format(DateTime.parse(groupByValue)) == controller.formattedDate
//                                       ? "Today"
//                                       : DateFormat("dd/MM/yyyy").format(DateTime.parse(groupByValue)) == controller.formattedDateYest
//                                           ? "Yesterday"
//                                           : DateFormat("dd/MM/yyyy").format(DateTime.parse(groupByValue)),
//                                   fontsize: 16.0,
//                                 ),
//                                 SizedBox(height: 5),
//                               ],
//                             ),
//                             itemBuilder: (context, dynamic element) {
//                               return Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 5, vertical: 11),
//                                 margin: EdgeInsets.only(bottom: 10),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(13),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.3),
//                                       blurRadius: 1.0,
//                                       spreadRadius: 0.5,
//                                       offset: Offset(01, 0),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(4),
//                                       child: CachedImageContainer(
//                                         image: element.notificationType == 3 ? "$BaseUrl${element.carImage}" : "$BaseUrl${element.profilePic}",
//                                         fit: BoxFit.cover,
//                                         height: 40,
//                                         width: 40,
//                                         placeholder: assetsUrl.plashHolder,
//                                       ),
//                                     ),
//                                     SizedBox(width: 4),
//                                     Container(
//                                       width: Get.width * 0.440,
//                                       //color: Colors.blue,
//                                       child: commonWidget.mediumText(
//                                         element.notificationText,
//                                         fontsize: 14.0,
//                                         overflow: TextOverflow.ellipsis,
//                                         maxLines: 2,
//                                       ),
//                                     ),
//                                     Spacer(),
//                                     commonWidget.mediumText(
//                                       timeago.format(DateTime.parse(element.createdAt.toString())),
//                                       fontsize: 14.0,
//                                     )
//                                   ],
//                                 ),
//                               );
//                             },
//                             order: GroupedListOrder.ASC, // optional
//                           ),
//                         ),
//                       ],
//                     ),
//                   )),
//             );
//           });
//         });
//   }
// }
