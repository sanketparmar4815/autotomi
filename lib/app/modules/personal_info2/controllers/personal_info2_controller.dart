import '../../personal_info4/views/personal_info4_view.dart';
import 'package:autotomi/app/Model/roaming_city_model.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class PersonalInfo2Controller extends GetxController {
  TextEditingController guarantor = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  var isLoading = false.obs;
  RxBool isChecked = true.obs;
  List selectedIndices = [].obs;
  List<romingCity> romingCityList = [];

  List roamingCityID = [];

  //  List roamingCitiesList = [
  //   'Nigeria',
  //   'Lagos',
  //   'Ibadan',
  //   'Kano',
  //   'Port Harcourt',
  //   'Osogbo',
  //   'Minna',
  // ];

  var flag;
  var ukCountryCode, ukPhoneNumber, ukAddress, proofOfId, proofIdImage, proofOfResidence, proofOfResidenceImage, proofOfUkAddress, proofOfUkAddressImage;
  var nigerianCountryCode, nigerianPhoneNumber, nigerianAddress, proofOfAfricanAddress, proofOfAfricanAddressImage, drivingLincens, drivingLincensImage;

  @override
  void onInit() {
    listRoamingCity_Api();

    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
      ukCountryCode = Get.arguments['ukCountryCode'];
      ukPhoneNumber = Get.arguments['ukPhoneNumber'];
      ukAddress = Get.arguments['ukAddress'];
      proofOfId = Get.arguments['proofID'];
      proofIdImage = Get.arguments['proofIDImage'];
      proofOfResidence = Get.arguments['proofOfResidece'];
      proofOfResidenceImage = Get.arguments['proofOfResideceImage'];
      proofOfUkAddress = Get.arguments['proofOfUkAddress'];
      proofOfUkAddressImage = Get.arguments['proofOfUkAddressImage'];

      nigerianCountryCode = Get.arguments['nigerianCountryCode'];
      nigerianPhoneNumber = Get.arguments['nigerianPhoneNumber'];
      nigerianAddress = Get.arguments['nigerianAddress'];
      proofOfAfricanAddress = Get.arguments['proofOfAfricanAddress'];
      proofOfAfricanAddressImage = Get.arguments['proofOfAfricanAddressImage'];
      drivingLincens = Get.arguments['drivingLincens'];
      drivingLincensImage = Get.arguments['drivingLincensImage'];

      print(ukCountryCode);
      print(ukPhoneNumber);
      print(ukAddress);
      print(proofOfId);
      print(proofIdImage);
      print(proofOfResidence);
      print(proofOfResidenceImage);
      print(proofOfUkAddress);
      print(proofOfUkAddressImage);
      print(nigerianCountryCode);
      print(nigerianPhoneNumber);
      print(nigerianAddress);
      print(proofOfAfricanAddress);
      print(proofOfAfricanAddressImage);
      print(drivingLincens);
      print(drivingLincensImage);
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
        'residence_country_code': ukCountryCode,
        'residence_phone_number': ukPhoneNumber,
        'residence_address': ukAddress,
        'id_proof': proofOfId,
        'id_proof_image': proofIdImage,
        'residence_proof': proofOfResidence,
        'residence_proof_image': proofOfResidenceImage,
        'residence_address_proof_image': proofOfUkAddressImage,
        'residence_address_proof': proofOfUkAddress,
        'home_country_code': nigerianCountryCode,
        'home_phone_number': nigerianPhoneNumber,
        'home_address': nigerianAddress,
        'home_address_proof': proofOfAfricanAddress,
        'home_address_proof_image': proofOfAfricanAddressImage,
        'eligibility_drive_in': drivingLincens,
        'license_proof_image': drivingLincensImage,
        'guarantor_name': guarantor.text,
        'gruarantor_email_id': email.text,
        'gruarantor_address': address.text,
        'city_id': selectedIndices.join(","),
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
