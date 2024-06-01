import 'dart:io';

import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/personal_info4/views/personal_info4_view.dart';
import 'package:autotomi/common/constant.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';

class PersonalInfo3Controller extends GetxController {
  var image, image2, image3, profile_pic, flag, isLoading = false.obs;

  String? imagePath;
  String? imagePath2;
  final _picker = ImagePicker();
  fromCamera() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePath = pickedFile.path;
    } else {
      print('No image selected.');
    }
    update();
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
      print(flag);
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

  accountStatementUpdate_Api() async {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "upload_account_statement",
      method: MethodType.Post,
      params: FormData.fromMap({
        'account_statement_url': image != null
            ? await MultipartFile.fromFile(
                image.path.toString(),
                filename: image.path.toString().split('/').last.toString().split('\'').first,
              )
            : '',
      }),
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          Toasty.showtoast(response['Message']);
          Get.to(() => PersonalInfo4View(), arguments: {'flag': flag});
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
