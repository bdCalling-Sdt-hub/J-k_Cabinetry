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
import 'package:jk_cabinet/common/widgets/spacing.dart';
import 'package:jk_cabinet/common/widgets/text_required.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends StatefulWidget{
   const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final ChangePasswordController _changePasswordController=Get.put(ChangePasswordController());

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
              Spacer(flex: 1,),
              ///Password
              verticalSpacing(20.h),
              TextRequired(text:AppString.passawordText,
                textStyle: AppStyles.h4(family: "Schuyler"),
              ),
              verticalSpacing(10.h),
              CustomTextField(
                filColor: AppColors.textFieldFillColor,
                suffixIconColor: AppColors.appGreyColor,
                prefixIcon: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.w),
                  child: SvgPicture.asset(AppIcons.lockIcon),
                ),
                contentPaddingVertical: 20.h,
                hintText: "Type a password",
                labelTextStyle:
                const TextStyle(color: AppColors.primaryColor),
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
              TextRequired(text:AppString.confirmPasswordText,
                textStyle: AppStyles.h4(family: "Schuyler"),
              ),
              verticalSpacing(10.h),
              CustomTextField(
                filColor: AppColors.textFieldFillColor,
                suffixIconColor: AppColors.appGreyColor,
                prefixIcon: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.w),
                  child: SvgPicture.asset(AppIcons.lockIcon),
                ),
                contentPaddingVertical: 20.h,
                hintText: "Re-type your password",
                labelTextStyle:
                const TextStyle(color: AppColors.primaryColor),
                isObscureText: true,
                obscure: '*',
                isPassword: true,
                controller: _changePasswordController.confirmPassCtrl,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Re-type your password';
                  }else if(_changePasswordController.newPassCtrl.text != value){
                    return "Password don't matched";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),

              /// Action button
              verticalSpacing(30.h),
              CustomButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      //await otpController.sendOtp(isResetPassword);
                      Get.offNamed(Routes.SIGN_IN);
                    }
                  },
                  text: AppString.confirmText),
              Spacer(flex: 2,),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _changePasswordController.newPassCtrl.clear();
    _changePasswordController.confirmPassCtrl.clear();
    super.dispose();
  }
}
