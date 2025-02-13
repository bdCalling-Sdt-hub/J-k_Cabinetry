import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/settings/controllers/term_and_condition.dart';



class TermsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermAndConditionController>(() => TermAndConditionController(),
    );
  }
}
