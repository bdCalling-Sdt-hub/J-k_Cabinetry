import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_string/app_string.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';
import 'package:jk_cabinet/common/widgets/custom_text_field.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';
import 'package:jk_cabinet/common/widgets/text_required.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordController _forgotPasswordController =
      Get.put(ForgotPasswordController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarTitle(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 4,),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppString.toEnterYourMailToResetPassText,
                  textAlign: TextAlign.center,
                  style: AppStyles.h4(color: AppColors.gray),
                ),
              ),
              const Spacer(flex: 1,),
              ///Email
              verticalSpacing(10.h),
              TextRequired(
                text: AppString.emailText,
                textStyle: AppStyles.h4(family: "Schuyler"),
              ),
              verticalSpacing(10.h),
              CustomTextField(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: const Icon(
                    Icons.mail,
                    color: AppColors.appGreyColor,
                    size: 20,
                  ),
                ),
                filColor: AppColors.textFieldFillColor,
                isEmail: true,
                keyboardType: TextInputType.emailAddress,
                contentPaddingVertical: 20.h,
                hintText: "Type your email",
                labelTextStyle:
                    const TextStyle(color: AppColors.primaryColor),
                controller: _forgotPasswordController.emailCtrl,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your email';
                  }
                  return null;
                },
              ),

              /// Action button
              verticalSpacing(30.h),
              Obx(() {
                return CustomButton(
                  loading: _forgotPasswordController.isLoading.value,
                  onTap: () async {
                    Get.toNamed(Routes.OTP,arguments: {'isResetPass':true});
                    if (_formKey.currentState!.validate()) {
                      //await _verifyEmailController.sendMail(isResetPassword);
                    }
                  },
                  text: AppString.nextText,
                  // Disable button if loading
                );
              }),
              const Spacer(flex: 8,),
            ],
          ),
        ),
      ),
    );
  }
}
