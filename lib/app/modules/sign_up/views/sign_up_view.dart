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

import '../../home/model/branch_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final SignUpController _signUpController = Get.put(SignUpController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  // RxString selectedBusinessLicense = ''.obs;
  // RxString selectedDrivingLicense = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarTitle(
        isShowText: true,
        text: 'Registration',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  controller: _signUpController.companyNameCtrl,
                ),

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
                  controller: _signUpController.lastNameCtrl,
                ),

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
                    text: "Address",
                    textStyle: AppStyles.h4(family: "Schuyler")),
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
                            controller: _signUpController.zipCodeCtrl,
                            keyboardType: TextInputType.phone,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// State Dropdown
                verticalSpacing(10.h),
                TextRequired(
                    text: "State", textStyle: AppStyles.h4(family: "Schuyler")),

                // Zip Code
                // CustomTextField(
                //   hintText: "Type zip code",
                //   contentPaddingVertical: 16.h,
                //   controller: _signUpController.zipCodeCtrl,
                // ),

                Obx(() {
                  String? value = _signUpController.state?.value;
                  return DropdownButtonFormField<String>(
                      value: value!.isNotEmpty ? value : null,
                      hint: const Text("Select State"),
                      items: _signUpController.stateList
                          .map((state) => DropdownMenuItem(
                          value: state, child: Text(state)))
                          .toList(),
                      onChanged: (value) {
                        _signUpController.state?.value = value!;
                      });
                }),

                /// Business License Upload
                verticalSpacing(10.h),
                TextRequired(
                  text: "Upload Business License/EIN/TAX ID",
                  textStyle: AppStyles.h4(family: "Schuyler"),
                ),
                verticalSpacing(10.h),
                CustomButton(
                  onTap: () {
                    _signUpController.pickFile(isBusinessLicence: true);
                  },
                  text: "Upload Business License",
                  color: Colors.grey,
                ),

                Obx(() {
                  if (_signUpController.businessLicense.value == null) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        'Please select a file',
                        style: AppStyles.h5(color: Colors.red),
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text(
                      'Selected file: ${_signUpController.businessLicense.value?.path.split('/').last}',
                      style: AppStyles.h5(color: Colors.green),
                    ),
                  );
                }),

                /// Driver's License Upload
                verticalSpacing(10.h),
                TextRequired(
                    text: "Driver’s License",
                    textStyle: AppStyles.h4(family: "Schuyler")),
                verticalSpacing(10.h),
                CustomButton(
                  onTap: () {
                    _signUpController.pickFile();
                  },
                  text: "Upload Driver’s License",
                  color: Colors.grey,
                ),

                // if (_signUpController.driversLicense.value != null)

                Obx(() {
                  if (_signUpController.driversLicense.value == null) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        'Please select a file',
                        style: AppStyles.h5(color: Colors.red),
                      ),
                    );
                  }
                  return Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                          'Selected file: ${_signUpController.driversLicense.value?.path.split('/').last}',
                          style: AppStyles.h5(color: Colors.green)));
                }),

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
                  ]
                      .map(
                        (e) => CheckboxListTile(
                      title: Text(
                        e,
                        style: AppStyles.h4(),
                      ),
                      value: _signUpController.selectedRoles.contains(e),
                      checkColor: AppColors.white,
                      activeColor: AppColors.primaryColor,
                      onChanged: (val) {
                        setState(
                              () {
                            if (e == "Showroom") {
                              _signUpController.showroom.value = val!;
                            }
                            if (e == "Builder") {
                              _signUpController.builder.value = val!;
                            }
                            if (e == "Designer") {
                              _signUpController.designer.value = val!;
                            }
                            if (e == "Contractor") {
                              _signUpController.contractor.value = val!;
                            }
                            if (e == "Dealer") {
                              _signUpController.dealer.value = val!;
                            }

                            if (val == true) {
                              _signUpController.selectedRoles.add(e);
                            } else {
                              _signUpController.selectedRoles.remove(e);
                            }
                          },
                        );
                      },
                    ),
                  )
                      .toList(),
                ),

                /// Sales Rep Name (Optional)
                verticalSpacing(10.h),
                TextRequired(
                  text: "Sales Rep Name (Optional)",
                  textStyle: AppStyles.h4(family: "Schuyler"),
                  isRequired: false,
                ),
                verticalSpacing(10.h),
                CustomTextField(
                    hintText: "Type sales rep name, if you know",
                    contentPaddingVertical: 16.h,
                    controller: _signUpController.salesRepCtrl,
                ),

                /// branch Dropdown
                verticalSpacing(10.h),
                TextRequired(
                  text: "Select your branch",
                  textStyle: AppStyles.h4(family: "Schuyler"),
                ),
                verticalSpacing(10.h),

                /// branch selection dropdown
                Obx(() {
                  return DropdownButtonFormField<BranchData>(
                      value: _signUpController.selectedBranch.value,
                      hint: const Text("Select Branch"),
                      items: _signUpController.branchList
                          .map((branch) => DropdownMenuItem<BranchData>(
                          value: branch, child: Text(branch.name ?? '')))
                          .toList(),
                      onChanged: (BranchData? selected) {
                        _signUpController.selectedBranch.value = selected!;
                        print(_signUpController.branch?.value);
                      });
                }),

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
                  isObscureText: true,
                ),

                verticalSpacing(10.h),
                TextRequired(
                    text: "Confirm Password",
                    textStyle: AppStyles.h4(family: "Schuyler")),
                verticalSpacing(10.h),
                CustomTextField(
                  hintText: "Re-type password",
                  contentPaddingVertical: 16.h,
                  controller: _signUpController.confirmPasswordCtrl,
                  isObscureText: true,
                ),

                /// Checkbox Agreement
                verticalSpacing(10.h),
                CheckboxListTile(
                  title: Text(
                    //"I agree that my information is correct",
                    "I confirm that the information provided is accurate and I am not falsifying my identity or business information. I also agree to the Terms and Conditions",
                    style: AppStyles.h5(),
                  ),
                  value: isChecked,
                  checkColor: AppColors.white,
                  activeColor: AppColors.primaryColor,
                  onChanged: (value) => setState(
                        () => isChecked = value ?? false,
                  ),
                ),

                verticalSpacing(20.h),

                /// Register Button
                Obx(() {
                  return CustomButton(
                    loading: _signUpController.isLoading.value,
                    onTap: isChecked
                        ? () {
                      if (_formKey.currentState!.validate()) {
                        _signUpController.signUp();
                      } else {
                        Get.snackbar(
                          'Error',
                          'Please fill all the required fields to proceed',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                        );
                      }
                    }
                        : () {},
                    // Provide an empty function when isChecked is false
                    text: "Register",
                    color: isChecked
                        ? AppColors.primaryColor
                        : Colors.grey, // Change color based on state
                  );
                }),

                /// Route to Sign-in Screen
                verticalSpacing(20.h),
                HaveAnAccountTextButton(
                  onTap: () => Get.toNamed(Routes.SIGN_IN),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
