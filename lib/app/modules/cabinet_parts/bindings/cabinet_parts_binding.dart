import 'package:get/get.dart';

import '../controllers/cabinet_parts_controller.dart';

class CabinetPartsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CabinetPartsController>(
      () => CabinetPartsController(),
    );
  }
}
