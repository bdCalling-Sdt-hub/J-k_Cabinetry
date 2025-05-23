import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/app/modules/profile/controllers/profile_controller.dart';
import 'package:jk_cabinet/app/modules/sign_in/controllers/sign_in_controller.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_page_loading.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';

import '../../../../common/widgets/custom_outlinebutton.dart';

class ProfileView extends StatelessWidget {
  // final ProfileController _profileController = Get.find();
  final ProfileController _profileController = Get.put(ProfileController());
  final SignInController _signInController = Get.put(SignInController());
  // final SignInController _signInController = Get.find<SignInController>();

  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarTitle(
        isShowText: true,
        text: 'Profile',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _profileController.fetchProfileData();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Profile photo with Edit Button
                    Obx(
                      () {
                        if (_profileController.profileModel.value.data != null) {
                          return CircleAvatar(
                            radius: 60.r,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              ApiConstants.baseUrl +
                                  _profileController
                                      .profileModel.value.data!.profileImage!,
                            ),
                          );
                        }
                        else {
                          return CircleAvatar(
                          radius: 60.r,
                          backgroundColor: Colors.grey,
                          child: const Icon(
                            Icons.person,
                            size: 20,
                          ),
                        );
                        }
                      },
                    ),
                    horizontalSpacing(14.w),

                    /// Profile name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () {
                            if (_profileController.profileModel.value.data ==
                                null) {
                              return Text(
                                '...',
                                style: AppStyles.h3(),
                              );
                            } else {
                              return Text(
                                _profileController
                                        .profileModel.value.data!.firstName ??
                                    '',
                                style: AppStyles.h3(),
                              );
                            }
                          },
                        ),
                        horizontalSpacing(8.w),

                        /// Edit Button
                        ElevatedButton.icon(
                          onPressed: () {
                            Get.toNamed(Routes.PROFILE_UPDATE);
                          },
                          icon: Icon(Icons.edit, size: 16.sp),
                          label: Text("Edit Profile", style: AppStyles.h5()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 8.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 15.h),

                /// Profile Information
                Obx(() {
                  if (_profileController.profileModel.value.data == null) {
                    return const CustomPageLoading();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _profileDetail(
                          "Company Name",
                          _profileController.profileModel.value.data!.companyName
                              .toString()),
                      _profileDetail(
                          "First Name",
                          _profileController.profileModel.value.data!.firstName
                              .toString()),
                      _profileDetail(
                          "Last Name",
                          _profileController.profileModel.value.data!.lastName
                              .toString()),
                      _profileDetail(
                          "Phone Number",
                          _profileController.profileModel.value.data!.phone
                              .toString()),
                      _profileDetail(
                          "Address",
                          _profileController.profileModel.value.data!.address
                              .toString()),
                      _profileDetail(
                          "Address Line 2",
                          _profileController.profileModel.value.data!.addressLine2
                              .toString()),
                      _profileDetail(
                          "State",
                          _profileController.profileModel.value.data!.state
                              .toString()),
                      _profileDetail(
                          "City",
                          _profileController.profileModel.value.data!.city
                              .toString()),
                      _profileDetail(
                          "Zip Code",
                          _profileController.profileModel.value.data!.zipCode
                              .toString()),

                      /// Document Verification
                      _verifiedStatus(),

                      _profileDetail(
                          "Sales Rep. Name",
                          _profileController
                              .profileModel.value.data!.salesRepresentativeName
                              .toString()),
                      _profileDetail(
                          "Email",
                          _profileController.profileModel.value.data!.email
                              .toString()),
                    ],
                  );
                }),

                SizedBox(height: 20.h),

                // Reset password button
                CustomOutlineButton(
                  onTap: () {
                    Get.toNamed(Routes.FORGOT_PASSWORD);
                  },
                  text: "Change Password",
                ),
              ],
            ),
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
          Text("Documents:", style: AppStyles.h5(fontWeight: FontWeight.bold)),
          SizedBox(width: 5.w),
          Obx(() {
            final isVerified = _profileController.profileModel.value.data?.isverified ?? false;
            return isVerified
                ? Row(children: [
                    Icon(Icons.verified, color: Colors.green, size: 18.sp),
                    SizedBox(width: 5.w),
                    Text("Verified", style: AppStyles.h5(color: Colors.green)),
                  ])
                : Row(children: [
                    Icon(Icons.cancel, color: Colors.red, size: 18.sp),
                    SizedBox(width: 5.w),
                    Text("Not Verified", style: AppStyles.h5(color: Colors.red)),
                  ]);
          }),
        ],
      ),
    );
  }
}
