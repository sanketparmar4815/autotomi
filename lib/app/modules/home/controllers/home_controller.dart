import 'package:autotomi/app/Model/edit_profile_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/PrefsKey.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/asset.dart';

class HomeController extends GetxController {
  List dashboardList = [
    {
      "name": stringsUtils.RentaCar,
      "image": assetsUrl.rentCarImage,
    },
    {
      "name": stringsUtils.ReturnaCar,
      "image": assetsUrl.returnCarImage,
    },
    {
      "name": stringsUtils.MyCar,
      "image": assetsUrl.mycarImage,
    },
    {
      "name": stringsUtils.Support,
      "image": assetsUrl.supportImage,
    },
    {
      "name": stringsUtils.HowitsWorks,
      "image": assetsUrl.howtsWorking,
    }
  ];
  var profilePic, firstName, lastName, countryCode, phoneNumber, isLoading = false.obs;
  @override
  void onInit() {
    box.read('user_id') == 0 ? SizedBox() : editProfile_Api();
    getData();
    super.onInit();
  }

  var userID;
  getData() {
    userID = box.read('user_id');
    profilePic = box.read(PrefsKey.profilePic);
    firstName = box.read(PrefsKey.firstName);
    lastName = box.read(PrefsKey.lastName);
    countryCode = box.read('country_code');
    phoneNumber = box.read(PrefsKey.phoneNumber);
    print(profilePic);
    print(firstName);
    print(lastName);
    print(countryCode);
    print(phoneNumber);
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
      params: {},
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) async {
        print(response);
        print('response');
        if (response['Status'] == 1) {
          edit_profile_model data = edit_profile_model.fromJson(response);
          box.write('is_profile', data.info!.isProfile);
          box.write('is_profile_veri', data.info!.isProfileVerified);
          countryCode = data.info!.countryCode;
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
