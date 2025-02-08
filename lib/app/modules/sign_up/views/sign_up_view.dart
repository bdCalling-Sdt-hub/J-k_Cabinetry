import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/sign_up/controllers/sign_up_controller.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_string/app_string.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';
import 'package:jk_cabinet/common/widgets/custom_text_field.dart';
import 'package:jk_cabinet/common/widgets/have_an_account_text_button.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';
import 'package:jk_cabinet/common/widgets/text_required.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final SignUpController _signUpController = Get.put(SignUpController());
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarTitle(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Company Name
              verticalSpacing(10.h),
              TextRequired(
                  text: AppString.companyNameText,
                  textStyle: AppStyles.h4(family: "Schuyler")),
              verticalSpacing(10.h),
              CustomTextField(
                  hintText: "Type company name",
                  contentPaddingVertical: 16.h,
                  controller: _signUpController.companyNameCtrl),

              /// First Name
              verticalSpacing(10.h),
              TextRequired(
                  text: AppString.firstNameText,
                  textStyle: AppStyles.h4(family: "Schuyler")),
              verticalSpacing(10.h),
              CustomTextField(
                  hintText: "Type first name",
                  contentPaddingVertical: 16.h,
                  controller: _signUpController.firstNameCtrl),

              /// Last Name
              verticalSpacing(10.h),
              TextRequired(
                  text: AppString.lastNameText,
                  textStyle: AppStyles.h4(family: "Schuyler")),
              verticalSpacing(10.h),
              CustomTextField(
                  hintText: "Type last name",
                  contentPaddingVertical: 16.h,
                  controller: _signUpController.lastNameCtrl),

              /// Phone Number
              verticalSpacing(10.h),
              TextRequired(
                  text: "Phone Number",
                  textStyle: AppStyles.h4(family: "Schuyler")),
              verticalSpacing(10.h),
              CustomTextField(
                  hintText: "Type phone number",
                  contentPaddingVertical: 16.h,
                  controller: _signUpController.phoneCtrl,
                  keyboardType: TextInputType.phone),

              /// Address
              verticalSpacing(10.h),
              TextRequired(
                  text: "Address", textStyle: AppStyles.h4(family: "Schuyler")),
              verticalSpacing(10.h),
              CustomTextField(
                  hintText: "Type address",
                  contentPaddingVertical: 16.h,
                  controller: _signUpController.addressCtrl),

              /// Address Line 2
              verticalSpacing(10.h),
              TextRequired(
                  text: "Address Line 2",
                  textStyle: AppStyles.h4(family: "Schuyler")),
              verticalSpacing(10.h),
              CustomTextField(
                  hintText: "Type address 2",
                  contentPaddingVertical: 16.h,
                  controller: _signUpController.address2Ctrl),

              /// City & Zip Code
              verticalSpacing(10.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextRequired(
                            text: "City",
                            textStyle: AppStyles.h4(family: "Schuyler")),
                        CustomTextField(
                            hintText: "Type city name",
                            contentPaddingVertical: 16.h,
                            controller: _signUpController.cityCtrl),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextRequired(
                            text: "Zip Code",
                            textStyle: AppStyles.h4(family: "Schuyler")),
                        CustomTextField(
                            hintText: "Type zip code",
                            contentPaddingVertical: 16.h,
                            controller: _signUpController.zipCodeCtrl),
                      ],
                    ),
                  ),
                ],
              ),

              /// State Dropdown
              verticalSpacing(10.h),
              TextRequired(
                  text: "State", textStyle: AppStyles.h4(family: "Schuyler")),
              CustomTextField(
                  hintText: "Type zip code",
                  contentPaddingVertical: 16.h,
                  controller: _signUpController.zipCodeCtrl),
              // DropdownButtonFormField<String>(
              //   value: _signUpController.state,
              //   hint: const Text("Select State"),
              //   items: _signUpController.stateList
              //       .map((state) =>
              //           DropdownMenuItem(value: state, child: Text(state)))
              //       .toList(),
              //   onChanged: (value) =>
              //       setState(() => _signUpController.state = value),
              // ),

              /// Business License Upload
              verticalSpacing(10.h),
              TextRequired(
                  text: "Upload Business License/EIN/TAX ID",
                  textStyle: AppStyles.h4(family: "Schuyler")),
              verticalSpacing(10.h),
              CustomButton(
                onTap: () {
                  _signUpController.pickFile(isBusinessLicence: true);
                }, text: "Upload Business License",color: Colors.grey,),

              /// Driver's License Upload
              verticalSpacing(10.h),
              TextRequired(
                  text: "Driver’s License",
                  textStyle: AppStyles.h4(family: "Schuyler")),
              verticalSpacing(10.h),
              CustomButton(
                  onTap: () {
                    _signUpController.pickFile();
                  }, text: "Upload Driver’s License",color: Colors.grey),

              /// Checkboxes (Multiple Selection)
              verticalSpacing(10.h),
              TextRequired(
                  text: "Check all that apply:",
                  textStyle: AppStyles.h4(family: "Schuyler")),
              verticalSpacing(10.h),
              Column(
                children: [
                  "Showroom",
                  "Builder",
                  "Designer",
                  "Contractor",
                  "Dealer"
                ].map((e) => CheckboxListTile(
                          title: Text(e,style: AppStyles.h4(),),
                          value: _signUpController.selectedRoles.contains(e),
                          checkColor: AppColors.white,
                          activeColor: AppColors.primaryColor,
                          onChanged: (val) {
                            setState(() {
                              if (val == true) {
                                _signUpController.selectedRoles.add(e);
                              } else {
                                _signUpController.selectedRoles.remove(e);
                              }
                            });
                          },
                        ))
                    .toList(),
              ),

              /// Sales Rep Name (Optional)
              verticalSpacing(10.h),
              TextRequired(
                  text: "Sales Rep Name (Optional)",
                  textStyle: AppStyles.h4(family: "Schuyler")),
              verticalSpacing(10.h),
              CustomTextField(
                  hintText: "Type sales rep name, if you know",
                  contentPaddingVertical: 16.h,
                  controller: _signUpController.salesRepCtrl),

              /// Agency Dropdown
              verticalSpacing(10.h),
              TextRequired(
                  text: "Select your agency",
                  textStyle: AppStyles.h4(family: "Schuyler")),
              verticalSpacing(10.h),
              DropdownButtonFormField<String>(
                value: _signUpController.agency,
                hint: const Text("Select Agency"),
                items: _signUpController.agencyList
                    .map((agency) =>
                        DropdownMenuItem(value: agency, child: Text(agency))).toList(),
                onChanged: (value) =>
                    setState(() => _signUpController.agency = value),
              ),

              /// Email
              verticalSpacing(10.h),
              TextRequired(
                  text: "Email", textStyle: AppStyles.h4(family: "Schuyler")),
              verticalSpacing(10.h),
              CustomTextField(
                  hintText: "Type email",
                  controller: _signUpController.emailCtrl,
                  contentPaddingVertical: 16.h,
                  keyboardType: TextInputType.emailAddress),

              /// Password & Confirm Password
              verticalSpacing(10.h),
              TextRequired(
                  text: "New Password",
                  textStyle: AppStyles.h4(family: "Schuyler")),
              verticalSpacing(10.h),
              CustomTextField(
                  hintText: "Type password",
                  contentPaddingVertical: 16.h,
                  controller: _signUpController.passwordCtrl,
                  isObscureText: true),

              verticalSpacing(10.h),
              TextRequired(
                  text: "Confirm Password",
                  textStyle: AppStyles.h4(family: "Schuyler")),
              verticalSpacing(10.h),
              CustomTextField(
                  hintText: "Re-type password",
                  contentPaddingVertical: 16.h,
                  controller: _signUpController.confirmPasswordCtrl,
                  isObscureText: true),

              /// Checkbox Agreement
              verticalSpacing(10.h),
              CheckboxListTile(
                title: Text("I agree that my information is correct",style: AppStyles.h5(),),
                value: isChecked,
                checkColor: AppColors.white,
                activeColor: AppColors.primaryColor,
                onChanged: (value) =>
                    setState(() => isChecked = value ?? false),
              ),

              /// Register Button
              verticalSpacing(20.h),
              CustomButton(onTap: () {
                Get.toNamed(Routes.PROFILE);
              }, text: "Register"),

              /// Route to Sign-in Screen
              verticalSpacing(20.h),
              HaveAnAccountTextButton(onTap: () => Get.toNamed(Routes.SIGN_IN)),
            ],
          ),
        ),
      ),
    );
  }
}
