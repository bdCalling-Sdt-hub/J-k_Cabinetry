import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jk_cabinet/app/data/external_url.dart';
import 'package:jk_cabinet/app/modules/profile/controllers/profile_controller.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_images/network_image%20.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';

class ProfileView extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());

  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarTitle(isShowChat: true,chatOnTap: (){},notificationCount: '40',),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
               // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Profile Picture with Edit Button
                  CircleAvatar(
                    radius: 60.r,
                    backgroundImage: NetworkImage(AppNetworkImage.golfPlayerImg), // Replace with network image if needed
                  ),
                  horizontalSpacing(14.w),
                  /// Profile name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Shuvo Khandaker',style: AppStyles.h3(),),
                      horizontalSpacing(8.w),
                      /// Edit Button
                      ElevatedButton.icon(
                        onPressed: (){
                          Get.toNamed(Routes.PROFILE_UPDATE);
                        },
                        icon: Icon(Icons.edit, size: 16.sp),
                        label: Text("Edit Profile", style: AppStyles.h5()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 15.h),
              /// Profile Information
              _profileDetail("Company Name", "No Name"),
              _profileDetail("First Name", "Mahmudur Rahman Talukder"),
              _profileDetail("Last Name", "Talukder"),
              _profileDetail("Phone Number", "+880 1770504877"),
              _profileDetail("Address", "Sylhet, Moulvibazar"),
              _profileDetail("Address Line 2", "Kulaura"),
              _profileDetail("State", "Moulvibazar"),
              _profileDetail("City", "Kulaura"),
              _profileDetail("Zip Code", "3230"),

              /// Document Verification
              _verifiedStatus(),

              _profileDetail("Sales Rep. Name", "Nill"),
              _profileDetail("Email", "mahmud.uiuxdesign@gmail.com"),

              SizedBox(height: 20.h),

            ],
          ),
        ),
      ),
    );
  }

  /// Profile Information Row
  Widget _profileDetail(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title:", style: AppStyles.h5(fontWeight: FontWeight.bold)),
          verticalSpacing(6.h),
          Text(value, style: AppStyles.h5()),
        ],
      ),
    );
  }

  /// Verified Status Row
  Widget _verifiedStatus() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Text("Document:", style: AppStyles.h5(fontWeight: FontWeight.bold)),
          SizedBox(width: 5.w),
          Icon(Icons.verified, color: Colors.green, size: 18.sp),
          SizedBox(width: 5.w),
          Text("Verified", style: AppStyles.h5(color: Colors.green)),
        ],
      ),
    );
  }
}
