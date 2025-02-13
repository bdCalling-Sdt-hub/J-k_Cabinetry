import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:jk_cabinet/app/modules/home/widgets/topbar_contact_info.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';


class CashPaymentProcessView extends StatelessWidget {
  final String? userName;
  final String? orderId;

  const CashPaymentProcessView({
    super.key,
     this.userName='Shuvo Kh',
     this.orderId='64654651',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarTitle(),
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
                Text('Thank you $userName, we are now preparing to process your order.',
                  textAlign: TextAlign.center,
                  style: AppStyles.h4(color: Colors.blue),
                ),
                 SizedBox(height: 10.h),
                Text('Order ID :  $orderId',
                  style: AppStyles.h4(color: AppColors.primaryColor,fontWeight: FontWeight.bold),
                ),
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
