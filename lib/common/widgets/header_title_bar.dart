import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';

import 'app_button.dart';

class HeaderTitleBar extends StatelessWidget {
  final String title;
  const HeaderTitleBar({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppButton(text: title,buttonColor:AppColors.roseTaupeColor,textStyle: AppStyles.h4(color: Colors.white),),
        Expanded(child: Divider(height: 2.h,color: AppColors.roseTaupeColor,))
      ],
    );
  }
}