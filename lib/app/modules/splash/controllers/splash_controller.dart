import 'package:autotomi/app/data/Notification_service.dart';
import 'package:autotomi/app/modules/bottombar/views/bottombar_view.dart';
import 'package:autotomi/app/modules/login/views/login_view.dart';
import 'package:autotomi/app/modules/onboarding/views/onboarding_view.dart';
import 'package:autotomi/app/modules/rentcar/views/rentcar_view.dart';
import 'package:autotomi/app/modules/support/views/support_view.dart';
import 'package:autotomi/common/PrefsKey.dart';
import 'package:autotomi/common/constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'dart:async';

class SplashController extends GetxController {
  Rout() {
    Onboarding = box.read(PrefsKey.Onboarding);
    userToken = box.read('user_token');
    print(Onboarding);
    print('userToken');
    print(userToken);
    Timer(
      Duration(seconds: 3),
      () => Onboarding != '1'
          ? Get.offAll(() => OnboardingView())
          : userToken == null
              ? Get.offAll(() => LoginView())
              : Get.offAll(
                  () => BottombarView(),
                ),
    );
  }

  var userToken, Onboarding;
  @override
  void onInit() {
    getDeviceToken();
    //listenNotification();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
    Rout();
    // getDeviceToken();
    // NotificationSetting();
    // AwesomeNotificationService();
    // update();
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

  // var notificationsSelect;
  // final notifications = FlutterLocalNotificationsPlugin();
  // AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher_round');
  // final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
  //   requestSoundPermission: true,
  //   requestBadgePermission: true,
  //   requestAlertPermission: true,
  //   defaultPresentAlert: true,
  //   defaultPresentBadge: true,
  //   defaultPresentSound: true,
  // );
  // Future<dynamic> onSelectNotification(payload) async {
  //   print("notification ib on Select $notificationsSelect");
  //   if (notificationsSelect == '1') {
  //     Get.offAll(() => BottombarView(), arguments: 3);
  //   } else if (notificationsSelect == '2') {
  //     Get.offAll(() => BottombarView(), arguments: 3);
  //   } else if (notificationsSelect == '3') {
  //     Get.offAll(() => RentcarView(), arguments: {'notification_flag': 5});
  //   } else if (notificationsSelect == '5') {
  //     Get.offAll(() => SupportView(), arguments: {'flag': 1, 'index': 1});
  //   }
  // }
  //
  // listenNotification() async {
  //   var initializationSettings = InitializationSettings(
  //     iOS: initializationSettingsIOS,
  //     android: initializationSettingsAndroid,
  //   );
  //   notifications.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //     print(message.data);
  //     print("message.data is here on Message listen");
  //     notificationsSelect = message.data['notification_type'];
  //     RemoteNotification? notification = message.notification;
  //     AppleNotification? ios = message.notification?.apple;
  //     if (notification != null && ios != null) {
  //       NotificationSettings settings = await messaging.requestPermission(
  //         alert: true,
  //         badge: true,
  //         provisional: true,
  //         sound: true,
  //       );
  //     }
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       notifications.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //           android: AndroidNotificationDetails('1', 'User Activity', icon: 'ic_launcher_round'),
  //           iOS: IOSNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true),
  //         ),
  //       );
  //     }
  //   });
  //
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
  //     print(message.data);
  //     print("message.data is here on Message OpenApp");
  //     if (message.data['notification_type'] == '1') {
  //       Get.offAll(() => BottombarView(), arguments: 3);
  //     } else if (message.data['notification_type'] == '2') {
  //       Get.offAll(() => BottombarView(), arguments: 3);
  //     } else if (message.data['notification_type'] == '3') {
  //       Get.offAll(() => RentcarView(), arguments: {'notification_flag': 5});
  //     } else if (message.data['notification_type'] == '5') {
  //       Get.offAll(() => SupportView(), arguments: {'flag': 1, 'index': 1});
  //     }
  //   });
  //
  //   FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
  //     if (message != null) {
  //       print(message.data);
  //       print("message.data is here only get initial listen");
  //       if (message.data['notification_type'] == '1') {
  //         Get.offAll(() => BottombarView(), arguments: 3);
  //       } else if (message.data['notification_type'] == '2') {
  //         Get.offAll(() => BottombarView(), arguments: 3);
  //       } else if (message.data['notification_type'] == '3') {
  //         Get.offAll(() => RentcarView(), arguments: {'notification_flag': 5});
  //       } else if (message.data['notification_type'] == '5') {
  //         Get.offAll(() => SupportView(), arguments: {'flag': 1, 'index': 1});
  //       }
  //     } else {
  //       // Rout();
  //     }
  //   });
  // }
}
