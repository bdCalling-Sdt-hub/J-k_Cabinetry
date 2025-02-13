
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/settings/controllers/term_and_condition.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_string/app_string.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/html_view.dart';
import 'package:jk_cabinet/app/modules/settings/controllers/term_and_condition.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  final TermAndConditionController _termAndConditionController=Get.put(TermAndConditionController());
  @override
  void initState() {
    super.initState();
    _termAndConditionController.fetchTermAndCondition();
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

        title: Text(AppString.termConditionText,style: AppStyles.h2(
          family: "Schuyler",
        )),
        backgroundColor: Colors.transparent,

      ),

      body: Column(
        children: [
          Obx((){
            String termAndConditions=_termAndConditionController.content.value;
            if(_termAndConditionController.isLoading.value){
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24.w),
              child: HTMLView(htmlData: termAndConditions,),
            );
             }

          ),
        ],
      ),
    );
  }
}
