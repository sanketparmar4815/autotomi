import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controllers/chat_support_controller.dart';

class ChatSupportView extends GetView<ChatSupportController> {
  const ChatSupportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatSupportController controller = Get.put(ChatSupportController());
    return GetBuilder<ChatSupportController>(
        init: ChatSupportController(),
        builder: (logic) {
          return Obx(() {
            return ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              opacity: 0,
              progressIndicator: customerIndicator,
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: commonWidget.customAppbar(
                    arroOnTap: () {
                      Get.back();
                    },
                    actions: SizedBox(),
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    titleText: stringsUtils.Support,
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() {
                          return controller.isLoadMoreRunning.value == true ? Center(child: customerIndicator) : Container();
                        }),
                        Expanded(
                          child: GroupedListView<dynamic, String>(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            reverse: true,
                            elements: controller.chatSupportList,
                            groupBy: (element) => controller.formatDate(DateTime.parse(element.createdAt.toString())),
                            groupComparator: (value1, value2) => value2.compareTo(value1),
                            groupSeparatorBuilder: (String groupByValue) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10, top: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: color.fillColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: commonWidget.regularText(
                                    DateFormat("dd/MM/yyyy").format(DateTime.parse(groupByValue)) == controller.formattedDate
                                        ? "Today"
                                        : DateFormat("dd/MM/yyyy").format(DateTime.parse(groupByValue)) == controller.formattedDateYest
                                            ? "Yesterday"
                                            : DateFormat("dd/MM/yyyy").format(DateTime.parse(groupByValue)),
                                    fontsize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            itemBuilder: (context, dynamic element) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  element.requestTo.toString() == box.read('user_id').toString()
                                      ? ChatBubbleReceiver(
                                          time: "${DateFormat("hh:mm a").format(DateTime.parse(element.createdAt.toString()).toLocal())}",
                                          message: element.messageText.toString(),
                                        )
                                      : ChatBubbleSender(
                                          time: "${DateFormat("hh:mm a").format(DateTime.parse(element.createdAt.toString()).toLocal())}",
                                          message: element.messageText.toString(),
                                        ),
                                ],
                              );
                            },
                            order: GroupedListOrder.ASC, // optional
                          ),
                        ),
                        controller.flag == 1
                            ? SizedBox()
                            : Padding(
                                padding: EdgeInsets.only(bottom: 15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        onChanged: (val) {
                                          if (controller.sendText.text.isNotEmpty) {
                                            controller.isSendIconColor.value = true;
                                          } else {
                                            controller.isSendIconColor.value = false;
                                          }
                                        },
                                        controller: controller.sendText,
                                        style: TextStyle(
                                          color: color.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Medium',
                                        ),
                                        decoration: InputDecoration(
                                          counter: SizedBox(),
                                          contentPadding: EdgeInsets.only(top: 17, bottom: 17, left: 10, right: 10),
                                          hintText: "Enter",
                                          hintStyle: TextStyle(
                                            color: color.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Medium',
                                          ),
                                          filled: true,
                                          fillColor: color.fillColor,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(22),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(22),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    InkWell(
                                      onTap: () {
                                        if (controller.sendText.text.isNotEmpty && controller.sendText.text.trim() != "") {
                                          controller.sendSupportRequest_Api();
                                          controller.update();
                                        } else {}
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Container(
                                        height: 50,
                                        width: 48,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24),
                                          color: color.fillColor,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.send,
                                            color: controller.isSendIconColor.value == true ? Colors.black : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ],
                    ),
                  )),
            );
          });
        });
  }
}

class ChatBubbleReceiver extends StatelessWidget {
  final message;
  final time;

  const ChatBubbleReceiver({this.message, this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        color: color.fillColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: Get.width / 1.6),
                            child: commonWidget.mediumText(
                              message,
                              tcolor: Colors.black,
                              fontsize: 14.0,
                            ),
                          ),
                          SizedBox(height: 5),
                          commonWidget.mediumText(
                            "$time",
                            tcolor: Colors.black,
                            fontsize: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChatBubbleSender extends StatelessWidget {
  final message;
  final status;
  final time;
  final profilepic;

  const ChatBubbleSender({this.message, this.status, this.time, this.profilepic});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        topLeft: Radius.circular(16),
                      ),
                      color: color.fillColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: Get.width / 1.6),
                          // width: Get.width * 0.35,
                          child: commonWidget.mediumText(
                            message,
                            tcolor: Colors.black,
                            fontsize: 14.0,
                          ),
                        ),
                        SizedBox(height: 5),
                        commonWidget.mediumText(
                          "$time",
                          tcolor: Colors.black,
                          fontsize: 10.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Chat_Message {
  late String messageContent;
  late String messageType;
  late String image;

  Chat_Message({
    required this.messageContent,
    required this.messageType,
    required this.image,
  });
}
