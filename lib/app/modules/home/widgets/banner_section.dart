import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_images/network_image%20.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/casess_network_image.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomNetworkImage(imageUrl: AppNetworkImage.kitchenImg,height: 250.h,),
        SizedBox(height: 10.h),
        Text("Your Dream Kitchen Starts Here", style: AppStyles.h2()),
        SizedBox(height: 10.h),
        CustomButton(
          width: 100.w,
          onTap: () {
            Get.toNamed(Routes.CABINETRY);
          },
          text:"View Cabinet Lines",
        ),
      ],
    );
  }
}