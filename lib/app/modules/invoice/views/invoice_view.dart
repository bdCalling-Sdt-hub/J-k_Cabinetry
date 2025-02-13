import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/cart/controllers/cart_controller.dart';
import 'package:jk_cabinet/app/modules/home/widgets/topbar_contact_info.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/app_custom_textOrIcon_button.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_icon_text_button.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';



class InvoiceView extends StatelessWidget {
   InvoiceView({super.key});
  final CartController _cartController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBarTitle(),
      body: Padding(
        padding:  EdgeInsets.all(8.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBarContactInfo(),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppCustomTextOrIconButton(text: 'In Progress', onTab: (){},buttonColor: Colors.blue.shade50,isBorderActive: true,borderColors: Colors.blue,textColor: Colors.blue,),
                CustomIconTextButton(onPressed: (){}, icon:Icons.receipt, label: 'Invoice')
              ],
            ),
             SizedBox(height: 16.h),
            Text(
              'Order ID: 6546132',
              style: AppStyles.h3(fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 5.h),
            Text(
              'Order date: 12.12.25',
              style:  AppStyles.h5(color: Colors.black54),
            ),
            SizedBox(height: 16.h),
            ExpansionTile(
              title: Text(
                'Order Summery',
                style: AppStyles.h3(),
              ),
              maintainState: true,
              initiallyExpanded: true,
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
                Divider(color: Colors.grey.shade400,),
                verticalSpacing(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sub-Total :',style: AppStyles.h4()),
                    Text('\$${ _cartController.subtotal.value.toStringAsFixed(2)}',style: AppStyles.h5()),
                  ],
                ),
                verticalSpacing(14.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sales Tax (6%) :',style: AppStyles.h4()),
                    Text('\$${(_cartController.salesTax * _cartController.subtotal.value).toStringAsFixed(2) }',style: AppStyles.h5()),
                  ],
                ),
                verticalSpacing(12.h),
              ],
            ),
            verticalSpacing(15.h),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total :',style: AppStyles.h1(color: AppColors.primaryColor),),
                  Text(' \$${_cartController.inTotal.value.toStringAsFixed(2)}',
                    style: AppStyles.h1(color: AppColors.primaryColor),
                  ),
                ],
              );
            }),
            verticalSpacing(15.h),
          ],
        ),
      ),
    );
  }
}
