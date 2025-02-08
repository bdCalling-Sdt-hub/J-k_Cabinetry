import 'package:get/get.dart';

import '../controllers/cabinet_detail_controller.dart';

class CabinetDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CabinetDetailController>(
      () => CabinetDetailController(),
    );
  }
}
