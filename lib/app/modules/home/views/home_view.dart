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
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_drawer/app_drawer.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';
import 'package:jk_cabinet/common/widgets/custom_cart_floating_button.dart';
import 'package:jk_cabinet/common/widgets/search_field.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
      _showBranchSelectionDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(0),
      appBar: CustomAppBarTitle(
        isShowChat: true, chatOnTap: () {}, notificationCount: '40',),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx((){
              return TopBarContactInfo(branchData: homeController.selectedBranch.value,);
            }),
            verticalSpacing(16.h),
            BannerSection(),
            StepsSection(),
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

  void _showBranchSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                "Select Your Nearest Branch",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "To ensure the best experience while exploring, please choose your nearest Branch. This will also be the location you are ordering from, making your journey smoother and more relevant.",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),

                   Obx(() {
                    List<BranchData>? branchList = homeController.branchModel.value.data;
                    if (homeController.isLoading.value) {
                      return const CircularProgressIndicator();
                    }
                    if (branchList == null || branchList.isEmpty) {
                      return const Text('No Branch Found');
                    }
                    return Column(
                      children: branchList.map((branch) {
                        return RadioListTile<BranchData>(
                            title: Text(branch.name ?? ''),
                            value: branch,
                            groupValue: homeController.selectedBranch.value,
                            activeColor: AppColors.primaryColor,
                            hoverColor: AppColors.primaryColor,
                            selectedTileColor: AppColors.primaryColor.withValues(alpha: 0.3),
                           // selected: branch == homeController.selectedBranch.value,
                            onChanged: (branchValue) async {
                              if (branchValue == null) return;
                                await PrefsHelper.remove('branchInfo');
                                final branchJson = jsonEncode(branchValue.toJson());
                                await PrefsHelper.setString('branchInfo', branchJson);
                                homeController.selectedBranch.value = branchValue;
                            }
                        );
                      }).toList(),
                    );
                  }),
                ],
              ),
              /// Explore branch button
              actions: [
                CustomButton(
                    onTap: () async {
                      await  getVideo();
                      Get.back();
                    },
                    text: 'Explore'
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
        flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
      );
      setState(() {});  // Update the UI after the controller is set
    }
  }
}

