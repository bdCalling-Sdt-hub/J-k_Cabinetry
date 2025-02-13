import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/settings/controllers/privacy_controller.dart';



class PrivacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyController>(() => PrivacyController(),
    );
  }
}
