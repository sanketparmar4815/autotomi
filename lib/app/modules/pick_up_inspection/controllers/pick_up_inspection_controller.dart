import 'package:autotomi/app/Model/get_car_condition_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../pin/views/pin_view.dart';

class PickUpInspectionController extends GetxController {
  var flag, carID, bookingID, isLoading = false.obs, countyId;

  List<getCarCondition> getCarConditionList = [];

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
      carID = Get.arguments['car_id'];
      bookingID = Get.arguments['booking_id'];
      countyId = Get.arguments['county_id'];
    }
    print("hsgbmnbss");
    print(flag);
    print(countyId);
    print(bookingID);
    getCarCondition_APi();
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

  getCarCondition_APi() async {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "get_car_condition",
      method: MethodType.Post,
      params: {
        "car_id": carID,
        "booking_id": bookingID,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          get_car_condition_model data = get_car_condition_model.fromJson(response);
          getCarConditionList = data.info!;
        } else {
          print(response['Message']);
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

  sentReturnCar_Api() {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "sent_return_car_credentials",
      method: MethodType.Post,
      params: {
        "booking_id": bookingID,
        'country_id': countyId,
      },
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          Get.to(
            () => PinView(),
            arguments: {
              'flag': flag,
              'booking_id': bookingID,
            },
          );
          Toasty.showtoast(response['Message']);
        } else {
          print(response['Message']);
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

  sentEmployeeCredentials_Api() {
    print(countyId);
    print("countyId");
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "send_car_credentials",
      method: MethodType.Post,
      params: {
        "booking_id": bookingID,
        'country_id': countyId,
      },
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          Get.to(
            () => PinView(),
            arguments: {
              'flag': flag,
              'booking_id': bookingID,
            },
          );
          Toasty.showtoast(response['Message']);
        } else {
          print(response['Message']);
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
