import 'package:get/get.dart';

import '../controllers/cabinetry_controller.dart';

class CabinetryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CabinetryController>(
      () => CabinetryController(),
    );
  }
}
