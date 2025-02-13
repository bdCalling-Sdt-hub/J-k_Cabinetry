import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_icons/app_icons.dart';
import 'package:jk_cabinet/common/app_string/app_string.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_listTile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: AppColors.textColor,
              )),
        ),
        title: Text(
          AppString.settingText,
          style: AppStyles.h2(
            family: "Schuyler",
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          /// Change Password
          SizedBox(height: 16.h),
          CustomListTile(
            iconHeight: 24.h,
            title: AppString.changePasswordText,
            icon: AppIcons.passwordIcon,
            onTap: () {
              Get.toNamed(Routes.CHANGE_PASSWORD);
            },
          ),

          /// Privacy setting
          SizedBox(height: 16.h),
          CustomListTile(
            iconHeight: 22.h,
            title: AppString.privacyText,
            icon: AppIcons.privacyIcon,
            onTap: () {
              Get.toNamed(Routes.PRIVAACY_POLICY);
            },
          ),

          /// Term & Condition
          SizedBox(height: 16.h),
          CustomListTile(
            title: AppString.termConditionText,
            icon: AppIcons.exclamatoryIcon,
            onTap: () {
              Get.toNamed(Routes.TERMS_CONDITION);
            },
          ),

          /// about screen
          SizedBox(height: 16.h),
          CustomListTile(
            title: AppString.aboutusText,
            icon: AppIcons.aboutIcon,
            onTap: () {
              Get.toNamed(Routes.ABOUT);
            },
          ),

          /// support screen
          SizedBox(height: 16.h),
          CustomListTile(
            title: AppString.contactUsText,
            icon: AppIcons.supportIcon,
            onTap: () {
              Get.toNamed(Routes.SUPPORT);
            },
          ),
        ],
      ),
    );
  }
}
