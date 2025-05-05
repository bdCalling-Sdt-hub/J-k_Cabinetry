import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_icons/app_icons.dart';
import 'package:jk_cabinet/common/app_string/app_string.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';
import 'package:jk_cabinet/common/widgets/custom_text_field.dart';
import 'package:jk_cabinet/common/widgets/show_status_change_pass_item.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';
import 'package:jk_cabinet/common/widgets/text_required.dart';
import 'package:lottie/lottie.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final ChangePasswordController _changePasswordController =
  Get.put(ChangePasswordController());

  final email = Get.arguments['email'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarTitle(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(
                flex: 1,
              ),

              ///Password
              verticalSpacing(20.h),
              TextRequired(
                text: AppString.passawordText,
                textStyle: AppStyles.h4(family: "Schuyler"),
              ),
              verticalSpacing(10.h),
              CustomTextField(
                filColor: AppColors.textFieldFillColor,
                suffixIconColor: AppColors.appGreyColor,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: SvgPicture.asset(AppIcons.lockIcon),
                ),
                contentPaddingVertical: 20.h,
                hintText: "Type a password",
                labelTextStyle: const TextStyle(color: AppColors.primaryColor),
                isObscureText: true,
                obscure: '*',
                isPassword: true,
                controller: _changePasswordController.newPassCtrl,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter password';
                  }
                  return null;
                },
              ),

              ///Confirm-Password
              SizedBox(height: 20.h),
              TextRequired(
                text: AppString.confirmPasswordText,
                textStyle: AppStyles.h4(family: "Schuyler"),
              ),
              verticalSpacing(10.h),
              CustomTextField(
                filColor: AppColors.textFieldFillColor,
                suffixIconColor: AppColors.appGreyColor,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: SvgPicture.asset(AppIcons.lockIcon),
                ),
                contentPaddingVertical: 20.h,
                hintText: "Re-type your password",
                labelTextStyle: const TextStyle(color: AppColors.primaryColor),
                isObscureText: true,
                obscure: '*',
                isPassword: true,
                controller: _changePasswordController.confirmPassCtrl,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Re-type your password';
                  } else if (_changePasswordController.newPassCtrl.text !=
                      value) {
                    return "Password don't matched";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),

              /// Confirm button
              verticalSpacing(30.h),
              CustomButton(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await _changePasswordController.resetPassword();
                    showStatusOnChangePasswordResponse(context);
                  }
                },
                text: AppString.confirmText,
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showStatusOnChangePasswordResponse(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0.r)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return ShowStatusOnChangePassItem(
          onTap: () {
            Get.toNamed(Routes.SIGN_IN);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _changePasswordController.newPassCtrl.clear();
    _changePasswordController.confirmPassCtrl.clear();
    _changePasswordController.newPassCtrl.dispose();
    _changePasswordController.confirmPassCtrl.dispose();
    super.dispose();
  }
}
