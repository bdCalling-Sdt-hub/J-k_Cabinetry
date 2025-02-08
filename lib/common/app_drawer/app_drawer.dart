import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_icons/app_icons.dart';
import 'package:jk_cabinet/common/app_string/app_string.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

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
              child: Wrap(runSpacing: 2, children: [
                ListTile(
                  title: Text(
                    'Login',
                    style: AppStyles.h3(),
                  ),
                  leading: Icon(Icons.person_outline),
                  horizontalTitleGap: 20.w,
                  onTap: () {
                    Navigator.pop(context);
                   // Get.toNamed(Routes.PROFILE);
                  },
                ),
                ListTile(
                  title: Text('Home',
                    style: AppStyles.h3(),
                  ),
                  leading: Icon(Icons.event_note_outlined),
                  horizontalTitleGap: 20.w,
                  onTap: () {
                    Navigator.pop(context);
                   // Get.toNamed(Routes.EVENT_LIST);
                  },
                ),
                ListTile(
                  title: Text('Shop Cabinet Lines',
                    style: AppStyles.h3(),
                  ),
                  leading: Icon(Icons.notifications_none_outlined),
                  horizontalTitleGap: 20.w,
                  onTap: () {
                    Navigator.pop(context);
                   // Get.toNamed(Routes.NOTIFICATION);
                  },
                ),
                ListTile(
                  title: Text('Cabinetry Specs',
                    style: AppStyles.h3(),
                  ),
                  leading: Icon(Icons.contact_support_outlined),
                  horizontalTitleGap: 20.w,
                  onTap: () {
                    Navigator.pop(context);
                    //Get.toNamed(Routes.SUPPORT);
                  },
                ),
                ExpansionTile(
                  leading: const Icon(Icons.school_outlined),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    title: Text('Our quality',style:  AppStyles.h4(fontWeight: FontWeight.bold),),
                  children: qualityList.map((qualityItem){
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text(qualityItem,style:  AppStyles.h5(fontWeight: FontWeight.w400),),
                    );
                  }).toList(),
                ),

                ListTile(
                  title: Text(
                    'Registration',
                    style: AppStyles.h3(),
                  ),
                  leading: Icon(Icons.shopping_cart_outlined),
                  horizontalTitleGap: 20.w,
                  onTap: () {
                    Navigator.pop(context);
                   // ExternalUrlLauncher.lunchUrl(ExternalUrl.shopUrl);
                  },
                ),
                ListTile(
                  title: Text('Cart',
                    style: AppStyles.h3(),
                  ),
                  leading: Icon(Icons.privacy_tip_outlined),
                  horizontalTitleGap: 20.w,
                  onTap: () {
                    Navigator.pop(context);
                   // ExternalUrlLauncher.lunchUrl(ExternalUrl.privacyPolicyUrl);
                  },
                ),
                ListTile(
                  title: Text(
                    'Settings',
                    style: AppStyles.h3(),
                  ),
                  leading: SvgPicture.asset(
                    AppIcons.termConditionIcon,
                    height: 32.h,
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                  horizontalTitleGap: 20.w,
                  onTap: () {
                    Navigator.pop(context);
                    //ExternalUrlLauncher.lunchUrl(ExternalUrl.termsAndConditionsUrl);
                  },
                ),
                ListTile(
                  title: Text(
                    AppString.signOutText,
                    style: AppStyles.h3(color: Colors.redAccent),
                  ),
                  leading: SvgPicture.asset(
                    AppIcons.logOutIcon,
                    height: 32.h,
                    colorFilter: const ColorFilter.mode(
                        Colors.redAccent, BlendMode.srcIn),
                  ),
                  horizontalTitleGap: 20.w,
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(Routes.HOME);
                  },
                ),
              ]),
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
