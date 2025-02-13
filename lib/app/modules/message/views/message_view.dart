import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';

import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_images/network_image%20.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/casess_network_image.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_card.dart';
import 'package:jk_cabinet/common/widgets/custom_search_field.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';


import '../controllers/message_controller.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarTitle(text: 'Message'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            /// Search
            verticalSpacing(12.h),
            CustomSearchField(
              searchCtrl: searchCtrl,
              iconOnTap: () {},
              onChanged: (value) {},
              suffixIcon: Icons.tune,
              fillColor: AppColors.primaryColor.withOpacity(0.1),
            ),

            /// Friend List
            verticalSpacing(16.h),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      Get.toNamed(Routes.MESSAGE_INBOX);
                    },
                    leading: CustomNetworkImage(
                      imageUrl: AppNetworkImage.golfPlayerImg,
                      height: 54.h,
                      width: 54.w,
                      boxShape: BoxShape.circle,
                    ),
                    title: Text(
                      'full name ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.h3(family: "Schuyler"),
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'i just sad, we may have a good. asasasasa',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.h5(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          DateFormat('hh:mm a').format(DateTime.now()),
                          style: AppStyles.h6(
                            family: "Schuyler",
                          ),
                        ),
                        verticalSpacing(8.h),
                        Container(
                          height: 20.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '9+',
                              textAlign: TextAlign.center,
                              style: AppStyles.h6(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
