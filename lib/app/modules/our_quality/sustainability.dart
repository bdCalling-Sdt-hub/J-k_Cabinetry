


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jk_cabinet/common/app_images/app_images.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';

class Sustainability extends StatelessWidget {
  const Sustainability({Key? key}) : super(key: key);

  Widget _buildSectionTitle(String title, {Color color = Colors.red}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: color,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildImageSection(String imageUrl) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.asset(
          imageUrl, // Replace with local asset if needed
          //height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBarTitle(),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16.sp),
        child: Column(
          children: [
            // Title
            _buildSectionTitle('Sustainability'),
            // Image Section (Replace with an asset if needed)
            _buildImageSection(AppImage.sustainabilityImg), // Replace with actual image URL or asset
            // Description
             Text(
              "We believe that a healthy environment is the backbone to the happy lives of our customers and our society. In addition to our continued effort to improve our product qualities and values, J&K Cabinetry is committed to manufacturing and selling environmental-friendly and healthy products to our customers. J&K Cabinetry’s hardwood-plywood materials are compliant with California 93120, Phase 2 (CARB 2) standard for formaldehyde. We also use AkzoNobel, a leading global company in sustainable paints and coatings, for our cabinet finishes.",
              style: TextStyle(fontSize: 14.sp),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
