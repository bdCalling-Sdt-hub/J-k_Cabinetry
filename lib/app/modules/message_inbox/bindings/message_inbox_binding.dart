import 'package:get/get.dart';

import '../controllers/message_inbox_controller.dart';

class MessageInboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageInboxController>(
      () => MessageInboxController(),
    );
  }
}
