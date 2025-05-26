import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/cart/controllers/cart_controller.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';

class CustomCartFloatingButton extends StatefulWidget {
  const CustomCartFloatingButton({super.key});

  @override
  State<CustomCartFloatingButton> createState() => _CustomCartFloatingButtonState();
}

class _CustomCartFloatingButtonState extends State<CustomCartFloatingButton> {
  // final int notificationCount = 20;
   final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,  // To allow the badge to overflow
      children: [
        FloatingActionButton(
          onPressed: () {
           Get.toNamed(Routes.CART);
          },
          backgroundColor: AppColors.floatingButtonColor,
          child: const Icon(Icons.shopping_cart),
        ),

        // Notification Badge
        Obx(() {
          final cartItemCount = cartController.cartItems.length;
          try {
            return cartItemCount > 0
                ? Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      constraints:
                          BoxConstraints(minWidth: 20.w, minHeight: 20.h),
                      child: Text(
                        cartItemCount > 99 ? "99+" : "$cartItemCount",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : const SizedBox();
          } catch (e) {
            return const SizedBox();
          }
        }),
      ],
    );
  }
}
