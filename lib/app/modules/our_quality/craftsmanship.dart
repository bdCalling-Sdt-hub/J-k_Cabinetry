import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jk_cabinet/common/app_images/app_images.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';

class Craftsmanship extends StatelessWidget {
  const Craftsmanship({Key? key}) : super(key: key);

  Widget _buildSectionTitle(String title, {Color color = Colors.red}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildNumberedPoint(int number, String text) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. ',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style:  TextStyle(fontSize: 14.sp),
            ),
          ),
        ],
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
          //height: 180,
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            _buildSectionTitle('Craftsmanship'),

            // Description
             Text(
              "Our J&K’s solid wood cabinet finishes are processed thorough the following excellent craftsmanship details:",
              style: TextStyle(fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),

            // Image Section (Replace with asset if needed)
            _buildImageSection(AppImage.doorImg), // Replace with actual image URL or local asset

            // Note Section
             Text(
              "[ Note: Not actual product; image for reference only ]",
              style: TextStyle(
                fontSize: 12.sp,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 10.h),

            // Numbered List
            _buildNumberedPoint(1, "The finest solid wood is sanded until smooth and vacuumed."),
            _buildNumberedPoint(2, "An equalizer stain is applied to balance the base color of the wood."),
            _buildNumberedPoint(3, "A toner is applied to establish color uniformity."),
            _buildNumberedPoint(4, "A deep penetrating stain is applied to reveal the hidden beauty of the natural grain."),
            _buildNumberedPoint(5, "All stained surfaces are hand-rubbed and wiped of excess stain, and then slowly air-dried."),
            _buildNumberedPoint(6, "A wood sealer is applied, penetrating all exposed wood surfaces for uniform protection."),
            _buildNumberedPoint(7, "All surfaces are hand-sanded, providing a smooth, consistent surface."),
            _buildNumberedPoint(8, "A glaze is applied by hand (if applicable)."),
            _buildNumberedPoint(9, "A color consistency examination is performed with additional touch-up if needed."),
            _buildNumberedPoint(10, "A final protective top coat is applied, maximizing resistance to scuffing, moisture, fading and most household chemicals."),
          ],
        ),
      ),
    );
  }
}
