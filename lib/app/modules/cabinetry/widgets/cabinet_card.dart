import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/casess_network_image.dart';
import 'package:jk_cabinet/common/widgets/custom_card.dart';

class CabinetCard extends StatelessWidget {
  final String image;
  final String code;
  final String colorName;

  const CabinetCard({
    super.key,
    required this.image,
    required this.code,
    required this.colorName,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: 3.sp,
      elevation: 3,
      borderSideColor: Colors.white,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius:  BorderRadius.vertical(top: Radius.circular(10.r)),
            child: CustomNetworkImage(imageUrl: image, width: double.infinity),
          ),
        ),

        // Expanded(
        //   child: ClipRRect(
        //     borderRadius:  BorderRadius.vertical(top: Radius.circular(10.r)),
        //     child: Image.network(image, fit: BoxFit.cover, width: double.infinity),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Text(
            code,
            style: AppStyles.h5(color: Colors.brown,fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.h),
          child: Text(
            colorName,
            style: AppStyles.h5(color: Colors.black54),
          ),
        ),
      ],
    );
  }
}