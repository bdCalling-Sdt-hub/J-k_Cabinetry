import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_icons/app_icons.dart';
import 'package:jk_cabinet/common/app_images/app_images.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';

class CustomAppBarTitle extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarTitle({
    super.key,
    this.backgroundColor,
    this.textColor,
    this.isShowChat = false,
    this.isShowText = false,
    this.isShowBackButton = false,
    this.text,
    this.bottom,
  });

  final Color? backgroundColor;
  final Color? textColor;
  final bool isShowChat;
  final bool isShowText;
  final bool isShowBackButton;
  final String? text;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    // Placeholder: Replace with actual notification count from controller
    final notificationCount = ''; // TODO: Use Get.find<YourController>().notificationCount.value if reactive

    return AppBar(
      automaticallyImplyLeading: true, // Keep true to allow drawer icon when no leading widget
      // Modified: Only set leading for back button, allow default drawer icon otherwise
      // Original leading code commented out for traceability
      // leading: isShowBackButton
      //     ? GestureDetector(
      //         child: const Icon(Icons.arrow_back_ios),
      //         onTap: () {
      //           Get.back();
      //           print('Back button tapped');
      //         },
      //       )
      //     : const SizedBox.shrink(),
      leading: isShowBackButton
          ? GestureDetector(
        child: const Icon(Icons.arrow_back_ios),
        onTap: () {
          Get.back();
          print('Back button tapped');
        },
      )
          : null, // Let AppBar show drawer icon if drawer is present
      backgroundColor: backgroundColor ?? Colors.white,
      title: isShowText
          ? Text(
        text!,
        style: AppStyles.h2(),
      )
          : Image.asset(AppImage.appLogoImg, height: 35.h),
      centerTitle: true,
      bottom: bottom,
      actions: [
        if (isShowChat)
          Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.MESSAGE);
                  },
                  child: SvgPicture.asset(
                    AppIcons.bubbleChatIcon,
                    height: 40.h,
                  ),
                ),
                if (notificationCount.isNotEmpty)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16.sp,
                        minHeight: 16.sp,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(1.0.sp),
                        child: Center(
                          child: Text(
                            notificationCount,
                            style: AppStyles.h6(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}