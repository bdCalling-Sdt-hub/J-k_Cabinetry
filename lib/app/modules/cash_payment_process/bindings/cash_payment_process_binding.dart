import 'package:get/get.dart';

import '../controllers/cash_payment_process_controller.dart';

class CashPaymentProcessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashPaymentProcessController>(
      () => CashPaymentProcessController(),
    );
  }
}
