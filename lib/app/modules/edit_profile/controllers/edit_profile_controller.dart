import 'dart:io';
import 'package:autotomi/app/Model/edit_profile_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/PrefsKey.dart';
import 'package:autotomi/common/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';

class EditProfileController extends GetxController {
  var selectedCountryCode = "1";
  var isoCode = "1";

  TextEditingController phoneController = TextEditingController();
  TextEditingController firsName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  List addPhotoList = ['Add a photo?', 'Take photo', 'Choose from gallery', 'Cancel'];

  var image, profile_pic, isLoading = false.obs;
  String? imagePath;
  final _picker = ImagePicker();

  fromCamera({argument}) async {
    final pickedFile = await _picker.getImage(source: argument == 1 ? ImageSource.camera : ImageSource.gallery);
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
    editProfile_Api(getData: 1);
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

  editProfile_Api({var getData}) async {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "edit_profile",
      method: MethodType.Post,
      params: getData == 0
          ? FormData.fromMap({
              'profile_pic': image != null
                  ? await MultipartFile.fromFile(
                      image.path.toString(),
                      filename: image.path.toString().split('/').last.toString().split('\'').first,
                    )
                  : '',
              'first_name': firsName.text,
              'last_name': lastName.text,
              'country_code': selectedCountryCode.toString(),
              'phone_number': phoneController.text,
            })
          : "",
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) async {
        print(response);
        if (response['Status'] == 1) {
          edit_profile_model data = edit_profile_model.fromJson(response);
          if (getData == 1) {
            profile_pic = data.info!.profilePic;
            phoneController.text = data.info!.phoneNumber!;
            firsName.text = data.info!.firstName!;
            lastName.text = data.info!.lastName!;

            if (data.info!.countryCode != null && data.info!.phoneNumber != "") {
              selectedCountryCode = data.info!.countryCode!;
              try {
                PhoneNumber number = await PhoneNumber.fromCompleteNumber(completeNumber: '+${data.info!.countryCode}${data.info!.phoneNumber}');
                // final regionCode = number.isoCode;
                isoCode = number.countryISOCode;
                print(isoCode);
                print('dialCode==========>try');
                isLoading.value = false;
              } catch (e) {
                print('Error parsing dial code: $e');
                isLoading.value = false;
                return '';
              }
            }

            update();
          } else {
            isLoading.value = false;
            Toasty.showtoast(response['Message']);
            box.write(PrefsKey.profilePic, data.info!.profilePic);
            box.write('country_code', data.info!.countryCode!);
            box.write(PrefsKey.phoneNumber, data.info!.phoneNumber!);
            box.write(PrefsKey.firstName, data.info!.firstName!);
            box.write(PrefsKey.lastName, data.info!.lastName!);
            Get.back(
              result: {
                'profile_pic': data.info!.profilePic,
                'first_name': data.info!.firstName,
                'last_name': data.info!.lastName,
                'country_code': data.info!.countryCode,
                'phone_number': data.info!.phoneNumber,
              },
            );
            update();
          }
        } else {
          isLoading.value = false;
          Toasty.showtoast(response['Message']);
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
