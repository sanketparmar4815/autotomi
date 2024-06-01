import 'package:autotomi/app/Model/ger_car_details_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RentcardetailsController extends GetxController {
  var flag, carID, isLoading = false.obs, userID;
  Info? info;

  willPopScope() {
    Get.back(
      result: 1,
    );
  }

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
      carID = Get.arguments['car_id'];
      print('flag=====>');
      print(flag);
      print("get ID");
      print(carID);
    }

    userID = box.read('user_id');
    print('userID');
    print(userID);

    await getCarDetails_Api();

    Future.delayed(Duration(milliseconds: 500), () {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
      );
    });
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

  getCarDetails_Api() {
    print("nemil");
    print(carID);
    isLoading.value = true;

    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "get_car_details",
      method: MethodType.Post,
      params: {
        "car_id": carID,
        'user_id': userID,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          get_car_details_model data = get_car_details_model.fromJson(response);
          info = data.info!;
          box.write('per_day_price', data.info!.pricePerDay);
          box.write('per_week_price', data.info!.pricePerWeek);
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

  likeUnlikeCar_Api() {
    //isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "like_unlike_car",
      method: MethodType.Post,
      params: {
        'car_id': carID,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          Toasty.showtoast(response['Message']);
        } else {
          Toasty.showtoast(response['Message']);
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
