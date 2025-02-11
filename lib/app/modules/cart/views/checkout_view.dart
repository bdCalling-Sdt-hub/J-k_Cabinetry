import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/cart/controllers/cart_controller.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_drawer/app_drawer.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';

class CheckoutView extends StatelessWidget {
   CheckoutView({super.key});
final CartController _cartController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarTitle(
        isShowChat: true,
        chatOnTap: () {},
        notificationCount: '40',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTile(
              title: Text(
                'Order Summery',
                style: AppStyles.h3(),
              ),
              maintainState: true,
              controlAffinity: ListTileControlAffinity.platform,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              trailing: const Icon(Icons.arrow_drop_down_circle_outlined),
              children: [
                 const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Assembly', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Divider(color: Colors.grey.shade400,),

                // Cart Item
                ...List.generate(_cartController.cartItems.length, (index){
                 final cartItem= _cartController.cartItems[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///Name
                        Text(cartItem.name,style: AppStyles.h5(),),
                        ///Qty
                        Text(cartItem.quantity.toString(),style: AppStyles.h5()),
                        /// Assembly
                        Text('\$${cartItem.assemblyCost.toStringAsFixed(2)}',style: AppStyles.h5()),
                        /// Total
                        Text('\$${cartItem.totalPrice.toStringAsFixed(2)}',style: AppStyles.h5()),
                      ],
                    ),
                  );
                }),
                verticalSpacing(12.h),
                Text('Shipping :-',style: AppStyles.h4(),),
                verticalSpacing(8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('By J&K Cabinetry',style: AppStyles.h4(),),
                      Text('\$${_cartController.isShip.value?_cartController.shippingCost.toStringAsFixed(2):0.toStringAsFixed(2)}',style: AppStyles.h5(),),
                    ],
                  ),
                ),
                verticalSpacing(10.h),
              ],
            ),
            verticalSpacing(14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sub-Total :',style: AppStyles.h4()),
                Text('\$10.0',style: AppStyles.h5()),
              ],
            ),
            verticalSpacing(14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Salse Tax (6%):',style: AppStyles.h4()),
                Text('\$10.0',style: AppStyles.h5()),
              ],
            ),
            Divider(color: Colors.grey.shade400,),
            Spacer(),
            verticalSpacing(12.h),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total :',style: AppStyles.h1(color: AppColors.primaryColor),),
                  Text(' \$${_cartController.subtotal.value.toStringAsFixed(2)}',
                    style: AppStyles.h1(color: AppColors.primaryColor),
                  ),
                ],
              );
            }),
            verticalSpacing(15.h),
            CustomButton(onTap: () {}, text: 'Complete order'),
            verticalSpacing(16.h),
          ],
        ),
      ),
    );
  }
}



