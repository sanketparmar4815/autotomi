import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class HowItsWorkController extends GetxController {
  VideoPlayerController? videoplayerController;
  Future<void>? initializeVideoPlayerFuture;

  willPopScope() {
    videoplayerController!.dispose();
    Get.back();
  }

  videoPlayer() {
    if (Get.arguments != null) {
      videoplayerController = VideoPlayerController.network("$BaseUrl${videoUrl}");
    } else {
      videoplayerController = VideoPlayerController.asset("assets/video/CardTestVideo.mp4");
    }

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

  var videoUrl;
  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      videoUrl = Get.arguments;
      print(videoUrl);
      print("rutik45216");
    }
    await videoPlayer();
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
}
