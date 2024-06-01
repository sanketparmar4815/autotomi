import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../controllers/how_its_work_controller.dart';

class HowItsWorkView extends GetView<HowItsWorkController> {
  const HowItsWorkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HowItsWorkController controller = Get.put(HowItsWorkController());
    return GetBuilder<HowItsWorkController>(
      assignId: true,
      init: HowItsWorkController(),
      builder: (logic) {
        return WillPopScope(
          onWillPop: () {
            return controller.willPopScope();
          },
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: SafeArea(
                child: InkWell(
                  onTap: () {
                    Get.back();
                    controller.videoplayerController!.dispose();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            body: Center(
              child: GestureDetector(
                onTap: () {
                  if (controller.videoplayerController!.value.isPlaying) {
                    controller.videoplayerController!.pause();
                    controller.update();
                  } else {
                    controller.videoplayerController!.play();
                    controller.update();
                  }
                },
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  child: FlickVideoPlayer(
                    flickManager: FlickManager(
                      videoPlayerController: controller.videoplayerController!,
                      autoPlay: false,
                      autoInitialize: false,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
