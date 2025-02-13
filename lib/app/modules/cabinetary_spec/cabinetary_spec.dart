import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jk_cabinet/common/app_images/app_images.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';

class CabinetrySpec extends StatelessWidget {
  const CabinetrySpec({Key? key}) : super(key: key);

  Widget _buildSectionTitle(String title, {Color color = Colors.red}) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 10.h),
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
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildButton(VoidCallback onPressed) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.h),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.brown),
          padding:  EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
        ),
        onPressed: onPressed,
        child:  Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            'View/Download',
            style: TextStyle(color: Colors.brown, fontSize: 16.sp),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarTitle(),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            _buildSectionTitle('J&K Cabinetry Specs'),

            // Image Section (Replace with asset if needed)
            _buildImageSection(AppImage.kitchenCabinetImg), // Replace with actual image URL or asset

            // Note Section
             Text(
              "[ Note: Not all items are listed, only in-stock items at our current warehouse ]",
              style: TextStyle(
                fontSize: 12.sp,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 10.h),

            // Spec Sheet Heading
             Text(
              "Georgia Spec Sheet Below:",
              style: TextStyle(fontSize: 14.sp),
            ),
             SizedBox(height: 10.h),

            // View/Download Button
            _buildButton(() {
              // Handle View/Download Action
            }),

             SizedBox(height: 10.h),

            // Additional Note
             Text(
              "Items not listed can still be ordered but are not available immediately.",
              style: TextStyle(fontSize: 12.sp),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 5.h),
             Text(
              "Please check with your location and sales representative.",
              style: TextStyle(fontSize: 12.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
