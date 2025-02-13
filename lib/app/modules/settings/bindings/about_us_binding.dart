import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/settings/controllers/about_us_controller.dart';



class AboutUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutUsController>(() => AboutUsController(),
    );
  }
}
