import 'package:get/get.dart';

import '../controllers/shop_access_controller.dart';

class ShopAccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopAccessController>(
      () => ShopAccessController(),
    );
  }
}
