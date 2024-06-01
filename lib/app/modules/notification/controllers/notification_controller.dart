import 'package:autotomi/app/Model/notification_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/constant.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationController extends GetxController {
  List<notification> notificationList = [];
  @override
  void onInit() {
    notificationList_api();
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

  String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String formattedDateYest = DateFormat('dd/MM/yyyy').format(DateTime.now().subtract(Duration(days: 1)));

  var isLoading = false.obs;
  notificationList_api() async {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "list_notification",
      method: MethodType.Post,
      params: {},
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          notification_model data = notification_model.fromJson(response);
          notificationList = data.info!;
          update();
          // Toasty.showtoast(response['Message']);
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

  notificationRemove_api({notificationId, index}) async {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "click_notification",
      method: MethodType.Post,
      params: {"notification_id": notificationId},
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          notificationList_api();
          update();
          Toasty.showtoast("Notification Removed.");
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

  formatDateTime(var date) {
    var dateFormat = DateFormat("HH");
    var utcDate = dateFormat.format(DateTime.parse(date.toString()));
    String createdDate = dateFormat.parse(utcDate, true).toLocal().toString();
    //  localeUTCTimeChange = dateFormat.format(DateTime.parse(createdDate));
    return createdDate;
  }

  formatDate(var date) {
    var dateFormat = DateFormat("dd/MM/yy");
    var utcDate = dateFormat.format(DateTime.parse(date.toString()));
    String createdDate = dateFormat.parse(utcDate, true).toLocal().toString();
    // localeUTCTimeChange = dateFormat.format(DateTime.parse(createdDate));
    return createdDate;
  }
}

// import 'package:autotomi/app/Model/notification_model.dart';
// import 'package:autotomi/app/data/NetworkClint.dart';
// import 'package:autotomi/common/asset.dart';
// import 'package:autotomi/common/constant.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class NotificationController extends GetxController {
//   List firstList = [
//     {
//       "image": assetsUrl.profileImage,
//       "text": "Please Complete Your Profile",
//     },
//     {
//       "image": assetsUrl.bmwCarImage,
//       "text": "Book Your Trip with BMW M2",
//     },
//     {
//       "image": assetsUrl.mercidesImage,
//       "text": "Your booking is Completed",
//     },
//   ];
//
//   List secundList = [
//     {
//       "image": assetsUrl.hondaCarImage,
//       "text": "City Honda is available now",
//     },
//     {
//       "image": assetsUrl.bmwCarImage,
//       "text": "5 people have now booked your car, make payment now to reserve this car for yourself",
//     },
//     {
//       "image": assetsUrl.mercidesImage,
//       "text": "Sorry, the car you booked has now been reserved by someone else, please check our fleet of cars to book another one.",
//     },
//   ];
//   List<notification> notificationList = [];
//   @override
//   void onInit() {
//     notificationList_api();
//     super.onInit();
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
//
//   String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
//   String formattedDateYest = DateFormat('dd/MM/yyyy').format(DateTime.now().subtract(Duration(days: 1)));
//
//   var isLoading = false.obs;
//   notificationList_api() async {
//     isLoading.value = true;
//     return NetworkClient.getInstance.callApi(
//       baseUrl: BaseUrl + "list_notification",
//       method: MethodType.Post,
//       params: {},
//       headers: NetworkClient.getInstance.getAuthHeaders(),
//       successCallback: (response, message) {
//         print(response);
//         if (response['Status'] == 1) {
//           notification_model data = notification_model.fromJson(response);
//           notificationList = data.info!;
//           update();
//           // Toasty.showtoast(response['Message']);
//         } else {
//           Toasty.showtoast(response['Message']);
//         }
//         isLoading.value = false;
//       },
//       failureCallback: (message, statusCode) {
//         print(message.toString());
//         print(statusCode);
//         isLoading.value = false;
//       },
//       timeOutCallback: () {
//         Toasty.showtoast('something is wrong please try again');
//         isLoading.value = false;
//       },
//     );
//   }
//
//   formatDateTime(var date) {
//     var dateFormat = DateFormat("HH");
//     var utcDate = dateFormat.format(DateTime.parse(date.toString()));
//     String createdDate = dateFormat.parse(utcDate, true).toLocal().toString();
//     //  localeUTCTimeChange = dateFormat.format(DateTime.parse(createdDate));
//     return createdDate;
//   }
//
//   formatDate(var date) {
//     var dateFormat = DateFormat("dd/MM/yy");
//     var utcDate = dateFormat.format(DateTime.parse(date.toString()));
//     String createdDate = dateFormat.parse(utcDate, true).toLocal().toString();
//     // localeUTCTimeChange = dateFormat.format(DateTime.parse(createdDate));
//     return createdDate;
//   }
// }
