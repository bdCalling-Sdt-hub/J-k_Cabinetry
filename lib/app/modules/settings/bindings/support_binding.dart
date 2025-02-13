import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/settings/controllers/support_controller.dart';



class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportController>(() => SupportController(),
    );
  }
}
