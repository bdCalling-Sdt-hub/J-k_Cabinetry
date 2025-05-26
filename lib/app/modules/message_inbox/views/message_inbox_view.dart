
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jk_cabinet/app/modules/message_inbox/controllers/message_inbox_controller.dart';
import 'package:jk_cabinet/app/modules/message_inbox/controllers/send_message_controller.dart';
import 'package:jk_cabinet/app/modules/message_inbox/model/inbox_history_model.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_icons/app_icons.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';
import 'package:jk_cabinet/common/widgets/casess_network_image.dart';
import 'package:jk_cabinet/common/widgets/custom_text_field.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';

import '../../../data/api_constants.dart';
import '../../all chats/controllers/all_chats_controller.dart';
import '../../all chats/model/all_chats_model.dart';

class MessageInboxView extends StatefulWidget {
  const MessageInboxView({super.key});

  @override
  State<MessageInboxView> createState() => _MessageInboxViewState();
}

class _MessageInboxViewState extends State<MessageInboxView> {
  final TextEditingController _msgCtrl = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final AllChatsController _allChatsController = Get.put(AllChatsController());
  final SendMessageController _sendMessageController = Get.put(SendMessageController());
  final MessageInboxController _messageInboxController = Get.put(MessageInboxController());
  final List<String> menuOptions = [/*'Delete Message',*/ 'View Profile'];

  final String? chatId = Get.arguments['chatId'];
  final RxBool _isLoading = true.obs;

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadChatData();
  }

  Future<void> _loadChatData() async {
    _isLoading.value = true;
    if (chatId != null) {
      await _messageInboxController.fetchAndListenToChatHistory();
      scrollToBottom();
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Obx(() {
                final messageAttributes = _allChatsController.allChatsModel.value.data?.attributes?.first;
                SenderId? senderId = messageAttributes?.senderId;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ios back button
                    buildInkBackButton(),
                    SizedBox(width: 10.w),

                    // Contact profile photo
                    CustomNetworkImage(
                      imageUrl: "${ApiConstants.imageBaseUrl}${senderId?.profileImage}",
                      height: 50.h,
                      width: 50.w,
                      boxShape: BoxShape.circle,
                    ),

                    SizedBox(width: 16.w),

                    // Contact name
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(senderId?.firstName ?? '',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.h3()),
                          Text(
                            '',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.h6(color: AppColors.dark2Color),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Obx(() {
                if (_isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_messageInboxController.chatMessages.isEmpty) {
                  return const Center(child: Text('No messages yet'));
                }

                return ListView.builder(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.15),
                  controller: _scrollController,
                  itemCount: _messageInboxController.chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = _messageInboxController.chatMessages[index];
                    final MessageContent? messageContent = message.messageContent;
                    final bool isSender = message.senderId?.sId == _messageInboxController.myID;

                    if (messageContent == null) {
                      return const SizedBox();
                    }

                    if (isSender) {
                      return senderBubble(context, messageContent);
                    }
                    return receiverBubble(context, messageContent);
                  },
                );
              }),
            ),
          ),

          // Message text field options
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20),
              child: Row(
                children: [
                  // File button
                  InkWell(
                    onTap: () async {
                      await _sendMessageController.pickImageFromGallery();
                    },
                    child: Container(
                      height: 55.h,
                      width: 52.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryColor.withOpacity(0.2),
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppIcons.fileIcon,
                          height: 20.h,
                          width: 20.w,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                  horizontalSpacing(8.w),

                  // Text Field
                  Expanded(
                    child: CustomTextField(
                      contentPaddingVertical: 15.h,
                      hintText: 'Type your message...',
                      controller: _msgCtrl,
                    ),
                  ),
                  SizedBox(width: 10.w),

                  // Send Message Button
                  buildSendButton()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Obx buildSendButton() {
    return Obx(() {
      if (_sendMessageController.isLoading.value) {
        return const Center(child: CupertinoActivityIndicator());
      }
      return InkWell(
        onTap: () async {
          if (_msgCtrl.text.trim().isEmpty && _sendMessageController.filePath.value.isEmpty) {
            return;
          }

         final senderId = await PrefsHelper.getString('sender-id');
          final receiverId = await PrefsHelper.getString('receiver-id');

          if (chatId != null && chatId!.isNotEmpty) {
            try {
              await _sendMessageController.sendMessage(
                receiverId: receiverId,
                chatId: chatId!,
                message: _msgCtrl.text,
                filePath: _sendMessageController.filePath.value,
              );
              _msgCtrl.clear();
              _sendMessageController.filePath.value = '';
              scrollToBottom();
            } catch (e) {
              Get.snackbar('Error', 'Failed to send message: $e');
            }
          }
        },
        child: Container(
          height: 55.h,
          width: 52.w,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryColor.withOpacity(0.2),
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              AppIcons.sendLargeIcon,
              colorFilter: const ColorFilter.mode(
                  Colors.white, BlendMode.srcIn),
              height: 25.h,
              width: 25.w,
            ),
          ),
        ),
      );
    });
  }

  InkWell buildInkBackButton() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: const CircleAvatar(
        radius: 12,
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.arrow_back_ios,
          size: 22,
          color: AppColors.textColor,
        ),
      ),
    );
  }

  // Sent Message bubble
  Widget senderBubble(BuildContext context, MessageContent message) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ChatBubble(
                clipper: ChatBubbleClipper3(
                  type: BubbleType.sendBubble,
                ),
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                backGroundColor: AppColors.primaryColor,
                elevation: 0,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.57,
                  ),
                  child: Column(
                    children: [
                      showMessage(message),
                      verticalSpacing(6.h),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Text(
                  DateFormat('hh:mm a').format(DateTime.now()),
                  style: AppStyles.h5(color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 4.w),
        Obx(() {
          final attributes = _allChatsController.allChatsModel.value.data?.attributes;
          final chat = attributes?.isNotEmpty == true
              ? attributes!.firstWhere((chat) => chat.sId == chatId, orElse: () => attributes.first)
              : null;
          final profileImage = chat?.receiverId?.profileImage ?? '';

          return CustomNetworkImage(
            imageUrl: "${ApiConstants.imageBaseUrl}$profileImage",
            height: 50.h,
            width: 50.w,
            boxShape: BoxShape.circle,
          );
        }),
      ],
    );
  }

  // Receiver Message bubble
  Widget receiverBubble(BuildContext context, MessageContent message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Obx(() {
          final attributes = _allChatsController.allChatsModel.value.data?.attributes;
          final chat = attributes?.isNotEmpty == true
              ? attributes!.firstWhere((chat) => chat.sId == chatId, orElse: () => attributes.first)
              : null;
          final profileImage = chat?.senderId?.profileImage ?? '';

          return CustomNetworkImage(
            imageUrl: "${ApiConstants.imageBaseUrl}$profileImage",
            height: 50.h,
            width: 50.w,
            boxShape: BoxShape.circle,
          );
        }),
        SizedBox(width: 4.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChatBubble(
                clipper: ChatBubbleClipper3(
                  type: BubbleType.receiverBubble,
                ),
                margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                backGroundColor: AppColors.primaryColor.withOpacity(0.3),
                elevation: 0,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.57,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      showMessage(message),
                      verticalSpacing(6.h),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  DateFormat('hh:mm a').format(DateTime.now()),
                  style: AppStyles.h5(color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget showMessage(MessageContent message) {
    if (message.messageType == 'image' && message.fileUrls != null && message.fileUrls!.isNotEmpty) {
      return CustomNetworkImage(
        imageUrl: "${ApiConstants.imageBaseUrl}${message.fileUrls!.first}",
        height: 120.h,
        width: 150.w,
        boxShape: BoxShape.rectangle,
      );
    }
    if (message.messageType == 'text' && message.text != null) {
      return Text(
        message.text!,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.start,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
