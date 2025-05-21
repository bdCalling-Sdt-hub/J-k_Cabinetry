import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/data/external_url.dart';
import 'package:jk_cabinet/app/modules/cart/controllers/cart_controller.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_constant/app_constant.dart';
import 'package:jk_cabinet/common/app_icons/app_icons.dart';
import 'package:jk_cabinet/common/app_string/app_string.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';
import 'package:jk_cabinet/common/url_luncher/externer_url_luncher.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final CartController _cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    List<String> qualityList = [
      'Commitment To Quality',
      'Maintenance & Care',
      'Standard Features',
      'Craftsmanship',
      'Sustainability',
    ];
    return Drawer(
      width: 270.w,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Menu',
                      style: AppStyles.h2(fontWeight: FontWeight.w500)),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.close)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Wrap(
                runSpacing: 2,
                children: [
                  ListTile(
                    title: Text(
                      'Login',
                      style: AppStyles.h3(),
                    ),
                    horizontalTitleGap: 20.w,
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(Routes.SIGN_IN);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Home',
                      style: AppStyles.h3(),
                    ),
                    horizontalTitleGap: 20.w,
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(Routes.HOME);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Shop Cabinet Lines',
                      style: AppStyles.h3(),
                    ),
                    horizontalTitleGap: 20.w,
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(Routes.CABINETRY);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Cabinetry Specs',
                      style: AppStyles.h3(),
                    ),
                    horizontalTitleGap: 20.w,
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(Routes.CABINETRYSPEC);
                    },
                  ),
                  ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    title: Text(
                      'Our quality',
                      style: AppStyles.h4(fontWeight: FontWeight.bold),
                    ),
                    children: List.generate(
                      qualityList.length,
                          (index) {
                        return InkWell(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.toNamed(Routes.COMMITMENTTOQULATITY);
                                break;

                              case 1:
                                Get.toNamed(Routes.MAINTENANCEANDCARE);
                                break;

                              case 2:
                                Get.toNamed(Routes.STANDARDFEATURES);
                                break;

                              case 3:
                                Get.toNamed(Routes.CRAFTSMANSHIP);
                                break;

                              case 4:
                                Get.toNamed(Routes.SUSTAINABILITY);
                                break;

                              default:
                                print("Invalid selection");
                                break;
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Text(
                              qualityList[index],
                              style: AppStyles.h5(fontWeight: FontWeight.w400),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Registration',
                      style: AppStyles.h3(),
                    ),
                    horizontalTitleGap: 20.w,
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(Routes.SIGN_UP);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Cart',
                      style: AppStyles.h3(),
                    ),
                    horizontalTitleGap: 20.w,
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(Routes.CART);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Settings',
                      style: AppStyles.h3(),
                    ),
                    horizontalTitleGap: 20.w,
                    onTap: () {
                      Navigator.pop(context);
                      ExternalUrlLauncher.lunchUrl(
                          ExternalUrl.termsAndConditionsUrl);
                      Get.toNamed(Routes.SETTINGS);
                    },
                  ),

                  // sign out
                  ListTile(
                    title: Text(
                      AppString.signOutText,
                      style: AppStyles.h3(color: Colors.redAccent),
                    ),
                    leading: SvgPicture.asset(
                      AppIcons.logOutIcon,
                      height: 32.h,
                      colorFilter: const ColorFilter.mode(
                        Colors.redAccent,
                        BlendMode.srcIn,
                      ),
                    ),
                    horizontalTitleGap: 20.w,
                    onTap: () async {
                      await PrefsHelper.remove(AppConstants.signInToken);
                      await PrefsHelper.remove(AppConstants.userId);
                      PrefsHelper.remove('user_verification_status');
                      await _cartController.clearCart();
                      Get.toNamed(Routes.SIGN_IN);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80.h,
            )
          ],
        ),
      ),
    );
  }
}
