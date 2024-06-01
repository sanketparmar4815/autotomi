import 'package:get/get.dart';

import '../controllers/chat_support_controller.dart';

class ChatSupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatSupportController>(
      () => ChatSupportController(),
    );
  }
}
