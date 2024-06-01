import 'package:autotomi/app/Model/availbale_car_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritecarController extends GetxController {
  TextEditingController searchText = TextEditingController();

  var isLoading = false.obs, page = 1;
  var hasNextPage = true.obs;
  var isLoadMoreRunning = false.obs;
  ScrollController? scroll_controller;

  List<availbaleCar> favoriteCarList = [];

  @override
  void onInit() {
    scroll_controller = ScrollController()..addListener(loadMore);

    favoriteCar_Api();

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

  favoriteCar_Api({LoadMore}) {
    if (LoadMore != 1) {
      isLoading.value = true;
    }
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "list_liked_car",
      method: MethodType.Post,
      params: {
        "page_no": page,
        "search_text": searchText.text,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          availabale_car_model data = availabale_car_model.fromJson(response);

          if (LoadMore != 1) {
            favoriteCarList = data.info!;
            isLoading.value = false;
            update();
          } else {
            isLoadMoreRunning.value = false;
            if (data.info!.length > 0) {
              favoriteCarList.addAll(data.info!);
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
      await favoriteCar_Api(LoadMore: 1);
    }
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
}
