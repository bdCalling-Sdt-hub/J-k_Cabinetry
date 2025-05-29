import 'package:get/get.dart';

import '../controllers/all_orders_view_controller.dart';

class AllOrdersViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllOrdersViewController>(
      () => AllOrdersViewController(),
    );
  }
}
