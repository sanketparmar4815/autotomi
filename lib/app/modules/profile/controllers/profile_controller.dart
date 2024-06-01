import 'package:autotomi/app/Model/edit_profile_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/home/views/home_view.dart';
import 'package:autotomi/app/modules/login/views/login_view.dart';
import 'package:autotomi/common/PrefsKey.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileController extends GetxController {
  List basicMemberList = [
    'Upgrade Your Profile',
    'Edit Profile',
    'Completed Ride',
    'Change Password',
    'Contact Us',
    'Policies',
    'Terms of use',
    'Delete Account',
  ];
  List basicMemberList1 = [
    'Upgrade Your Profile',
    'Edit Profile',
    'Completed Ride',
    'Contact Us',
    'Policies',
    'Terms of use',
    'Delete Account',
  ];

  var isLoading = false.obs, profilePic, firstName, lastName, countryCode, phoneNumber;

  var url = 'https://www.google.com/';
  @override
  void onInit() {
    print(box.read('is_profile'));
    print('xc.khcxjkxkjcxgjk;s');
    editProfile_Api();
    getDeviceId();
    getData();
    commonStatusBarUpdate(
      statusBarColor: Colors.transparent,
    );

    super.onInit();
  }

  getData() {
    profilePic = box.read(PrefsKey.profilePic);
    firstName = box.read(PrefsKey.firstName);
    lastName = box.read(PrefsKey.lastName);
    countryCode = box.read('country_code');
    phoneNumber = box.read(PrefsKey.phoneNumber);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  logOut_Api() {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "log_out",
      method: MethodType.Post,
      params: {
        "device_id": device_id,
      },
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) async {
        if (response['Status'] == 1) {
          print("resend Api Response :-- ${response}");
          isReturnCar = 0;
          box.remove('user_token');
          box.remove('is_profile');
          box.remove('country_visiting');
          box.remove('user_id');
          box.remove('per_day_price');
          box.remove('per_week_price');
          box.remove('country_code');
          box.remove('country_visiting');
          box.remove('country_code');
          box.remove('save_review');
          box.remove('country_id');
          box.remove('country_visiting_code');
          box.remove(PrefsKey.countryCode);
          box.remove(PrefsKey.profilePic);
          box.remove(PrefsKey.firstName);
          box.remove(PrefsKey.lastName);
          box.remove(PrefsKey.phoneNumber);
          box.remove(PrefsKey.login_type);
          signOutGoogle();
          isLoading.value = false;
          Get.offAll(LoginView());
          Toasty.showtoast(response['Message']);
          update();
        } else {
          isLoading.value = false;
          Toasty.showtoast(response['Message']);
        }
      },
      failureCallback: (status, message) {
        isLoading.value = false;
        print("failureCallback  status :---  ${status}");
        print("failureCallback  message :---  ${message}");
      },
      timeOutCallback: () {
        Toasty.showtoast('something is wrong please try again');
        isLoading.value = false;
      },
    );
  }

  deleteAccount_Api() {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "delete_user_account",
      method: MethodType.Post,
      params: {},
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) async {
        if (response['Status'] == 1) {
          print("resend Api Response :-- ${response}");
          isReturnCar = 0;
          box.remove('user_token');
          box.remove('is_profile');
          box.remove('country_visiting');
          box.remove('user_id');
          box.remove('per_day_price');
          box.remove('per_week_price');
          box.remove('country_code');
          box.remove('country_visiting');
          box.remove('country_code');
          box.remove('save_review');
          box.remove('country_id');
          box.remove('country_visiting_code');
          box.remove(PrefsKey.countryCode);
          box.remove(PrefsKey.profilePic);
          box.remove(PrefsKey.firstName);
          box.remove(PrefsKey.lastName);
          box.remove(PrefsKey.phoneNumber);
          box.remove(PrefsKey.login_type);
          signOutGoogle();
          isLoading.value = false;
          Get.offAll(LoginView());
          Toasty.showtoast(response['Message']);
          update();
        } else {
          isLoading.value = false;
          Toasty.showtoast(response['Message']);
        }
      },
      failureCallback: (status, message) {
        isLoading.value = false;
        print("failureCallback  status :---  ${status}");
        print("failureCallback  message :---  ${message}");
      },
      timeOutCallback: () {
        Toasty.showtoast('something is wrong please try again');
        isLoading.value = false;
      },
    );
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
        if (response['Status'] == 1) {
          edit_profile_model data = edit_profile_model.fromJson(response);
          box.write('is_profile', data.info!.isProfile);
        } else {
          isLoading.value = false;
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

  final GoogleSignIn googleSignIn = GoogleSignIn();
  signOutGoogle() async {
    await googleSignIn.signOut();
    print("Google Account Signed Out");
  }
}
