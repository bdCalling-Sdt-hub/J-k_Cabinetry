import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jk_cabinet/common/app_images/network_image%20.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(AppNetworkImage.kitchenImg),  // Update with your image
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text("Your Dream Kitchen Starts Here", style: AppStyles.h2()),
        SizedBox(height: 10.h),
        CustomButton(
          width: 100.w,
          onTap: () {},
          text:"View Cabinet Lines",
        ),
      ],
    );
  }
}