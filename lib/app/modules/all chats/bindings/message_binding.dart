import 'package:get/get.dart';

import '../controllers/all_chats_controller.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllChatsController>(
      () => AllChatsController(),
    );
  }
}
