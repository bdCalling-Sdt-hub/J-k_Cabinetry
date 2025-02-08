import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jk_cabinet/app/modules/profile/controllers/profile_controller.dart';
import 'package:jk_cabinet/app/modules/profile_update/controllers/profile_update_controller.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_images/app_images.dart';
import 'package:jk_cabinet/common/app_images/network_image%20.dart';
import 'package:jk_cabinet/common/app_string/app_string.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';
import 'package:jk_cabinet/common/widgets/custom_outlinebutton.dart';
import 'package:jk_cabinet/common/widgets/custom_text_field.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';
import 'package:jk_cabinet/common/widgets/text_required.dart';

class ProfileUpdateView extends StatelessWidget {
  final ProfileUpdateController _profileUpdateController = Get.put(ProfileUpdateController());

  ProfileUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarTitle(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Picture with Edit Option
              Row(
                children: [
                  Stack(
                    children: [
                      Obx(() => CircleAvatar(
                          radius: 64.r,
                          backgroundImage: _profileUpdateController.profileImagePath.value.isNotEmpty
                              ? FileImage(File(_profileUpdateController.profileImagePath.value)) as ImageProvider
                              :  NetworkImage(AppNetworkImage.golfPlayerImg),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: (){
                            _profileUpdateController.pickImageFromGallery(ImageSource.gallery);
                          },
                          child: CircleAvatar(
                            radius: 16.r,
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(Icons.camera_alt, size: 16.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  horizontalSpacing(14.w),
                  /// Profile name
                  Text('Shuvo Khandaker',style: AppStyles.h3(),)

                ],
              ),

              SizedBox(height: 18.h),

              /// Profile Form Fields
              _profileInputField("Company Name", _profileUpdateController.companyNameCtrl),
              _profileInputField("First Name", _profileUpdateController.firstNameCtrl),
              _profileInputField("Last Name", _profileUpdateController.lastNameCtrl),
              _profileInputField("Phone Number", _profileUpdateController.phoneCtrl, TextInputType.phone),
              _profileInputField("Address", _profileUpdateController.addressCtrl),
              _profileInputField("Address Line 2", _profileUpdateController.address2Ctrl),

              /// City & Zip Code
              Row(
                children: [
                  Expanded(child: _profileInputField("City", _profileUpdateController.cityCtrl)),
                  SizedBox(width: 10.w),
                  Expanded(child: _profileInputField("Zip Code", _profileUpdateController.zipCodeCtrl, TextInputType.number)),
                ],
              ),

              /// State
              _profileInputField("State", _profileUpdateController.stateCtrl),
              SizedBox(height: 10.h),

              /// Sales Rep Name (Optional)
              _profileInputField("Sales Rep. Name (Optional)", _profileUpdateController.salesRepCtrl),

              /// Save & Continue
              SizedBox(height: 20.h),
              CustomButton(onTap: (){}, text: AppString.saveAndContinueText),
              SizedBox(height: 20.h),
              //CustomOutlineButton(onTap: (){}, text: "Reset Password"),

              // ElevatedButton(
              //   onPressed: (){},
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: AppColors.primaryColor,
              //     foregroundColor: Colors.white,
              //     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              //   ),
              //   child: Text("Save", style: AppStyles.h4()),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  /// Profile Input Field Widget
  Widget _profileInputField(String title, TextEditingController controller, [TextInputType? keyboardType]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextRequired(text: title, textStyle: AppStyles.h4()),
        SizedBox(height: 5.h),
        CustomTextField(hintText: "Type $title", controller: controller, keyboardType: keyboardType,contentPaddingVertical: 14.h,),
        SizedBox(height: 10.h),
      ],
    );
  }
}
