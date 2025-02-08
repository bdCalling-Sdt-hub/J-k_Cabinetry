import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_card.dart';

class CabinetCard extends StatelessWidget {
  final String image;
  final String price;
  final String color;

  const CabinetCard({
    super.key,
    required this.image,
    required this.price,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      elevation: 3,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius:  BorderRadius.vertical(top: Radius.circular(10.r)),
            child: Image.network(image, fit: BoxFit.cover, width: double.infinity),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Text(
            price,
            style: AppStyles.h5(color: Colors.brown,fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.h),
          child: Text(
            color,
            style: AppStyles.h5(color: Colors.black54),
          ),
        ),
      ],
    );
  }
}