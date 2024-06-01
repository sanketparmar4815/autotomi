import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:autotomi/common/asset.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/show_inspection_video_controller.dart';

class ShowInspectionVideoView extends GetView<ShowInspectionVideoController> {
  const ShowInspectionVideoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowInspectionVideoController>(
        init: ShowInspectionVideoController(),
        builder: (logic) {
          return WillPopScope(
            onWillPop: () {
              return controller.onWillPopScope();
            },
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: Stack(
                  children: [
                    Center(
                      child: controller.flag == 1
                          ? CachedImageContainer(
                              image: "$BaseUrl${controller.images}",
                              fit: BoxFit.cover,
                              height: Get.height,
                              width: Get.width,
                              placeholder: assetsUrl.plashHolderFullCard,
                              // flag: 1,
                            )
                          : GestureDetector(
                              onTap: () {
                                if (controller.videoplayerController!.value.isPlaying) {
                                  controller.videoplayerController!.pause();
                                  controller.update();
                                } else {
                                  controller.videoplayerController!.play();
                                  controller.update();
                                }
                              },
                              child: FlickVideoPlayer(
                                flickManager: FlickManager(
                                  videoPlayerController: controller.videoplayerController!,
                                  autoPlay: false,
                                  autoInitialize: false,
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      top: 5,
                      left: 15,
                      child: SafeArea(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                            controller.videoplayerController!.pause();
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(right: 2.0),
                              child: Image.asset(
                                assetsUrl.ArrowbackIcon,
                                scale: 4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
