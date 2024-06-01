import 'package:autotomi/app/Model/login_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/bottombar/views/bottombar_view.dart';
import 'package:autotomi/app/modules/create_account/views/create_account_view.dart';
import 'package:autotomi/app/modules/verification/views/verification_view.dart';
import 'package:autotomi/common/PrefsKey.dart';
import 'package:autotomi/common/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignUpController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  var isObSecure = true.obs, isLoading = false.obs;
  @override
  void onInit() {
    getDeviceToken();
    getDeviceId();

    print(device_id);
    print(device_type);
    print(device_token);
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

  signUp_Api() {
    print("device token is here $device_token");
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "sign_up",
      method: MethodType.Post,
      params: {
        'email_id': email.text,
        'password': password.text,
        'device_id': device_id,
        'device_type': device_type,
        'device_token': device_token,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          Get.to(() => VerificationView(), arguments: {
            'flag': 0,
            'emailID': email.text,
            'isLogin': 0,
          });

          Toasty.showtoast('OTP sent to your email');
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

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult = await firebaseAuth.signInWithCredential(credential);
    final User? user = authResult.user;

    if (user != null) {
      loginByThirdParty_Api(emailID: user.email, thirdPartyID: user.uid, LoginType: 1);
      print('sign In With Google succeeded: $user');
      return '$user';
    }
  }

  signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    loginByThirdParty_Api(emailID: credential.email, thirdPartyID: credential.userIdentifier, LoginType: 2);
  }

  loginByThirdParty_Api({emailID, thirdPartyID, LoginType}) {
    print("device token is here $device_token");
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "login_by_thirdparty",
      method: MethodType.Post,
      params: {
        'email_id': emailID,
        'login_type': LoginType,
        'device_type': device_type,
        'device_id': device_id,
        'device_token': device_token,
        'thirdparty_id': thirdPartyID,
      },
      successCallback: (response, message) {
        print(response);
        login_model data = login_model.fromJson(response);
        if (response['Status'] == 1) {
          isLoading.value = false;

          if (data.info!.isAccountSetup == 0) {
            Get.to(() => CreateAccountView(), arguments: {'userToken': data.userToken});
          } else {
            box.write('user_token', data.userToken);
            box.write('is_profile', data.info!.isProfile);
            box.write('user_id', response['info']['user_id']);
            box.write('country_visiting', data.info!.homeCountry);
            box.write(PrefsKey.profilePic, data.info!.profilePic);
            box.write(PrefsKey.countryCode, data.info!.countryCode);
            box.write(PrefsKey.phoneNumber, data.info!.phoneNumber);
            box.write(PrefsKey.firstName, data.info!.firstName);
            box.write(PrefsKey.lastName, data.info!.lastName);
            box.write(PrefsKey.login_type, data.info!.loginType);
            Toasty.showtoast(response['Message']);
            Get.offAll(() => BottombarView());
          }
          Toasty.showtoast(response['Message']);
        } else {
          signOutGoogle();
          isLoading.value = false;
          Toasty.showtoast(response['Message']);
        }
      },
      failureCallback: (message, statusCode) {
        signOutGoogle();
        print(message.toString());
        print(statusCode);
        isLoading.value = false;
      },
      timeOutCallback: () {
        signOutGoogle();
        Toasty.showtoast('something is wrong please try again');
        isLoading.value = false;
      },
    );
  }

  signOutGoogle() async {
    await googleSignIn.signOut();
    print("Google Account Signed Out");
  }
}
