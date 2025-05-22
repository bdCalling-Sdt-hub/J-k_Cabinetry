import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/bottom_menu/bottom_menu..dart';
import 'package:jk_cabinet/app/modules/home/controllers/home_controller.dart';
import 'package:jk_cabinet/app/modules/home/model/branch_model.dart';
import 'package:jk_cabinet/app/modules/home/widgets/banner_section.dart';
import 'package:jk_cabinet/app/modules/home/widgets/contact_info.dart';
import 'package:jk_cabinet/app/modules/home/widgets/faq_section.dart';
import 'package:jk_cabinet/app/modules/home/widgets/footer.dart';
import 'package:jk_cabinet/app/modules/home/widgets/topbar_contact_info.dart';
import 'package:jk_cabinet/app/modules/home/widgets/video_section.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_drawer/app_drawer.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';
import 'package:jk_cabinet/common/widgets/custom_cart_floating_button.dart';
import 'package:jk_cabinet/common/widgets/search_field.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../profile/controllers/profile_controller.dart';
import '../widgets/steps_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final HomeController homeController = Get.put(HomeController());
  String cabinetVideoUrl = 'https://www.youtube.com/watch?v=7KkvrgMk8Us';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__)async{
      await homeController.fetchBranch();
      final ProfileController profileController = Get.put(ProfileController());
      profileController.verifyLoading.value;

      // CHANGED: Removed automatic dialog showing
      // Instead, check if branch is already selected from previous session
      await _checkExistingBranchSelection();
    });
  }

  // ADDED: Method to check if user has previously selected a branch
  Future<void> _checkExistingBranchSelection() async {
    final branchData = await homeController.saveBranchInfo();
    if (branchData.youtubeLink != null) {
      await getVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(0),
      appBar: const CustomAppBarTitle(
          isShowChat: true),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CHANGED: Conditionally show either TopBarContactInfo or action buttons
            Obx(() {
              // Show TopBarContactInfo if branch is selected, otherwise show action buttons
              if (homeController.selectedBranch.value != null &&
                  homeController.selectedBranch.value.name != null) {
                return TopBarContactInfo(branchData: homeController.selectedBranch.value!);
              } else {
                return _buildActionButtons();
              }
            }),
            verticalSpacing(16.h),
            const BannerSection(),
            const StepsSection(),
            // Use Obx to reactively update the UI when the youtubePlayerController is set
            Obx(() {
              if (homeController.youtubePlayerController.value != null && homeController.youtubePlayerController.value?.initialVideoId != null) {
                return VideoSection(
                  youtubePlayerController: homeController.youtubePlayerController.value!,
                );
              } else {
                return const SizedBox.shrink();  // Show nothing if controller is null
              }
            }),
            Obx((){
              return ContactInfo(branchData: homeController.selectedBranch.value,);
            }),
            Divider(height: 2.h, color: Colors.grey.shade400,),
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: const FaqSection(),
            ),
            Obx((){
              return Footer(branchData: homeController.selectedBranch.value,);
            }),
          ],
        ),
      ),
      floatingActionButton: const CustomCartFloatingButton(),
    );
  }

  // ADDED: Widget to build the action buttons (Change Branch & Login/Registration)
  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: Colors.grey.shade100,
      child: Row(
        children: [
          // Change Branch Button
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // Show branch selection dialog when user taps Change Branch
                _showBranchSelectionDialog(context);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryColor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text(
                'Select Branch',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Login/Registration Button
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.SIGN_IN);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text(
                'Login/Registration',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // CHANGED: Modified to be called only when user manually selects "Change Branch"
  void _showBranchSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // ADDED: Allow dismissing by tapping outside
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                "Select Your Nearest Branch",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: ConstrainedBox(
                // Use ConstrainedBox to limit max height
                constraints: BoxConstraints(
                  maxHeight: 400.h,
                ),
                child: SingleChildScrollView(
                  // Enable scrolling for the entire content
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Minimize Column height
                    children: [
                      const Text(
                        "To ensure the best experience while exploring, please choose your nearest Branch. This will also be the location you are ordering from, making your journey smoother and more relevant.",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10.h),
                      Obx(() {
                        List<BranchData>? branchList = homeController.branchModel.value.data;
                        if (homeController.isLoading.value) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (branchList == null || branchList.isEmpty) {
                          return const Center(child: Text('No Branch Found'));
                        }
                        return Column(
                          mainAxisSize: MainAxisSize.min, // Minimize inner Column height
                          children: branchList.map((branch) {
                            return RadioListTile<BranchData>(
                              title: Text(
                                branch.name ?? '',
                                overflow: TextOverflow.ellipsis, // Prevent text overflow
                              ),
                              value: branch,
                              groupValue: homeController.selectedBranch.value,
                              activeColor: AppColors.primaryColor,
                              hoverColor: AppColors.primaryColor,
                              selectedTileColor: AppColors.primaryColor.withOpacity(0.3),
                              onChanged: (branchValue) async {
                                if (branchValue == null) return;
                                await PrefsHelper.remove('branchInfo');
                                final branchJson = jsonEncode(branchValue.toJson());
                                await PrefsHelper.setString('branchInfo', branchJson);
                                homeController.selectedBranch.value = branchValue;
                                setState(() {}); // Update dialog state
                              },
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              actions: [
                // ADDED: Cancel button to allow dismissing without selection
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                CustomButton(
                  onTap: () async {
                    // CHANGED: Only proceed if a branch is actually selected
                    if (homeController.selectedBranch.value != null) {
                      await getVideo();
                      Get.back();
                    } else {
                      // Show snackbar or toast if no branch selected
                      Get.snackbar(
                        'Branch Required',
                        'Please select a branch to continue',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.shade100,
                        colorText: Colors.red.shade800,
                      );
                    }
                  },
                  text: 'Explore',
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Get video data from branch info
  getVideo()async{
    final branchData = await homeController.saveBranchInfo();
    if (branchData.youtubeLink != null) {
      String? videoId = YoutubePlayer.convertUrlToId(cabinetVideoUrl);
      homeController.youtubePlayerController.value = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      );
      setState(() {});  // Update the UI after the controller is set
    }
  }
}