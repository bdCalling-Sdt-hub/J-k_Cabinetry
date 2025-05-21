import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:jk_cabinet/app/modules/cart/models/payment_response_model.dart';
import 'package:jk_cabinet/app/modules/home/widgets/topbar_contact_info.dart';
import 'package:jk_cabinet/app/modules/profile/model/profile_model.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';

import '../../cart/controllers/make_payment_controller.dart';
import '../../profile/controllers/profile_controller.dart';


class CashPaymentProcessView extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());
  final PaymentController _paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarTitle(),
      body: Padding(
        padding:  EdgeInsets.all(8.0.sp),
        child: Center(
          child: Container(
            padding:  EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.blue),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 50.sp,
                ),
                 SizedBox(height: 10.h),
                Obx((){
                  return Text('Thank you ${_profileController.profileModel.value.data?.firstName ?? ''}, we are now preparing to process your order.',
                    textAlign: TextAlign.center,
                    style: AppStyles.h4(color: Colors.blue),
                  );
                }),
                 SizedBox(height: 10.h),

                /// Order Id
                Obx(() {
                  final orderId = _paymentController.paymentResponseModel.value.data?.orderId ?? '';
                  return GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: orderId));
                      Get.snackbar(
                        'Success',
                        'Order ID copied to clipboard',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.green.withOpacity(0.1),
                        duration: const Duration(seconds: 2),
                      );
                    },
                    child: Wrap(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Order ID: $orderId',
                          style: AppStyles.h4(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8.w),
                        Center(child: Icon(Icons.copy, size: 20.sp, color: AppColors.primaryColor)),
                      ],
                    ),
                  );
                }),
                 SizedBox(height: 5.h),
                 Text('We will contact you for more information regarding the payment.',
                  textAlign: TextAlign.center,
                  style: AppStyles.h4(color: AppColors.primaryColor),
                ),
                 SizedBox(height: 15.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding:  EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                    onPressed: () {
                     Get.toNamed(Routes.INVOICE);
                    },
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
