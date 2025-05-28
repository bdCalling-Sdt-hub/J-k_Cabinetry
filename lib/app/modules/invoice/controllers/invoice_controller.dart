import 'package:get/get.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/app/data/network_caller.dart';
import 'package:jk_cabinet/app/modules/cart/controllers/make_payment_controller.dart';
import 'package:jk_cabinet/app/modules/invoice/models/invoice_model.dart';
import 'package:jk_cabinet/common/app_constant/app_constant.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';

import '../../../routes/app_pages.dart';

class InvoiceController extends GetxController {

  Rx<OrderResponseModel> orderResponse = OrderResponseModel().obs;
  final controller = Get.put(PaymentController());

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> getInvoice() async {
    isLoading.value = true;
    update();
    final String? orderSID = controller.paymentResponseModel.value.data?.sId;
    final token = await PrefsHelper.getString(AppConstants.signInToken);
    final NetworkResponse response = await NetworkCaller().getRequest(ApiConstants.getInvoiceUrl(orderSID!), accessToken: token);

    if (response.isSuccess) {
      orderResponse.value = OrderResponseModel.fromJson(response.responseData);
      Get.toNamed(Routes.INVOICE);
    } else {
      errorMessage.value = response.errorMessage;
    }
    isLoading.value = false;
    update();
  }
}
