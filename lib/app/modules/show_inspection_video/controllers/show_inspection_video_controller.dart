import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ShowInspectionVideoController extends GetxController {
  var videoUrl, images, flag;
  onWillPopScope() {
    Get.back();
    videoplayerController!.dispose();
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
      videoUrl = Get.arguments['video'];
      images = Get.arguments['image'];
    }
    if (videoUrl != null) {
      videoPlayer();
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  VideoPlayerController? videoplayerController;
  Future<void>? initializeVideoPlayerFuture;

  videoPlayer() {
    videoplayerController = VideoPlayerController.network("$BaseUrl${videoUrl}");
    initializeVideoPlayerFuture = videoplayerController!.initialize().then((value) {
      videoplayerController!.play();
      update();
    });
    videoplayerController!.addListener(() {
      print("duration------->");
      print(videoplayerController!.value.duration);
      print(videoplayerController!.value.position);
      print(videoplayerController!.value.isPlaying);
      if (videoplayerController!.value.duration == videoplayerController!.value.position) {
        // isVideoPause.value = 1;
        videoplayerController!.pause();
        //videoplayerController!.play();
      }
    });
  }
}
