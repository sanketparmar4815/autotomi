import 'package:autotomi/app/Model/roaming_city_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/bottombar/views/bottombar_view.dart';
import 'package:autotomi/app/modules/personal_info3/views/personal_info3_view.dart';
import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'dart:io';

import '../../personal_info4/views/personal_info4_view.dart';

class PersonalInfo1Controller extends GetxController {
  var selectedCountryCode = "91", selectedCountryCodeOwner = "91";
  var isoCode = "1", flag, countryVisitingTitle, countryVisitingCode;

  TextEditingController phoneController = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController visitingPostCode = TextEditingController();
  TextEditingController addressOffWhereAre = TextEditingController();
  TextEditingController previousAddress1 = TextEditingController();
  TextEditingController previousAddressPostCode = TextEditingController();
  TextEditingController previousAddressLongRelocate = TextEditingController();
  TextEditingController previousPostCodeLongRelocate = TextEditingController();
  TextEditingController previousPostCodeWhenLastTime = TextEditingController();
  TextEditingController previousAddressWhenLastTime = TextEditingController();
  TextEditingController nameOwner = TextEditingController();
  TextEditingController OwenerAddress = TextEditingController();
  TextEditingController OwenerPostCode = TextEditingController();
  TextEditingController OwenerNumber = TextEditingController();

  String? howLongLivingAddress1, selectHowLongDrivingRelocate;
  List<String> howLongLivingAddress1List = ['6 Month', '1 Year', '2 Year', '3 Year', '4 Year'];
  List<String> howLongDrivingRelocateList = ['6 Month', '1 Year', '2 Year', '3 Year', '4 Year'];

  String? eligibilityTypeItem, haveYouLive, haveYouDriving, whenWasLast, selectRoamingCity, whereWillYouBeStaying;
  List<String> haveYouLiveList = ['Yes', 'No'];
  List<String> haveYouDrivingList = ['Yes', 'No'];
  List<String> whenWasLastList = ['6 Month', '1 Year', '2 Year', '3 Year', '4 Year'];
  List<String> whereWillYouBeStayingList = ['House', 'Hotel', 'Friends House', 'Other'];

  List selectedIndices = [];
  List<romingCity> romingCityList = [];
  RxBool isChecked = true.obs;
  var image, image2, image3, profile_pic, isLoading = false.obs;

  String? imagePath;
  var imagePath2;
  final _picker = ImagePicker();
  fromCamera({argument}) async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      argument == 1 ? imagePath = pickedFile.path : imagePath2 = pickedFile.path;

      argument == 1 ? image = File(pickedFile.path) : image2 = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    update();
  }

  var ukAddress, flatNo, postCode, proofIdImage, proofOfResidenceImage, howLongLiving, previousAddress, getPreviousAddressPostCode, guarantor, guarantorEmail, guarantorAddress;
  @override
  void onInit() {
    countryVisitingTitle = box.read('country_name');

    countryVisitingTitle = box.read('country_visiting');
    countryVisitingCode = box.read('country_visiting_code');
    print(countryVisitingTitle);
    print("object");
    selectedCountryCode = countryVisitingCode;
    selectedCountryCodeOwner = countryVisitingCode;
    // listRoamingCity_Api();
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
      ukAddress = Get.arguments['ukAddress'];
      flatNo = Get.arguments['flat_no'];
      postCode = Get.arguments['post_code'];
      proofIdImage = Get.arguments['proofIDImage'];
      proofOfResidenceImage = Get.arguments['proofOfResideceImage'];
      howLongLiving = Get.arguments['how_long_living'];
      previousAddress = Get.arguments['previous_address'];
      getPreviousAddressPostCode = Get.arguments['previous_address_postcode'];
      guarantor = Get.arguments['guarantor'];
      guarantorEmail = Get.arguments['guarantor_email'];
      guarantorAddress = Get.arguments['guarantor_address'];

      print("Data Pass");
      print(ukAddress);
      print(flatNo);
      print(postCode);
      print(proofIdImage.toString());
      print(proofOfResidenceImage.toString());
      print(howLongLiving);
      print(previousAddress);
      print(getPreviousAddressPostCode);
      print(guarantor);
      print(guarantorEmail);
      print(guarantorAddress);
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

  personalInfo_Api() async {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "add_personal_info",
      method: MethodType.Post,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      params: FormData.fromMap({
        'residence_address': ukAddress,
        'flat_number': flatNo,
        'post_code': postCode,
        'id_proof_image': proofIdImage != null
            ? await MultipartFile.fromFile(
                proofIdImage.toString(),
                filename: proofIdImage.toString().split('/').last.toString().split('\'').first,
              )
            : '',
        'residence_address_proof_image': proofOfResidenceImage != null
            ? await MultipartFile.fromFile(
                proofOfResidenceImage.toString(),
                filename: proofOfResidenceImage.toString().split('/').last.toString().split('\'').first,
              )
            : '',
        'residence_how_long_living': howLongLiving,
        'residence_previous_address': previousAddress == null ? '' : previousAddress,
        'residence_previous_address_postcode': getPreviousAddressPostCode == null ? '' : getPreviousAddressPostCode,
        'guarantor_name': guarantor,
        'gruarantor_email_id': guarantorEmail,
        'gruarantor_address': guarantorAddress,
        'home_country_code': selectedCountryCode,
        'home_phone_number': phoneController.text,
        'home_address': Address.text,
        'home_address_postcode': visitingPostCode.text,
        'home_how_long_living': howLongLivingAddress1,
        'home_previous_address': previousAddress1.text.isEmpty ? "" : previousAddress1.text,
        'home_previous_address_postcode': previousAddressPostCode.text.isEmpty ? "" : previousAddressPostCode.text,
        'license_proof_image': imagePath2 != null
            ? await MultipartFile.fromFile(
                imagePath2.toString(),
                filename: imagePath2.toString().split('/').last.toString().split('\'').first,
              )
            : '',
        // 'is_live_country_before': 'Yes',
        // 'is_driving_country_before': haveYouDriving,
        // 'how_long_driving_before_relocate': selectHowLongDrivingRelocate == null ? "" : selectHowLongDrivingRelocate,
        // 'how_long_driving_before_address': previousAddressLongRelocate.text.isEmpty ? "" : previousAddressLongRelocate.text,
        // 'how_long_driving_before_address_postcode': previousPostCodeLongRelocate.text.isEmpty ? "" : previousPostCodeLongRelocate.text,
        'last_time_visit_country': whenWasLast,
        'last_time_visit_country_address': previousAddressWhenLastTime.text.isEmpty ? "" : previousAddressWhenLastTime.text,
        'last_time_visit_country_address_postcode': previousPostCodeWhenLastTime.text.isEmpty ? "" : previousPostCodeWhenLastTime.text,
        'staying_visit_place': whereWillYouBeStaying,
        'owner_name': nameOwner.text,
        'owner_address': OwenerAddress.text,
        'owner_postcode': OwenerPostCode.text,
        'owner_country_code': selectedCountryCodeOwner,
        'owner_phone_number': OwenerNumber.text,
        // 'city_id': selectedIndices.join(","),
      }),
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          Get.to(() => PersonalInfo4View(), arguments: {'flag': flag});
          // showDialog(
          //   context: Get.context!,
          //   builder: (BuildContext context) {
          //     return AlertDialog(
          //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9.0))),
          //         contentPadding: EdgeInsets.only(top: 10.0),
          //         content: Container(
          //           height: 318,
          //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: color.fillColor),
          //           child: Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 SizedBox(height: 12),
          //                 Image.asset(assetsUrl.standardMember, height: 85, width: 85),
          //                 SizedBox(height: 12),
          //                 commonWidget.semiBoldText('Congratulations\nnow you are Standard member', fontsize: 16.0, textAlign: TextAlign.center, height: 1.5),
          //                 SizedBox(height: 14),
          //                 commonWidget.mediumText('Update a profile to become a Classic member', fontsize: 12.0),
          //                 SizedBox(height: 14),
          //                 commonWidget.customButton(
          //                   onTap: () {
          //                     Get.back();
          //                     Get.to(() => PersonalInfo3View(), arguments: {'flag': 1});
          //                   },
          //                   text: 'Upgrade',
          //                 ),
          //                 SizedBox(height: 12),
          //                 Divider(),
          //                 SizedBox(height: 12),
          //                 InkWell(
          //                   onTap: () {
          //                     if (flag == 1) {
          //                       Get.offAll(() => BottombarView());
          //                     } else {
          //                       Get.offAll(() => BottombarView(), arguments: 3);
          //                     }
          //                   },
          //                   splashColor: color.transparent,
          //                   highlightColor: color.transparent,
          //                   child: commonWidget.semiBoldText('No thanks', fontsize: 16.0),
          //                 ),
          //                 SizedBox(height: 12),
          //               ],
          //             ),
          //           ),
          //         ));
          //   },
          // );
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

  listRoamingCity_Api() async {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "list_roaming_city",
      method: MethodType.Post,
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) {
        print(response);
        roming_city_model data = roming_city_model.fromJson(response);
        romingCityList = data.info!;
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
