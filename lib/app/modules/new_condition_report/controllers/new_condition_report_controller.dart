import 'dart:io';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class NewConditionReportController extends GetxController {
  var image, videoThumbnail, profile_pic, flag, accept, carID, bookingID, isLoading = false.obs, reportType;
  var tapCount = 1, tapDy = 0.0, tapDx = 0.0;
  var isCheckReport = false;
  var isPlayVideo = false;
  TextEditingController report = TextEditingController();
  String? imagePath, videoUrl;
  final picker = ImagePicker();
  // final _picker = ImagePicker();
  VideoPlayerController? videoPlayerController;
  Future<void>? initializeVideoPlayerFuture;

  fromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePath = pickedFile.path;
    } else {
      print('No image selected.');
    }
    update();
  }

  void removeImage() {
    image = null;
    imagePath = null;
    update();
  }

  RxString videoPath = ''.obs;

  //Rx<VideoPlayerController?> videoController = Rx<VideoPlayerController?>(null);

  File? galleryFile;

  Future getVideo(ImageSource img) async {
    final pickedFile = await picker.pickVideo(
      source: img,
      preferredCameraDevice: CameraDevice.front,
      maxDuration: Duration(minutes: 10),
    );

    if (pickedFile != null) {
      videoPlayerController = VideoPlayerController.file(File(pickedFile.path));

      final getThumbnail = await VideoThumbnail.thumbnailFile(
        video: pickedFile.path,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
      );
      videoThumbnail = getThumbnail;
      videoUrl = pickedFile.path;
      print(videoUrl);
      print("videoUrl");
      initializeVideoPlayerFuture = videoPlayerController!.initialize().then((value) {
        // videoPlayerController!.play();
        // update();
      });
      videoPlayerController!.addListener(() {
        if (videoPlayerController!.value.duration == videoPlayerController!.value.position) {
          videoPlayerController!.pause();
          isPlayVideo = false;
          print(isPlayVideo);
          update();
        }
      });
    } else {}
    update();
  }

  void removeVideo() {
    videoPlayerController!.pause();
    videoPlayerController = null;
    videoPath.value = '';
    update();
  }

  @override
  void onInit() {
    isCheckReport = false;
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
      carID = Get.arguments['car_id'];
      bookingID = Get.arguments['booking_id'];
      reportType = Get.arguments['report_type'];
    }
    print(reportType);
    print("rutik@222");
    print(flag);
    print(carID);
    print(bookingID);
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

  addConditionReport_Api() async {
    print("rutik");
    print("tapDy ->>>>>${tapDy}");
    print("tapDx  ->>>>>>${tapDx}");
    print(bookingID);
    print(videoThumbnail.toString().split('/').last.toString().split('\'').first);
    print(videoUrl);
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "add_car_condition",
      method: MethodType.Post,
      params: FormData.fromMap({
        'car_id': carID,
        'booking_id': bookingID,
        'report_text': report.text,
        'report_type': reportType,
        'tap_count': tapCount,
        'tap_dy': tapDy,
        'tap_dx': tapDx,
        'report_image': image != null
            ? await MultipartFile.fromFile(
                image.path.toString(),
                filename: image.path.toString().split('/').last.toString().split('\'').first,
              )
            : await MultipartFile.fromFile(
                videoUrl.toString(),
                filename: videoUrl.toString().split('/').last.toString().split('\'').first,
              ),
        'report_thumbnail': videoThumbnail != null
            ? await MultipartFile.fromFile(
                videoThumbnail.toString(),
                filename: videoThumbnail.toString().split('/').last.toString().split('\'').first,
              )
            : ''
      }),
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          // Toasty.showtoast(response['Message']);
          flag != 3
              ? Get.back(
                  result: 1,
                )
              : Get.back();
        } else {
          print(response['Message']);
        }
        isLoading.value = false;
      },
      failureCallback: (message, statusCode) {
        print(message.toString());
        print(statusCode);

        isLoading.value = false;
      },
      timeOutCallback: () {
        Toasty.showtoast('something is wrong please try again');
        isLoading.value = false;
      },
    );
  }
}

class TapDetails {
  final Offset localPosition;
  var tapCount;

  TapDetails({required this.localPosition, required this.tapCount});
}
