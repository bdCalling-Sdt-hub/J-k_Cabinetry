import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jk_cabinet/app/modules/all%20chats/controllers/all_chats_controller.dart';
import 'package:jk_cabinet/app/modules/all%20chats/model/all_chats_model.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/casess_network_image.dart';
import 'package:jk_cabinet/common/widgets/custom_search_field.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';

import '../../../../common/date_time_formation/data_age_formation.dart';
import '../../../../common/prefs_helper/prefs_helpers.dart';
import '../../../data/api_constants.dart';



class AllChatsView extends StatefulWidget {
  const AllChatsView({super.key});

  @override
  State<AllChatsView> createState() => _AllChatsViewState();
}

class _AllChatsViewState extends State<AllChatsView> {
  final TextEditingController searchCtrl = TextEditingController();
  final AllChatsController _allChatsController = Get.put(AllChatsController());

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
            // CustomSearchField(
            //   searchCtrl: searchCtrl,
            //   iconOnTap: () {},
            //   onChanged: (value) {},
            //   suffixIcon: Icons.tune,
            //   fillColor: AppColors.primaryColor.withOpacity(0.1),
            // ),

            /// Friend List
            verticalSpacing(16.h),
            Obx(() {
              List<MessageAttributes> messageAttributes = _allChatsController.allChatsModel.value.data?.attributes ?? [];
              if(_allChatsController.isLoading.value){
                return const Center(child: CircularProgressIndicator());
              }
              else if(messageAttributes.isEmpty){
                return const Center(child: Text('No Message'));
              }

              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: messageAttributes.length,
                  itemBuilder: (context, index) {
                    MessageAttributes messageAttributeIndex = messageAttributes[index];
                   SenderId? senderId = messageAttributeIndex.senderId;
                   ReceiverId? receiverId = messageAttributeIndex.receiverId;
                   PrefsHelper.setString('sender-id', senderId?.sId ?? '');
                   PrefsHelper.setString('receiver-id', receiverId?.sId ?? ''); // this is me (user)

                    final chatId = messageAttributeIndex.sId; // chat id

                    /// OnTap Chat
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Get.toNamed(Routes.MESSAGE_INBOX, arguments: {'chatId' : chatId});
                      },

                      /// Profile pic
                      leading: CustomNetworkImage(
                        imageUrl: "${ApiConstants.imageBaseUrl}${senderId?.profileImage}",
                        height: 54.h,
                        width: 54.w,
                        boxShape: BoxShape.circle,
                      ),
                      title: Text(
                        senderId?.firstName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.h3(family: "Schuyler"),
                      ),
                      subtitle: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '',
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
                            // DataAgeFormation().formatAge(messageAttributeIndex.createdAt) ?? DateTime.now(),
                            DateFormat('hh:mm a').format(DateTime.now()),
                            style: AppStyles.h6(
                              family: "Schuyler",
                            ),
                          ),
                          verticalSpacing(8.h),
                          Container(
                            height: 20.h,
                            width: 20.w,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '',
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
              );
            }),
          ],
        ),
      ),
    );
  }
}