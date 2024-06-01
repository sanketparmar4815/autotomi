import 'dart:io';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/personal_info/views/personal_info_view.dart';
import 'package:autotomi/common/PrefsKey.dart';
import 'package:autotomi/common/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateAccountController extends GetxController {
  var selectedCountryCode = "91";
  var isoCode = "IN";
  var numberLength;

  String? selectMaritalStatus, selectKids;

  List<String> maritalStatus = ['Single', 'Married'];
  List<String> selectKidsStatus = ['YES', 'NO'];

  TextEditingController phoneController = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController countryName = TextEditingController();
  TextEditingController countryofresidence = TextEditingController();
  TextEditingController employmentStatus = TextEditingController();
  TextEditingController profession = TextEditingController();
  var dialCode, isLoading = false.obs, isPermission = false.obs;

  String? countryVisiting, countryCode;
  List countryCodeList = [
    {
      'name': 'Benin',
      'code': '229',
    },
    {
      'name': 'Burkina Faso',
      'code': '226',
    },
    {
      'name': 'Cape Verde',
      'code': '238',
    },
    {
      'name': "Côte D'Ivoire",
      'code': '225',
    },
    {
      'name': "Gambia, Ghana",
      'code': '220',
    },
    {
      'name': "Guinea",
      'code': '224',
    },
    {
      'name': "Guinea-Bissau",
      'code': '245',
    },
    {
      'name': "Liberia, Mali",
      'code': '231',
    },
    {
      'name': "Mauritania",
      'code': '222',
    },
    {
      'name': "Niger",
      'code': '227',
    },
    {
      'name': "Nigeria",
      'code': '234',
    },
    {
      'name': "Senegal",
      'code': '221',
    },
    {
      'name': "Sierra Leone",
      'code': '232',
    },
    {
      'name': "Togo",
      'code': '228',
    },
  ];

  List addPhotoList = ['Add a photo?', 'Take photo', 'Choose from gallery', 'Cancel'];
  RxList countryList = [].obs;
  var selectedCountry;
  var image, profile_pic, token;
  String? imagePath;
  final _picker = ImagePicker();

  fromCamera({argument}) async {
    final pickedFile = await _picker.pickImage(source: argument == 1 ? ImageSource.camera : ImageSource.gallery);
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
      token = Get.arguments['userToken'];
      print(token);
      print('token');
    }
    list_country_Api();
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

  createAccount_Api() async {
    print(image.path.toString().split('/').last.toString().split('\'').first);
    print("rutik");
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "create_account",
      method: MethodType.Post,
      params: FormData.fromMap({
        'profile_pic': image != null
            ? await MultipartFile.fromFile(
                image.path.toString(),
                filename: image.path.toString().split('/').last.toString().split('\'').first,
              )
            : '',
        'first_name': firstName.text,
        'last_name': lastName.text,
        'country_code': selectedCountryCode.toString(),
        'phone_number': phoneController.text,
        'residence_country': countryofresidence.text,
        'home_country': countryVisiting.toString(),
        'home_country_id': selectedCountry,
        'marital_status': selectMaritalStatus.toString(),
        'is_have_kids': selectKids.toString(),
        'employment_status': employmentStatus.text,
        'profession': profession.text,
      }),
      headers: NetworkClient.getInstance.getAuthHeaders(tokenRegister: token),
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          box.write('user_token', token);
          box.write('user_id', response['info']['user_id']);
          box.write('country_visiting', response['info']['country']);
          box.write('is_profile', response['info']['is_profile']);
          box.write(PrefsKey.profilePic, response['info']['profile_pic']);
          box.write(PrefsKey.login_type, response['info']['login_type']);
          box.write('country_code', response['info']['country_code']);
          box.write(PrefsKey.phoneNumber, response['info']['phone_number']);
          box.write(PrefsKey.firstName, response['info']['first_name']);
          box.write(PrefsKey.lastName, response['info']['last_name']);
          Get.offAll(() => PersonalInfoView(), arguments: {'flag': 1});
        } else {
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

  list_country_Api() async {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "list_country",
      method: MethodType.Post,
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          countryList.value = response['info'];
          update();
        } else {
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

  checkPermission() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    if (cameraStatus.isGranted == true) {
      isPermission.value = true;
      // fromCamera(argument: 1);
    } else if (cameraStatus.isPermanentlyDenied == true) {
      print("Media permissions are permanently denied");
      Toasty.showtoast('Please Allow Media & Camera Permission');
      Future.delayed(Duration(seconds: 2), () {
        openAppSettings();
      });
    } else {}
  }
}
