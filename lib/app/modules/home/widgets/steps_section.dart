

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/widgets/custom_card.dart';
import 'package:jk_cabinet/common/widgets/custom_outlinebutton.dart';

class StepsSection extends StatelessWidget {
  const StepsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Row of Steps
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _stepCard(
                  icon: Icons.app_registration,
                  title: 'Register to Order',
                  description: 'Click here to fill out account application.',
                ),
                _stepCard(
                  icon: Icons.check_circle,
                  title: 'Account Approval',
                  description: 'Allow 24 hours for our sales to verify your business.',
                ),
                _stepCard(
                  icon: Icons.shopping_cart,
                  title: 'Place Your Order',
                  description: 'You may call, email or use our online catalog after account approval.',
                ),
                _stepCard(
                  icon: Icons.local_shipping,
                  title: 'Pickup or Delivery',
                  description: 'Only In-stock items apply.',
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          // Start Application Button
          CustomOutlineButton(
            width: 100.w,
            onTap: () {
              Get.toNamed(Routes.SIGN_UP);
            },
            text: 'Start Application',
          ),
        ],
      ),
    );
  }

  // Widget for each step card
  Widget _stepCard({required IconData icon, required String title, required String description}) {
    return CustomCard(
      cardWidth: 200.w,
      elevation: 1,
      children: [
        Icon(icon, size: 40, color: Colors.red),
        SizedBox(height: 8.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 4.h),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}