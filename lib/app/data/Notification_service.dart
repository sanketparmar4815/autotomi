import 'dart:developer';
import 'dart:io';
import 'package:autotomi/app/modules/bottombar/views/bottombar_view.dart';
import 'package:autotomi/app/modules/rentcar/views/rentcar_view.dart';
import 'package:autotomi/app/modules/support/views/support_view.dart';
import 'package:autotomi/common/constant.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final notifications = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher_round');
  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
    defaultPresentAlert: true,
    defaultPresentBadge: true,
    defaultPresentSound: true,
  );

  var notificationType;
  var boardId;
  listenNotification() async {
    var initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    notifications.initialize(initializationSettings, onSelectNotification: onSelectNotification);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(message.data);
      print("message.data is here");
      notificationType = message.data['notification_type'];
      boardId = message.data['board_id'];
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
            android: AndroidNotificationDetails('1', 'User Activity', icon: 'ic_launcher_round'),
            iOS: IOSNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print(message.data);
      print("message.data is here");
      if (message.data['notification_type'] == '1') {
        Get.offAll(() => BottombarView());
      } else if (message.data['notification_type'] == '2') {
        //  Get.offAll(() => HomedetailsView(), arguments: {"flag": 1, "board_id": message.data['board_id'], "rouFlag": 1});
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
      if (message != null) {
        if (message.data['notification_type'] == '1') {
          Get.offAll(() => BottombarView());
        } else if (message.data['notification_type'] == '2') {
          // Get.offAll(() => HomedetailsView(), arguments: {"flag": 1, "board_id": message.data['board_id'], "rouFlag": 1});
        }
      } else {}
    });
  }

  Future<dynamic> onSelectNotification(payload) async {
    if (notificationType == '1') {
      Get.offAll(() => BottombarView());
    } else if (notificationType == '2') {
      // Get.offAll(
      //       () => HomedetailsView(),
      //   arguments: {"flag": 1, "board_id": boardId, "rouFlag": 1},
      // );
    }
  }
}

// class NotificationSetting {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   //------ request a notification permission -------
//   void requestNotificationPermission() async {
//     log('request Notifications Permission');
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );
//     PermissionStatus status = await Permission.notification.request();
//     log('----- notification Permissions ------');
//     log('${status}');
//     if (status == PermissionStatus.granted) {
//     } else if (status == PermissionStatus.denied) {
//       bool showRationale = await Permission.storage.shouldShowRequestRationale;
//       if (!showRationale) {
//         // await openAppSettings();
//       }
//     } else if (status == PermissionStatus.permanentlyDenied) {
//       // await openAppSettings();
//     } else {}
//   }
//
//   Future<void> forgroundMessage() async {
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
// //------ firebase init ------
//   void firebaseInit() {
//     FirebaseMessaging.onMessage.listen((message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification!.android;
//       if (kDebugMode) {
//         print("notifications title:${notification!.title}");
//         print("notifications this is rutik body:${notification.body}");
//         print("notifications data:${notification}");
//         print('data:${message.data.toString()}');
//       }
//
//       if (Platform.isIOS) {
//         AwesomeNotificationService.initializeNotification();
//         showNotification(message);
//       }
//       if (Platform.isAndroid) {
//         AwesomeNotificationService.initializeNotification();
//         showNotification(message);
//       }
//     });
//   }
//
//   // ------ pop visible notification ------
//   Future<void> showNotification(RemoteMessage message) async {
//     print("show notifi");
//     log('show notification');
//     log(message.notification!.title.toString());
//     log(message.notification!.body.toString());
//     Map<String, dynamic> originalMap = message.data;
//
//     Map<String, String>? convertedMap = {};
//
//     originalMap.forEach((key, value) {
//       if (value == null) {
//         convertedMap[key] = '';
//       } else {
//         convertedMap[key] = value.toString();
//       }
//     });
//
//     await AwesomeNotificationService.showNotification(
//       title: message.notification!.title.toString(),
//       body: message.notification!.body.toString(),
//       notificationLayout: NotificationLayout.Default,
//       payload: convertedMap,
//     );
//   }
// }

//------ awesome notification services------
// class AwesomeNotificationService {
//   static Future<void> initializeNotification() async {
//     print("iniLixe noti");
//     await AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           channelGroupKey: 'high_importance_channel',
//           channelKey: 'high_importance_channel',
//           channelName: 'Basic notifications',
//           channelDescription: 'Notification channel for basic tests',
//           defaultColor: Colors.blueAccent,
//           ledColor: Colors.white,
//           importance: NotificationImportance.Max,
//           channelShowBadge: true,
//           onlyAlertOnce: true,
//           playSound: true,
//           criticalAlerts: true,
//         )
//       ],
//       channelGroups: [
//         NotificationChannelGroup(
//           channelGroupName: 'Group 1',
//           channelGroupKey: 'high_importance_channel_group',
//         )
//       ],
//       debug: true,
//     );
//
//     await AwesomeNotifications().isNotificationAllowed().then(
//       (isAllowed) async {
//         if (!isAllowed) {
//           await AwesomeNotifications().requestPermissionToSendNotifications();
//         }
//       },
//     );
//
//     await AwesomeNotifications().setListeners(
//       onActionReceivedMethod: onActionReceivedMethod,
//       onNotificationCreatedMethod: onNotificationCreatedMethod,
//       onNotificationDisplayedMethod: onNotificationDisplayedMethod,
//       onDismissActionReceivedMethod: onDismissActionReceivedMethod,
//     );
//   }
//
//   static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
//     debugPrint('onNotificationCreatedMethod');
//   }
//
//   static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
//     debugPrint('onNotificationDisplayedMethod');
//   }
//
//   static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
//     debugPrint('onDismissActionReceivedMethod');
//   }
//
//   static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
//     debugPrint('onActionReceivedMethod');
//     print('------------- on tap-----------------');
//     print(receivedAction.payload.toString());
//     log('${receivedAction.payload!['notification_type'].runtimeType}');
//
//     if (receivedAction.payload!['notification_type'] == '1') {
//       Get.offAll(() => BottombarView(), arguments: 3);
//       print("notification_type 1 === > ${receivedAction.payload!['notification_type']}");
//     } else if (receivedAction.payload!['notification_type'] == '3') {
//       Get.offAll(() => BottombarView(), arguments: 3);
//       print("notification_type 3  === > ${receivedAction.payload!['notification_type']}");
//     } else if (receivedAction.payload!['notification_type'] == '5') {
//       Get.offAll(() => SupportView(), arguments: {'flag': 1, 'index': 1});
//       print("notification_type is  5 === > ${receivedAction.payload!['notification_type']}");
//     }
//   }
//
//   static Future<void> showNotification({
//     required final String title,
//     required final String body,
//     final String? summary,
//     final Map<String, String>? payload,
//     final ActionType actionType = ActionType.Default,
//     final NotificationLayout notificationLayout = NotificationLayout.Default,
//     final NotificationCategory? category,
//     final String? bigPicture,
//     final List<NotificationActionButton>? actionButtons,
//     final bool scheduled = false,
//     final int? interval = 1,
//   }) async {
//     assert(!scheduled || (scheduled && interval != null));
//
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 0,
//         channelKey: 'high_importance_channel',
//         title: title,
//         body: body,
//         actionType: actionType,
//         notificationLayout: notificationLayout,
//         summary: summary,
//         category: category,
//         payload: payload,
//         bigPicture: bigPicture,
//       ),
//       actionButtons: actionButtons,
//       schedule: scheduled
//           ? NotificationInterval(
//               interval: interval!,
//               timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//               preciseAlarm: true,
//             )
//           : null,
//     );
//   }
// }
