import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/bottom_menu/bottom_menu..dart';
import 'package:jk_cabinet/app/modules/home/widgets/banner_section.dart';
import 'package:jk_cabinet/app/modules/home/widgets/contact_info.dart';
import 'package:jk_cabinet/app/modules/home/widgets/faq_section.dart';
import 'package:jk_cabinet/app/modules/home/widgets/footer.dart';
import 'package:jk_cabinet/app/modules/home/widgets/topbar_contact_info.dart';
import 'package:jk_cabinet/app/modules/home/widgets/video_section.dart';
import 'package:jk_cabinet/common/app_drawer/app_drawer.dart';
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
  late YoutubePlayerController _youtubePlayerController;

  final String cabinetVideoUrl = 'https://www.youtube.com/watch?v=7wLbZqS34ns&list=PLh0KqGKtX4oXua2PyUZe5w09z0pFQV6d-&index=16';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__){
      _showBranchSelectionDialog(context);
    });
    String videoId = YoutubePlayer.convertUrlToId(cabinetVideoUrl)!;
    _youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false)
    );

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
            TopBarContactInfo(),
            verticalSpacing(16.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SearchField(),
            ),
            verticalSpacing(16.h),
            BannerSection(),
            StepsSection(),
            VideoSection(youtubePlayerController: _youtubePlayerController,),
            ContactInfo(),
            Divider(height: 2.h, color: Colors.grey.shade400,),
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: FaqSection(),
            ),
            Footer(),
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
        String selectedBranch = "J&K New York"; // Default selection
        List<String> branchList = [
          "J&K New York",
          "J&K New Jersey",
          "J&K 3",
          "J&K 4",
          "J&K 5"
        ];
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
                  Column(
                    children: branchList.map((branch) {
                      return RadioListTile(
                          title: Text(branch),
                          value: branch,
                          groupValue: selectedBranch,
                          onChanged: (newValue) {
                            if (newValue != null && newValue != selectedBranch) {
                              setState(() {
                                selectedBranch = newValue;
                              });

                            }
                          }
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                CustomButton(
                    onTap: (){
                      Get.back();
                    }, text: 'Explore'),
              ],
            );
          },
        );
      },
    );
  }
}


























