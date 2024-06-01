import 'dart:math';

import 'package:autotomi/app/Model/availbale_car_model.dart';
import 'package:autotomi/app/Model/list_car_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/bottombar/views/bottombar_view.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RentcarController extends GetxController {
  List selectRentCar = [];

  List<car> carList = [];
  List<availbaleCar> availabaleCarList = [];
  var flag, isLoading = false.obs, page = 1, countryId, countryName, countryName1;
  var hasNextPage = true.obs, selectedCountry;
  var isLoadMoreRunning = false.obs, notificationFlag;
  ScrollController? scroll_controller;

  @override
  Future<void> onInit() async {
    countryId = box.read("user_id") != 0 ? box.read('country_id') : 0;
    selectedCountry = box.read('country_id');
    countryName = box.read('country_visiting');
    print(box.read('country_visiting'));
    print(countryId);
    print(countryName);
    print("ruti9k");
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
      //selectRentCar = Get.arguments['categoryId'];
      notificationFlag = Get.arguments['notification_flag'];
      // demoList = Get.arguments['categoryId'];

      print(flag);
    }
    print(selectRentCar);
    print('flag----=---------> $flag');
    print(countryId);
    print(box.read('user_id'));
    scroll_controller = ScrollController()..addListener(loadMore);

    await listCar_Api();
    await list_country_Api();
    await availableCar_Api(flag: 1);

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

  availableCar_Api({LoadMore, flag}) {
    if (LoadMore != 1) {
      isLoading.value = true;
    }
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "list_home_screen_data",
      method: MethodType.Post,
      params: {
        "page_no": page,
        "user_id": box.read('user_id'),
        "country_id": box.read('user_id') != 0
            ? countryId
            : flag == 1
                ? 0
                : countryId,
        "category_id": selectRentCar.isEmpty ? 0 : selectRentCar.join(","),
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          availabale_car_model data = availabale_car_model.fromJson(response);
          if (LoadMore != 1) {
            availabaleCarList = data.info!;
            isLoading.value = false;

            update();
          } else {
            isLoadMoreRunning.value = false;
            if (data.info!.length > 0) {
              availabaleCarList.addAll(data.info!);
              isLoading.value = false;
            } else {
              hasNextPage.value = false;
            }
            update();
          }
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

  Future<dynamic> loadMore() async {
    if (hasNextPage.value == true && isLoading.value == false && isLoadMoreRunning.value == false && scroll_controller!.offset >= scroll_controller!.position.maxScrollExtent) {
      isLoadMoreRunning.value = true;
      page++;
      await availableCar_Api(LoadMore: 1);
    }
  }

  listCar_Api() {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "list_category",
      method: MethodType.Post,
      params: {},
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          list_car_model data = list_car_model.fromJson(response);
          carList = data.info!;
          if (flag != 0) {
            for (var i = 0; i < carList.length; i++) {
              selectRentCar.add(carList[i].categoryId);
            }
          }
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

  likeUnlikeCar_Api({carID}) {
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

  RxList countryList = [].obs;

  list_country_Api() async {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "list_country",
      method: MethodType.Post,
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          countryList.value = response['info'];

          update();
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

  onWillPopScope() {
    if (notificationFlag == 5) {
      Get.offAll(BottombarView(), arguments: 0);
    } else {
      Get.back();
    }
  }
}
