import 'package:get/get.dart';

import '../controllers/cabinet_parts_recentviewed_details_controller.dart';

class CabinetPartsRecentviewedDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CabinetPartsRecentViewedDetailsController>(
      () => CabinetPartsRecentViewedDetailsController(),
    );
  }
}
