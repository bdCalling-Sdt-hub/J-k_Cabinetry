import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jk_cabinet/common/app_images/app_images.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';

class StandardFeatures extends StatelessWidget {
  const StandardFeatures({Key? key}) : super(key: key);

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
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding:  EdgeInsets.only(left: 10.w, bottom: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            '• ',
            style: TextStyle(fontSize: 14.sp),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(String imageUrl) {
    return Padding(
      padding:  EdgeInsets.only(top: 10.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.asset(
          imageUrl, // Replace with local asset if needed
          //height: 180.h,
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
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            _buildSectionTitle('Standard Features'),

            // Description
             Text(
              "All J&K's cabinets and vanities are superiorly constructed with 100% solid wood and proudly come with the following STANDARD features:",
              style: TextStyle(fontSize: 14.sp),
            ),
             SizedBox(height: 10.h),

            // Bullet Points List
            _buildBulletPoint('DOOR PANEL - 3/4" thick solid wood, full overlay door.'),
            _buildBulletPoint('DOOR HINGE - 6-way adjustable, soft-close metal and hidden Euro-style.'),
            _buildBulletPoint('ADJUSTABLE SHELF - 3/4" thick cabinet-grade plywood, clear coat finish on all sides and edges and metal shelf rests.'),
            _buildBulletPoint('DRAWERS - 5/8" thick solid wood on all sides, full extension pull-out and dovetail construction.'),
            _buildBulletPoint('DRAWER GLIDE - Full extension pull-out, soft-close metal and concealed under mount.'),
            _buildBulletPoint('PLYWOOD BOX - 5/8" thick cabinet-grade plywood, clear coat finish on interior sides and matching color finish on exterior sides.'),
            _buildBulletPoint('METAL BRACKET - Corner bracket reinforcements in base cabinets for maximum stability.'),
            _buildBulletPoint('DOOR BUMPER - Promotes quiet-closing and reduces slamming for maximum durability.'),

             SizedBox(height: 10.h),

            // Highlighted Upgrade
            const Text(
              'Tilt-out Trays have been another upgrade and STANDARD feature in all of J&K’s Kitchen Sink Base and Vanity Sink Cabinets.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

            // Image Sections (Replace with assets if available)
            _buildImageSection(AppImage.standardFeatureImg), // Replace with actual image

             SizedBox(height: 10.h),

            // Note Section
             Text(
              '[ Note: As we continue to improve our product qualities and designs, the actual functionality of Door Hinges and Drawer Glides may vary slightly between existing and newest product styles and finishes. Please check with your local J&K Cabinetry showroom or dealer for the most current updates. ]',
              style: TextStyle(
                fontSize: 12.sp,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
