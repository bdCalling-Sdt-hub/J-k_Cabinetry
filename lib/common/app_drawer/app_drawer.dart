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
                  horizontalTitleGap: 20.w,
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(Routes.SIGN_IN);
                  },
                ),
                ListTile(
                  title: Text('Home',
                    style: AppStyles.h3(),
                  ),
                  horizontalTitleGap: 20.w,
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(Routes.HOME);
                  },
                ),
                ListTile(
                  title: Text('Shop Cabinet Lines',
                    style: AppStyles.h3(),
                  ),
                  horizontalTitleGap: 20.w,
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(Routes.CABINETRY);
                  },
                ),
                ListTile(
                  title: Text('Cabinetry Specs',
                    style: AppStyles.h3(),
                  ),
                  horizontalTitleGap: 20.w,
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(Routes.CABINET_DETAIL);
                  },
                ),
                ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    title: Text('Our quality',style:  AppStyles.h4(fontWeight: FontWeight.bold),),
                  children: List.generate(
                    qualityList.length, (index) {
                      return InkWell(
                        onTap: () {
                          switch(index){
                            case 0:
                              Get.offAndToNamed(Routes.SIGN_IN);
                              break;

                              case 1:
                              Get.offAndToNamed(Routes.CART);
                              break;

                              case 2:
                              Get.offAndToNamed(Routes.CABINETRY);
                              break;

                              case 3:
                              Get.offAndToNamed(Routes.HOME);
                              break;

                              case 4:
                              Get.offAndToNamed(Routes.PROFILE);
                              break;

                            default:
                              print("Invalid selection");
                              break;

                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Text(qualityList[index],
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
                  title: Text('Cart',
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
