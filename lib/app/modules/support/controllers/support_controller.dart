import 'package:autotomi/app/Model/support_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/bottombar/views/bottombar_view.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportController extends GetxController with GetSingleTickerProviderStateMixin {
  RxInt showRequest = 0.obs;
  ScrollController? scroll_controller;

  TabController? tabController;
  var isLoading = false.obs, page = 1;
  var hasNextPage = true.obs;
  var isLoadMoreRunning = false.obs;
  List<support> supportList = [];
  var flag, initIndex = 0;
  @override
  void onInit() {
    if (Get.arguments != null) {
      flag = Get.arguments['notification_flag'];
      initIndex = Get.arguments['index'];
    }
    print("notification flag is $flag");
    scroll_controller = ScrollController()..addListener(loadMore);
    tabController = TabController(length: 2, vsync: this, initialIndex: initIndex);
    inProgressCompleted_Api();
    tabController!.addListener(() {
      page = 1;
      hasNextPage.value = true;
      inProgressCompleted_Api();
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

  inProgressCompleted_Api({LoadMore}) {
    if (LoadMore != 1) {
      isLoading.value = true;
    }
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "list_support_ticket",
      method: MethodType.Post,
      params: {
        "page_no": page,
        "tab_type": tabController!.index == 0 ? "current" : "completed",
      },
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          support_model data = support_model.fromJson(response);
          if (LoadMore != 1) {
            supportList = data.info!;
            isLoading.value = false;
            update();
          } else {
            isLoadMoreRunning.value = false;
            if (data.info!.length > 0) {
              supportList.addAll(data.info!);
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
      await inProgressCompleted_Api(LoadMore: 1);
    }
  }

  onWillPopScope() {
    if (flag == 4) {
      print("enter flag 1");
      Get.back();
    } else {
      print("enter flag 2");
      Get.back();
    }
  }
}
