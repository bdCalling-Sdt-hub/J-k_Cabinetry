import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/app/modules/bottom_menu/bottom_menu..dart';
import 'package:jk_cabinet/app/modules/cabinetry/controllers/cabinetry_controller.dart';
import 'package:jk_cabinet/app/modules/cabinetry/model/cabinetry_model.dart';
import 'package:jk_cabinet/app/modules/cabinetry/widgets/cabinet_card.dart';
import 'package:jk_cabinet/app/modules/home/controllers/home_controller.dart';
import 'package:jk_cabinet/app/modules/home/model/branch_model.dart';
import 'package:jk_cabinet/app/modules/home/widgets/topbar_contact_info.dart';
import 'package:jk_cabinet/app/modules/profile/controllers/profile_controller.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_constant/app_constant.dart';
import 'package:jk_cabinet/common/app_drawer/app_drawer.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';
import 'package:jk_cabinet/common/widgets/app_button.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_cart_floating_button.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';
import 'package:logger/logger.dart';

import '../../sign_in/controllers/sign_in_controller.dart';

class CabinetryView extends StatefulWidget {
  const CabinetryView({super.key});

  @override
  State<CabinetryView> createState() => _CabinetryViewState();
}

class _CabinetryViewState extends State<CabinetryView> {
  final HomeController homeController = Get.put(HomeController());
  final CabinetryController cabinetryController = Get.put(CabinetryController());
  final SignInController signInController = Get.put(SignInController());
  final Logger _logger = Logger();
  BranchData? branchData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__) async {
      branchData = await homeController.saveBranchInfo();
      setState(() {});
      print(branchData);
      if (branchData?.sId != null) {
        await cabinetryController.fetchCabinetry(branchData?.sId ?? '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(1),
      appBar: const CustomAppBarTitle(
        isShowChat: true,
      ),
      drawer: const AppDrawer(),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.all(12.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBarContactInfo(
              branchData: branchData,
            ),
            verticalSpacing(16.h),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 8.w),
            //   child: SearchField(),
            // ),
            // verticalSpacing(16.h),

            // H1
            Text(
              "Cabinet Lines",
              style: AppStyles.h1(color: AppColors.primaryColor),
            ),
            // H2
            Text(
              "Click on door to view available products",
              style: AppStyles.h5(color: Colors.black54),
            ),
            SizedBox(height: 16.h),

            // All cabinets list
            Obx(() {
              List<Category>? categoryList = cabinetryController.cabinetryModel.value.data?.categories ?? [];
              if (cabinetryController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (categoryList.isEmpty) {
                return const Center(child: Text('Cabinet is empty'));
              }
              return Expanded(
                child: Column(
                  children: categoryList.map(
                    (category) {
                      final cabinetItemList = category.cabinet;
                      return Expanded(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                AppButton(
                                  text: '${category.categoryName}',
                                  buttonColor: AppColors.roseTaupeColor,
                                  textStyle: AppStyles.h4(color: Colors.white),
                                ),
                                Expanded(
                                  child: Divider(
                                    height: 2.h,
                                    color: AppColors.roseTaupeColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.7,
                                ),
                                shrinkWrap: true,
                                itemCount: cabinetItemList?.length,
                                itemBuilder: (context, index) {
                                  final cabinetItems = cabinetItemList![index];
                                  final selectedCabinetId = cabinetItemList[index].id;

                                  /// Show cabinetry detail
                                  return GestureDetector(
                                    onTap: () async {
                                      final token = await PrefsHelper.getString(AppConstants.signInToken);
                                      if (token.isEmpty) {
                                        Get.snackbar('Sign In Required', 'Please sign in to view cabinet details');
                                        Get.toNamed(Routes.SHOP_ACCESS);
                                      } else {
                                        final profileController = Get.put(ProfileController());
                                        await profileController.fetchProfileData();
                                        final isVerified = profileController.profileModel.value.data?.isverified ?? false;
                                        if (isVerified) {
                                          _logger.i('cabinetId :$selectedCabinetId');
                                          Get.toNamed(Routes.CABINET_DETAIL, arguments: {'cabinetId': selectedCabinetId});
                                        } else {
                                          print('cabinetId :$selectedCabinetId');
                                          Get.snackbar('Verification Required', 'Please wait until your account is verified by an Admin');
                                          Get.toNamed(Routes.SHOP_ACCESS);
                                        }
                                      }
                                    },
                                    child: CabinetCard(
                                      image: '${ApiConstants.imageBaseUrl}${cabinetItems.imageUrl}',
                                      code: cabinetItems.code ?? 's5',
                                      colorName: cabinetItems.colorName ?? 'Grey white',
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              );
            }),
          ],
        ),
      ),
       floatingActionButton: const CustomCartFloatingButton(),
    );
  }
}
