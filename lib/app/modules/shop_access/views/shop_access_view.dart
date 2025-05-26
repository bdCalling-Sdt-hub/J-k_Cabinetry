import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../routes/app_pages.dart';

class ShopAccessView extends StatelessWidget {
  const ShopAccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarTitle(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // J&K Logo
              Image.asset(
                AppImage.appLogoImg,
                height: 80.h,
              ),
              const SizedBox(height: 40),

              // Login link
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.SIGN_IN);
                },
                child: const Text(
                  'Login to Access the Shop',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Description
              const Text(
                'This page is restricted to approved members only. '
                'Please login or register to access this page. If you are already registered, then wait for the Admin verification',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
