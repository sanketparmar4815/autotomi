import 'package:autotomi/app/data/Notification_service.dart';
import 'package:autotomi/app/modules/bottombar/views/bottombar_view.dart';
import 'package:autotomi/app/modules/support/views/support_view.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    criticalAlert: true,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // NotificationSetting().firebaseInit();
  // NotificationSetting().requestNotificationPermission();
  // NotificationSetting().forgroundMessage();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Stripe.publishableKey = "pk_test_51NYexcIXNJMZ1R8QOD6qIF4mDZ1xKfcSzxMAZaIGKS9qxj13Jm9Daxm2k4MoyDtsr9O14ykBhYmGtq5v4sXHOlp100a68usjme";
  await Stripe.instance.applySettings();
  Stripe.merchantIdentifier = 'any string works';
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  print("firebaseMessagingBackgroundHandler in backgroun rutik");
  print(message);
  print('message  data is here 111${message.data}');
  print('messagedata is here 111 ${message.messageId}');

  // await AwesomeNotifications().createNotificationFromJsonData(message.data);
  // await NotificationSetting().showNotification(message);
  // await AwesomeNotificationService.initializeNotification();

  // if (message.data['notification_type'] == '1') {
  //   Get.offAll(() => BottombarView(), arguments: 3);
  //   print("notification_type 1 === > ${message.data['notification_type']}");
  // } else if (message.data['notification_type'] == '3') {
  //   Get.offAll(() => BottombarView(), arguments: 3);
  //   print("notification_type 3  === > ${message.data['notification_type']}");
  // } else if (message.data['notification_type'] == '5') {
  //   Get.offAll(() => SupportView(), arguments: {'flag': 1, 'index': 1});
  //   print("notification_type is  5 === > ${message.data['notification_type']}");
  // }
}
