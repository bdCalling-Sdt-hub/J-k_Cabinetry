import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_icons/app_icons.dart';
import 'package:jk_cabinet/common/app_images/app_images.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';

class CustomAppBarTitle extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarTitle({
    super.key,
    this.backgroundColor,
    this.textColor,
    this.notificationCount,
    this.chatOnTap, this.isShowChat = false,
  });

  final Color? backgroundColor;
  final Color? textColor;
  final String? notificationCount;
  final VoidCallback? chatOnTap;
  final bool isShowChat;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      title: Image.asset(AppImage.appLogoImg, height: 35.h),
      centerTitle: true,
      actions: [
        Padding(
          padding:  EdgeInsets.all(8.0.sp),
          child: Stack(
            children: [
              if(isShowChat)
              GestureDetector(
                onTap: chatOnTap ?? () {},
                child: SvgPicture.asset(
                  AppIcons.bubbleChatIcon,
                  height: 40.h,
                ),
              ),
              notificationCount != null && notificationCount!.isNotEmpty
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.redAccent, shape: BoxShape.circle),
                        child: Padding(
                          padding: EdgeInsets.all(1.0.sp),
                          child: Text(
                            notificationCount ?? '',
                            style: AppStyles.h6(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
