import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jk_cabinet/common/app_images/app_images.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';

class CommitmentToQuality extends StatelessWidget {
  const CommitmentToQuality({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBarTitle(),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16.sp),
        child: Column(
          children: [
            // Title
             Text(
              'Our Commitment to Quality',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),

            // Subheading
             Text(
              'All J&K Cabinetry are constructed with 100% Solid wood. No particle board or MDF materials are used in J&K Cabinets.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 20.h),

            // CARB2 Logo and Title
            Column(
              children: [
                Image.asset(AppImage.carb2Img,
                  height: 60.h,
                ),
                SizedBox(height: 10.h),
                 Text(
                  'CARB 2 compliant',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 5.h),
                 Text(
                  'J&K Cabinetry is CARB2 friendly.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Description Text
            const Text(
              'CARB2 is a certification process instituted by the California Air Resources Board (CARB) to reduce formaldehyde emissions and protect the public from airborne toxic contaminants.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 10.h),

            const Text(
              'There’s a reason CARB has become known as the "clean air agency".',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 10.h),

            const Text(
              'The CARB2 compliant seal indicates that the product’s formaldehyde levels are well within the safety limits. It’s worth noting that CARB2 regulation applies to almost all composite wood products ranging from cabinets, countertops, and doors to furniture, molding, toys, and even photo frames.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 10.h),

            const Text(
              'The next time you buy any wood composite product, be sure to look for CARB2 certification. Every composite wood product sold in California is required to be CARB2 compliant. If you ever come across one that doesn’t specifically say so, make it a point to ask the dealer or manufacturer for more information.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20.h),

            // Closing Statement
            const Text(
              'All J&K Cabinetry are constructed with 100% Solid wood.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),

            const Text(
              'Our quality is our top priority and we do not use any particle board or MDF materials in our cabinetry.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
