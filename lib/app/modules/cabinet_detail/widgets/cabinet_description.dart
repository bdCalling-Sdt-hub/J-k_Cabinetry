import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';

class CabinetDescription extends StatelessWidget {
  final String title;
  final String description;

  const CabinetDescription({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.h4(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            style: AppStyles.h5(),
          ),
        ],
      ),
    );
  }
}