import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

HW hw = HW();

class HW {
  var height = Get.height;
  var width = Get.width;
  var paddingwidth = Get.width * 0.065104166666667;
}

final box = GetStorage();

colors color = colors();

class Toasty {
  static showtoast(String message, {int second = 5}) {
    Fluttertoast.showToast(
      timeInSecForIosWeb: second,
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: Colors.black,
    );
  }
}

class colors {
  //Color appColor = Color(0xff41975D);
  Color appColor = Color(0xff166534);
  Color black = Colors.black;
  Color white = Colors.white;
  Color grey = Colors.grey;
  Color light_grey = Color(0xffF7F8F9);
  Color fillColor = Color(0xffF8F8F8);
  Color appGreyColor = Color(0xff8391A1);
  Color primaryColor = Color(0xff35C2C1);
  Color transparent = Colors.transparent;
  Color backgound_color = Color(0xffafe5d2);
  Color red_color = Color(0xffF14336);
}

Future commonStatusBarUpdate({Color? statusBarColor, Brightness? statusBarIconBrightness, Brightness? statusBarBrightness}) async {
  Future.delayed(Duration(milliseconds: 10), () {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: statusBarIconBrightness ?? Brightness.dark,
        statusBarColor: statusBarColor ?? Colors.transparent,
        statusBarBrightness: statusBarBrightness ?? Brightness.light,
      ),
    );
  });
}

final customerIndicator = SpinKitCircle(color: color.appColor, size: 50.0);

bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}

//region Get DeviceToken
FirebaseMessaging messaging = FirebaseMessaging.instance;
var device_token;

getDeviceToken() async {
  print('device_token');
  device_token = await messaging.getToken(vapidKey: "KP5PSBMSCF");
  print('Device Token :-> ${device_token}');
}
//endregion

//region Get DeviceId
var device_id;
var device_type;
getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    device_type = 2;
    var iosDeviceInfo = await deviceInfo.iosInfo;
    device_id = iosDeviceInfo.identifierForVendor;
    print('Device ID: ' + device_id);
  } else {
    device_type = 1;
    var androidDeviceInfo = await deviceInfo.androidInfo;
    device_id = androidDeviceInfo.id;
    print('Device ID: ' + device_id);
  }
}
