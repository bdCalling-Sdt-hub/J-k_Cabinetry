import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/make_payment_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(() => PaymentController(),
    );
  }
}
