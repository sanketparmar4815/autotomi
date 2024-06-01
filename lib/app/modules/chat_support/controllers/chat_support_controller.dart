import 'package:autotomi/app/Model/chat_support_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatSupportController extends GetxController {
  TextEditingController sendText = TextEditingController();
  var ticketID, flag, isSendIconColor = false.obs;

  ScrollController? scroll_controller;

  var isLoading = false.obs, page = 1;
  var hasNextPage = true.obs;
  var isLoadMoreRunning = false.obs;
  List<chatSupport> chatSupportList = [];
  @override
  void onInit() {
    if (Get.arguments != null) {
      ticketID = Get.arguments['ticket_id'];
      flag = Get.arguments['flag'];
    }
    print(box.read('user_id'));
    print("ticketID");
    scroll_controller = ScrollController()..addListener(loadMore);
    listSupportRequest_Api();
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

  listSupportRequest_Api({LoadMore}) {
    if (LoadMore != 1) {
      isLoading.value = true;
    }
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "list_support_request",
      method: MethodType.Post,
      params: {
        "page_no": page,
        "ticket_id": ticketID,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          chat_support_model data = chat_support_model.fromJson(response);
          if (LoadMore != 1) {
            chatSupportList = data.info!;
            isLoading.value = false;
            update();
          } else {
            isLoadMoreRunning.value = false;
            if (data.info!.length > 0) {
              chatSupportList.addAll(data.info!);
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

  sendSupportRequest_Api() async {
    print(ticketID);
    print(sendText.text);
    print("rutik");
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "send_support_request",
      method: MethodType.Post,
      params: {
        "request_to": 1,
        "ticket_id": ticketID,
        "message_text": sendText.text,
      },
      headers: NetworkClient.getInstance.getAuthHeaders(),
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          sendText.clear();
          chatSupport data = chatSupport.fromJson(response['info']);
          chatSupportList.insert(0, data);
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

  Future<dynamic> loadMore() async {
    if (hasNextPage.value == true && isLoading.value == false && isLoadMoreRunning.value == false && scroll_controller!.offset >= scroll_controller!.position.maxScrollExtent) {
      isLoadMoreRunning.value = true;
      page++;
      await listSupportRequest_Api(LoadMore: 1);
    }
  }

  String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String formattedDateYest = DateFormat('dd/MM/yyyy').format(DateTime.now().subtract(Duration(days: 1)));

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
