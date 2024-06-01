import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/constant.dart';
import '../../../Model/list_my_car_model.dart';
import '../../../data/NetworkClint.dart';

class CompletedRideController extends GetxController {
  var isLoading = false.obs;
  @override
  void onInit() {
    scroll_controller = ScrollController()..addListener(loadMore);
    completedRide_Api();
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

  List<listMyCar> listMyCarList = [];
  var isLoadMoreRunning = false.obs, hasNextPage = true.obs;
  var page = 1;
  ScrollController? scroll_controller;

  completedRide_Api({LoadMore}) {
    if (LoadMore != 1) {
      isLoading.value = true;
    }
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "list_my_car",
      method: MethodType.Post,
      params: {
        "page_no": page,
        "booking_status": 4,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          list_my_car_model data = list_my_car_model.fromJson(response);
          if (LoadMore != 1) {
            listMyCarList = data.info!;
            isLoading.value = false;
            update();
          } else {
            isLoadMoreRunning.value = false;
            if (data.info!.length > 0) {
              listMyCarList.addAll(data.info!);
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
      await completedRide_Api(LoadMore: 1);
    }
  }
}
