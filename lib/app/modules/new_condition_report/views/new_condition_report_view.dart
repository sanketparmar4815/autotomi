import 'package:autotomi/app/routes/app_pages.dart';
import 'package:autotomi/common/asset.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';

import '../controllers/new_condition_report_controller.dart';

class NewConditionReportView extends GetView<NewConditionReportController> {
  const NewConditionReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewConditionReportController controller = Get.put(NewConditionReportController());
    return GetBuilder<NewConditionReportController>(
      assignId: true,
      init: NewConditionReportController(),
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
                fontsize: 20.0,
                arroOnTap: () {
                  Get.back();
                  controller.removeVideo();
                },
                titleText: 'New Condition Report',
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
                          GestureDetector(
                              onTapUp: (value) {
                                RenderBox renderBox = context.findRenderObject() as RenderBox;
                                Offset localPosition = renderBox.globalToLocal(value.globalPosition);
                                // controller.tapCount;
                                controller.isCheckReport = true;
                                controller.tapDy = localPosition.dy;
                                controller.tapDx = localPosition.dx;
                                print("tap dx and dy");
                                print(controller.tapDy);
                                print(controller.tapDx);

                                print(controller.tapCount);
                                print("controller.tapCount");
                                controller.update();
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 305,
                                    height: 282,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
                                      child: Image.asset(
                                        assetsUrl.ConditionReport,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: controller.tapDy - 90,
                                    left: controller.tapDx - 45,
                                    child: CircleAvatar(
                                      radius: 9,
                                      backgroundColor: Colors.black,
                                      child: Center(
                                        child: commonWidget.mediumText(
                                          '${controller.tapCount}',
                                          fontsize: 11.0,
                                          tcolor: Colors.white,
                                        ),
                                        // child: Text(
                                        //   "${tapDetails.tapCount}",
                                        //   style: TextStyle(fontSize: 10, color: Colors.white),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(height: hw.height * 0.02),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    commonWidget.mediumText('1.', fontsize: 18.0),
                                    SizedBox(width: 30),
                                    InkWell(
                                      onTap: () {
                                        if (controller.imagePath == null && controller.videoPlayerController == null) {
                                          if (controller.isCheckReport == true) {
                                            controller.fromCamera();
                                            controller.update();
                                          } else {
                                            Toasty.showtoast("please select any damage part of car");
                                          }
                                        } else {
                                          Toasty.showtoast("Please add photo or video of the damaged area you are reporting");
                                        }
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Container(
                                        height: 40,
                                        width: 110,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xffECF5EF)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(assetsUrl.camera1, height: 22, width: 22),
                                            SizedBox(width: 8),
                                            commonWidget.semiBoldText(
                                              'Add',
                                              fontsize: 15.0,
                                              tcolor: color.appColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          if (controller.imagePath == null && controller.videoPlayerController == null) {
                                            if (controller.isCheckReport == true) {
                                              controller.getVideo(ImageSource.camera);
                                              controller.update();
                                            } else {
                                              Toasty.showtoast("please select any damage part of car");
                                            }
                                          } else {
                                            Toasty.showtoast("you can select any one Photos and Video");
                                          }
                                        },
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xffECF5EF)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset(assetsUrl.video, height: 22, width: 22),
                                              SizedBox(width: 8),
                                              commonWidget.semiBoldText(
                                                'Record a Video ',
                                                fontsize: 15.0,
                                                tcolor: color.appColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                controller.imagePath == null ? SizedBox() : SizedBox(height: 15),
                                controller.imagePath == null
                                    ? SizedBox()
                                    : Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Container(
                                              height: 180,
                                              width: hw.width,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(image: FileImage(controller.image), fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: -3,
                                            top: -5,
                                            child: InkWell(
                                              onTap: () {
                                                controller.removeImage();
                                                controller.update();
                                              },
                                              splashColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              child: CircleAvatar(
                                                radius: 10,
                                                backgroundColor: Colors.red,
                                                child: Icon(
                                                  Icons.clear,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                SizedBox(height: 15),
                                controller.videoPlayerController == null
                                    ? SizedBox()
                                    : Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            child: Container(
                                              height: 180,
                                              width: hw.width,
                                              child: FlickVideoPlayer(
                                                flickManager: FlickManager(
                                                  videoPlayerController: controller.videoPlayerController!,
                                                  autoPlay: false,
                                                  autoInitialize: false,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // controller.isPlayVideo == true
                                          //     ? SizedBox()
                                          //     : Positioned(
                                          //         top: 70,
                                          //         left: 140,
                                          //         child: InkWell(
                                          //             onTap: () {
                                          //               controller.videoPlayerController!.play();
                                          //               controller.isPlayVideo = true;
                                          //               print(controller.isPlayVideo);
                                          //               print("rutik");
                                          //               controller.update();
                                          //             },
                                          //             splashColor: Colors.transparent,
                                          //             highlightColor: Colors.transparent,
                                          //             child: Image.asset(
                                          //               assetsUrl.playIcon,
                                          //               scale: 3,
                                          //             )),
                                          //       ),
                                          Positioned(
                                            right: -3,
                                            top: -5,
                                            child: InkWell(
                                              onTap: () {
                                                controller.removeVideo();
                                                controller.update();
                                              },
                                              splashColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              child: CircleAvatar(
                                                radius: 10,
                                                backgroundColor: Colors.red,
                                                child: Icon(
                                                  Icons.clear,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                controller.videoPlayerController == null ? SizedBox() : SizedBox(height: 15),
                                commonWidget.customTextfield(
                                  controller: controller.report,
                                  hintText: 'Enter here.',
                                  label: 'Report:',
                                  maxLines: 4,
                                ),
                                SizedBox(height: 15),
                                Divider(),
                                SizedBox(height: 15),
                                commonWidget.semiBoldText(
                                  'Information Area:',
                                  fontsize: 16.0,
                                  tcolor: Color(0xff787878),
                                ),
                                SizedBox(height: 12),
                                commonWidget.mediumText(
                                  'Wait for an agent to inspect and approve your report.\n\nPlease report additional dents or damage if found.',
                                  fontsize: 15.0,
                                ),

                                // SizedBox(height: 12),
                                // commonWidget.mediumText(
                                //   'Wait for an agent to inspect the car and approve. This may take up to 20 minutes. if you cannot wait, use the express return.',
                                //   fontsize: 15.0,
                                // ),
                                // SizedBox(height: 12),
                                // commonWidget.mediumText(
                                //   'Please report additional dents or damage if found',
                                //   fontsize: 15.0,
                                // ),
                                // SizedBox(height: 12),
                                // commonWidget.mediumText(
                                //   'Kindly inspect the car for dents and report additional dents if found.',
                                //   fontsize: 15.0,
                                // ),
                                // SizedBox(height: 12),
                                // commonWidget.mediumText(
                                //   'Tap on the damaged part of the car in the diagram to add  photo or video of the damaged area.',
                                //   fontsize: 15.0,
                                // ),
                                SizedBox(height: hw.height * 0.01),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                    child: Column(
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     // InkWell(
                        //     //   onTap: () {
                        //     //     Get.toNamed(Routes.CHANGE_RIDE);
                        //     //   },
                        //     //   splashColor: Colors.transparent,
                        //     //   highlightColor: Colors.transparent,
                        //     //   child: Container(
                        //     //     height: 48,
                        //     //     width: 135,
                        //     //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xffECF5EF)),
                        //     //     child: Center(
                        //     //       child: commonWidget.semiBoldText(
                        //     //         'Change Ride',
                        //     //         fontsize: 15.0,
                        //     //         tcolor: color.appColor,
                        //     //       ),
                        //     //     ),
                        //     //   ),
                        //     // ),
                        //     InkWell(
                        //       onTap: () {
                        //         // controller.removeVideo();
                        //         // controller.removeImage();
                        //       },
                        //       highlightColor: Colors.transparent,
                        //       splashColor: Colors.transparent,
                        //       child: Container(
                        //         // height: 48,
                        //         // width: 135,
                        //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xffECF5EF)),
                        //         child: Center(
                        //           child: commonWidget.semiBoldText(
                        //             '+ Add Condition Report',
                        //             fontsize: 15.0,
                        //             tcolor: color.appColor,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 12),
                        keyboardIsOpen
                            ? SizedBox()
                            : commonWidget.customButton(
                                onTap: () async {
                                  if (validation()) {
                                    controller.addConditionReport_Api();
                                  }
                                },
                                text: 'Submit',
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  bool validation() {
    if (controller.isCheckReport == false) {
      Toasty.showtoast("please select any damage part of car");
      return false;
    } else if (controller.imagePath == null && controller.videoPlayerController == null) {
      Toasty.showtoast("Please add photo or video of the damaged area you are reporting");
      return false;
    } else if (controller.report.text.isEmpty) {
      Toasty.showtoast("please enter Report");
      return false;
    } else {
      return true;
    }
  }
}
