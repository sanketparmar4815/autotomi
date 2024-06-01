import 'package:autotomi/app/Model/all_review_rating_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCarRatingReviewController extends GetxController {
  List<allRatingReview> allRatingReviewList = [];
  var carID, page = 1;
  var hasNextPage = true.obs, isLoading = false.obs;
  var isLoadMoreRunning = false.obs;
  ScrollController? scroll_controller;
  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      carID = Get.arguments['car_id'];
    }
    print("carID");
    print(carID);
    await allReviewRatingList_Api();
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

  allReviewRatingList_Api({LoadMore}) {
    if (LoadMore != 1) {
      isLoading.value = true;
    }
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "list_review",
      method: MethodType.Post,
      params: {
        "page_no": page,
        "car_id": carID,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          all_review_rating_model data = all_review_rating_model.fromJson(response);
          if (LoadMore != 1) {
            allRatingReviewList = data.info!;
            isLoading.value = false;
            update();
          } else {
            isLoadMoreRunning.value = false;
            if (data.info!.length > 0) {
              allRatingReviewList.addAll(data.info!);
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
      await allReviewRatingList_Api(LoadMore: 1);
    }
  }
}
