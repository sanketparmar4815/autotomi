import 'package:autotomi/app/data/Notification_service.dart';
import 'package:autotomi/app/modules/bottombar/views/bottombar_view.dart';
import 'package:autotomi/app/modules/favoritecar/views/favoritecar_view.dart';
import 'package:autotomi/app/modules/home/views/home_view.dart';
import 'package:autotomi/app/modules/mycar/views/mycar_view.dart';
import 'package:autotomi/app/modules/profile/views/profile_view.dart';
import 'package:autotomi/app/modules/rentcar/views/rentcar_view.dart';
import 'package:autotomi/app/modules/support/views/support_view.dart';
import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class BottombarController extends GetxController {
  var pageSelected = 0.obs;
  RxList<Widget> bottomBarWidget = <Widget>[
    HomeView(),
    MycarView(),
    FavoritecarView(),
    ProfileView(),
  ].obs;

  List bottomItems = [
    assetsUrl.bottomHome,
    assetsUrl.bottomCarIcon,
    assetsUrl.bottomFavriteicon,
    assetsUrl.bottomProfileIcon,
  ];

  @override
  void onInit() {
    if (Get.arguments != null) {
      print("Get argument is ${Get.arguments}");
      pageSelected.value = Get.arguments;
    }
    getDeviceToken();
    listenNotification();
    // NotificationService();
    // AwesomeNotificationService();

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

  var notificationsSelect;
  final notifications = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher_foreground');
  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
    defaultPresentAlert: true,
    defaultPresentBadge: true,
    defaultPresentSound: true,
  );
  Future<dynamic> onSelectNotification(payload) async {
    print("notification ib on Select $notificationsSelect");
    if (notificationsSelect == '1') {
      Get.offAll(() => BottombarView(), arguments: 3);
    } else if (notificationsSelect == '2') {
      Get.offAll(() => BottombarView(), arguments: 3);
    } else if (notificationsSelect == '3') {
      Get.offAll(() => RentcarView(), arguments: {'notification_flag': 5});
    } else if (notificationsSelect == '5') {
      Get.to(() => SupportView(), arguments: {'notification_flag': 4, 'index': 1});
    }
  }

  listenNotification() async {
    var initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    notifications.initialize(initializationSettings, onSelectNotification: onSelectNotification);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(message.data);
      print("message.data is here on Message listen");
      notificationsSelect = message.data['notification_type'];
      RemoteNotification? notification = message.notification;
      AppleNotification? ios = message.notification?.apple;
      if (notification != null && ios != null) {
        NotificationSettings settings = await messaging.requestPermission(
          alert: true,
          badge: true,
          provisional: true,
          sound: true,
        );
      }
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        notifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails('1', 'User Activity', icon: 'ic_launcher_foreground'),
            iOS: IOSNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print(message.data);
      print("message.data is here on Message OpenApp");
      if (message.data['notification_type'] == '1') {
        Get.offAll(() => BottombarView(), arguments: 3);
      } else if (message.data['notification_type'] == '2') {
        Get.offAll(() => BottombarView(), arguments: 3);
      } else if (message.data['notification_type'] == '3') {
        Get.offAll(() => RentcarView(), arguments: {'notification_flag': 5});
      } else if (message.data['notification_type'] == '5') {
        Get.to(() => SupportView(), arguments: {'notification_flag': 4, 'index': 1});
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
      if (message != null) {
        print(message.data);
        print("message.data is here only get initial listen");
        if (message.data['notification_type'] == '1') {
          Get.offAll(() => BottombarView(), arguments: 3);
        } else if (message.data['notification_type'] == '2') {
          Get.offAll(() => BottombarView(), arguments: 3);
        } else if (message.data['notification_type'] == '3') {
          Get.offAll(() => RentcarView(), arguments: {'notification_flag': 5});
        } else if (message.data['notification_type'] == '5') {
          Get.to(() => SupportView(), arguments: {'notification_flag': 4, 'index': 1});
        }
      } else {
        // Rout();
      }
    });
  }
}
