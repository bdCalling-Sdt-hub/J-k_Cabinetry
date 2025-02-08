import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';


import '../app_string/app_string.dart';
import 'custom_card.dart';
import 'custom_text_field.dart';

class SearchField extends StatelessWidget {
   SearchField({
    super.key,this.fillColor, this.suffixIcon, this.iconOnTap,
  });

  final TextEditingController searchCtrl= TextEditingController();
  final Color? fillColor;
  final IconData? suffixIcon;
  final VoidCallback? iconOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            filColor:fillColor?? AppColors.grayLight,
            contentPaddingVertical: 14.h,
            prefixIcon: Padding(
              padding:  EdgeInsets.all(8.0.sp),
              child: const Icon(
                Icons.search_outlined,
                size: 25,
                color: AppColors.primaryColor,
              ),
            ),
            suffixIcon: Padding(
              padding:  EdgeInsets.all(8.0.sp),
              child:  InkWell(
                onTap: iconOnTap??(){},
                child: Icon(suffixIcon??Icons.filter_list_outlined,
                  size: 25,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            hintText: 'Search...',
            controller: searchCtrl,
            onChange: (value){

            },
          ),
        ),
      ],
    );
  }
}