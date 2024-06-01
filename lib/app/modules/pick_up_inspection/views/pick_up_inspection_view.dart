import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/new_condition_report/views/new_condition_report_view.dart';
import 'package:autotomi/app/modules/pin/views/pin_view.dart';
import 'package:autotomi/app/modules/show_inspection_video/views/show_inspection_video_view.dart';
import 'package:autotomi/app/routes/app_pages.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/widgets.dart';
import '../controllers/pick_up_inspection_controller.dart';

class PickUpInspectionView extends GetView<PickUpInspectionController> {
  const PickUpInspectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PickUpInspectionController controller = Get.put(PickUpInspectionController());
    return GetBuilder<PickUpInspectionController>(
        init: PickUpInspectionController(),
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
                  titleText: controller.flag == 2 ? 'Return Inspection' : 'Pick up Inspection',
                  actions: SizedBox(),
                  centerTitle: false,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            controller.getCarConditionList.length == 0 && controller.isLoading.value == false
                                ? SizedBox()
                                : Stack(
                                    children: [
                                      Container(
                                        width: 305,
                                        height: 282,
                                        decoration: BoxDecoration(
                                            //color: color.fillColor,
                                            ),
                                        child: Image.asset(
                                          // color: Colors.green,
                                          assetsUrl.ConditionReport,
                                          //assetsUrl.car2,
                                        ),
                                      ),
                                      for (var i = 0; i < controller.getCarConditionList.length; i++)
                                        Positioned(
                                          top: controller.getCarConditionList[i].reportType != 1 || controller.getCarConditionList[i].isUpdate == 1 ? double.parse(controller.getCarConditionList[i].tapDy.toString()) - 90 : double.parse(controller.getCarConditionList[i].tapDy.toString()),
                                          left: controller.getCarConditionList[i].reportType != 1 || controller.getCarConditionList[i].isUpdate == 1 ? double.parse(controller.getCarConditionList[i].tapDx.toString()) - 45 : double.parse(controller.getCarConditionList[i].tapDx.toString()),
                                          child: Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: controller.getCarConditionList[i].reportType == 1
                                                  ? color.appColor
                                                  : controller.getCarConditionList[i].reportType == 2
                                                      ? Colors.amber
                                                      : controller.getCarConditionList[i].reportType == 3
                                                          ? Colors.red
                                                          : color.black,
                                            ),
                                            child: Center(
                                              child: commonWidget.mediumText(
                                                '${i + 1}',
                                                fontsize: 10.0,
                                                tcolor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                            SizedBox(height: hw.height * 0.02),
                            controller.getCarConditionList.length == 0 && controller.isLoading.value == false
                                ? SizedBox()
                                : Row(
                                    children: [
                                      Expanded(child: Divider(color: color.appColor)),
                                      SizedBox(width: 8),
                                      commonWidget.semiBoldText('Current Condition', fontsize: 16.0, tcolor: color.appColor),
                                      SizedBox(width: 8),
                                      Expanded(child: Divider(color: color.appColor)),
                                    ],
                                  ),
                            SizedBox(height: hw.height * 0.02),
                            controller.getCarConditionList.length == 0 ? SizedBox(height: Get.height * 0.3) : SizedBox(),
                            controller.getCarConditionList.length == 0 && controller.isLoading.value == false
                                ? commonWidget.semiBoldText('No Data Found', fontsize: 18.0)
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller.getCarConditionList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          SizedBox(height: hw.height * 0.02),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 9,
                                                      backgroundColor: controller.getCarConditionList[index].reportType == 1
                                                          ? color.appColor
                                                          : controller.getCarConditionList[index].reportType == 2
                                                              ? Colors.amber
                                                              : controller.getCarConditionList[index].reportType == 3
                                                                  ? Colors.red
                                                                  : color.black,
                                                      child: Center(
                                                        child: commonWidget.mediumText(
                                                          '${index + 1}',
                                                          fontsize: 11.0,
                                                          tcolor: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    commonWidget.mediumText(
                                                        controller.getCarConditionList[index].reportType == 1
                                                            ? 'Default Inspection'
                                                            : controller.getCarConditionList[index].reportType == 2
                                                                ? 'Pickup Inspection'
                                                                : controller.getCarConditionList[index].reportType == 3
                                                                    ? 'During Rent Inspection'
                                                                    : 'Drop of Return Inspection',
                                                        fontsize: 18.0),
                                                  ],
                                                ),
                                                SizedBox(height: hw.height * 0.016),
                                                controller.getCarConditionList[index].reportThumbnail == "" || controller.getCarConditionList[index].reportThumbnail == null || controller.getCarConditionList[index].reportThumbnail == "undefined"
                                                    ? InkWell(
                                                        onTap: () {
                                                          Get.to(() => ShowInspectionVideoView(), arguments: {
                                                            'flag': 1,
                                                            'image': controller.getCarConditionList[index].reportImage,
                                                          });
                                                        },
                                                        splashColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(8),
                                                          child: CachedImageContainer(
                                                            image: "$BaseUrl${controller.getCarConditionList[index].reportImage}",
                                                            fit: BoxFit.cover,
                                                            height: 180,
                                                            width: Get.width,
                                                            placeholder: assetsUrl.plashHolderFullCard,
                                                            // flag: 1,
                                                          ),
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          Get.to(() => ShowInspectionVideoView(), arguments: {
                                                            'flag': 2,
                                                            'video': controller.getCarConditionList[index].reportImage,
                                                          });
                                                        },
                                                        splashColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        child: Stack(
                                                          children: [
                                                            InkWell(
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(8),
                                                                child: CachedImageContainer(
                                                                  image: "$BaseUrl${controller.getCarConditionList[index].reportThumbnail}",
                                                                  fit: BoxFit.cover,
                                                                  height: 180,
                                                                  width: Get.width,
                                                                  placeholder: assetsUrl.plashHolderFullCard,
                                                                  // flag: 1,
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              top: 0,
                                                              left: 0,
                                                              right: 0,
                                                              bottom: 0,
                                                              child: Center(
                                                                child: Image.asset(
                                                                  assetsUrl.playIcon,
                                                                  scale: 2.5,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                SizedBox(height: hw.height * 0.016),
                                                commonWidget.semiBoldText(
                                                  'Report:',
                                                  fontsize: 16.0,
                                                  tcolor: Color(0xff787878),
                                                ),
                                                SizedBox(height: 12),
                                                commonWidget.mediumText(
                                                  '${controller.getCarConditionList[index].reportText}',
                                                  fontsize: 15.0,
                                                ),
                                                SizedBox(height: hw.height * 0.016),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              Get.to(() => NewConditionReportView(), arguments: {
                                'flag': controller.flag,
                                'car_id': controller.carID,
                                'booking_id': controller.bookingID,
                                'report_type': controller.flag == 2 ? 4 : 2,
                              })!
                                  .then((value) {
                                print(value);
                                print('value');
                                if (value != null) {
                                  controller.getCarCondition_APi();
                                  controller.update();
                                }
                              });
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                              // height: 48,
                              // width: 135,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xffECF5EF)),
                              child: Center(
                                child: commonWidget.semiBoldText(
                                  '+ Add Condition Report',
                                  fontsize: 15.0,
                                  tcolor: color.appColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: commonWidget.customButton(
                        onTap: () {
                          controller.flag == 1 ? controller.sentReturnCar_Api() : controller.sentEmployeeCredentials_Api();
                        },
                        text: controller.flag == 2 ? 'Return Car' : 'Accept Car',
                      ),
                    ),
                    SizedBox(height: hw.height * 0.03),
                  ],
                ),
              ),
            );
          });
        });
  }
}

class TapDetails {
  var tapDy;
  var tapDx;
  var tapCount;

  TapDetails({required this.tapDy, required this.tapDx, this.tapCount});
}
