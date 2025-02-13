import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:jk_cabinet/common/app_string/app_string.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/html_view.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
 // AboutUsController aboutUsController=Get.put(AboutUsController());

  @override
  void initState() {
    super.initState();
   // aboutUsController.fetchAboutUs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        leading: InkWell(

          onTap: (){

            Get.back();

          },
          child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.transparent,
              child: Icon(Icons.arrow_back_ios,size: 18,color: AppColors.textColor,)),
        ),

        title: Text(AppString.aboutusText,style: AppStyles.h2(family: "Schuyler",)),
        backgroundColor: Colors.transparent,

      ),
      body: Column(
        children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: HTMLView(htmlData: ''),
            )
        ],
      ),
    );
  }
}
