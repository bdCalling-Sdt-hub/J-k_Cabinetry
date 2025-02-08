import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function()? onTab;
  final double? height;
  final double? width;
  final bool? isBorderActive;
  final Color? borderColors;
  final Color? buttonColor;
  final double? containerVerticalPadding;
  final double? containerHorizontalPadding;
  final bool? isIconWithTextActive;
  final String? iconPath;
  final TextStyle? textStyle;

  const AppButton(
      {super.key,
      required this.text,
       this.onTab,
      this.height,
      this.width,
      this.isBorderActive = false,
      this.borderColors,
      this.buttonColor,
      this.containerVerticalPadding,
      this.containerHorizontalPadding,
      this.isIconWithTextActive = false, this.iconPath, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab??(){},
      child: Container(
        height: height?.h,
        width: width?.w,
        padding: EdgeInsets.symmetric(
            vertical: containerVerticalPadding?.h ?? 7.h,
            horizontal: containerHorizontalPadding?.w ?? 7.w),
        // Button padding
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
          border: isBorderActive == true
              ? Border.all(
                  color: borderColors ?? Colors.white,
                  width: 2, // Border width
                )
              : const Border.fromBorderSide(BorderSide.none),
        ),
        child:isIconWithTextActive==true
            ?Row(
          children: [
            SvgPicture.asset(iconPath??'',height: 17,),
            SizedBox(width: 5.w),
            Text(text,
              style:textStyle?? AppStyles.h4(),
              textAlign: TextAlign.center,
            )
          ],
        ) :Text(
          text,
          style:textStyle?? AppStyles.h4(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
