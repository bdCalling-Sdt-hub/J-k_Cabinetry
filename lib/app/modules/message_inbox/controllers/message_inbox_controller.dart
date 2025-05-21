import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jk_cabinet/common/app_constant/app_constant.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../common/prefs_helper/prefs_helpers.dart';
import '../../../data/api_constants.dart';
import '../model/inbox_history_model.dart';

class MessageInboxController extends GetxController {
  RxList<MessageAttributes> chatMessages = <MessageAttributes>[].obs;
  Rx<InboxHistoryModel> inboxHistoryList = InboxHistoryModel().obs;
  String chatId = Get.arguments['chatId'];
  RxBool isLoading = false.obs;
  final Logger _logger = Logger();

  late IO.Socket _socket;
  String? myID;

  @override
  void onInit() async {
    super.onInit();
    /// todo: figure out which one is actually your id!
    myID = await PrefsHelper.getString(AppConstants.userId);
    // myID = await PrefsHelper.getString('sender-id');
    initSocket();
  }

  // void setChatId(String id) {
  //   chatId= id;
  // }
  void addNewMessage(MessageAttributes message) {
    // Ensure we don't add duplicates
    if (!chatMessages.any((m) => m.sId == message.sId)) {
      chatMessages.add(message);
      chatMessages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      update();
    }
  }

  Future<void> fetchAndListenToChatHistory() async {
    // if (chatId.isEmpty) return;
    isLoading.value = true;

    try {
      final messages = await fetchChatHistory(chatId);
      chatMessages.assignAll(messages);
      //Todo: joybangla korte hobe
      // listenToNewMessages(chatId);
    } catch (e) {
      print('Error fetching chat history: $e');
    } finally {
      isLoading.value = false;
    }
  }


  /// =============== fetch_chat_history =================
  Future<List<MessageAttributes>> fetchChatHistory(String chatRoomId) async {
    String token = await PrefsHelper.getString('sign-in-token');
    final headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(Uri.parse(ApiConstants.getMyMessagesUrl(chatRoomId)), headers: headers);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      inboxHistoryList.value = InboxHistoryModel.fromJson(decoded);
      _logger.i('====>>>Status Code: ${response.statusCode}, response body===>>>$decoded');
      return inboxHistoryList.value.data?.results ?? [];
    } else {
      _logger.e('Failed to load chat history: ${response.statusCode}');
      throw Exception('Failed to load chat history');
    }
  }

  void initSocket() {
    _socket = IO.io(
      ApiConstants.socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    _socket.connect();

    _socket.onConnect((_) {
      print('Socket connected');
      _logger.i('====Socket Connected to the server=====');
      if (chatId.isNotEmpty) {

        //Todo: joybangla korte hobe
      //  listenToNewMessages(chatId);
      }
    });

    _socket.onDisconnect((_) {
      _logger.i('=======Socket disconnected========');
    });
  }

  void listenToNewMessages(String chatId) {
    final eventName = 'new-message::$chatId';

    _socket.off(eventName);
    _socket.on(eventName, (data) {
      if (data == null) return;

      try {
        final decoded = data['data'];
        if (decoded == null) return;

        final newMessage = MessageAttributes.fromJson(decoded);
        chatMessages.add(newMessage);
        scrollToBottom();
      } catch (e) {
        _logger.e('Error parsing new message data: $e');
      }
    });
  }


  ///================================================== Send_message  =======================================
  void sendEmitMessage({
    required String message,
    required String media,
    required String messageType,
  }) {
    final senderId = myID;
    if (senderId == null || chatId.isEmpty) {
      print('Sender ID or Chat ID missing');
      return;
    }

    Map<String, dynamic> messageData = {
      'roomId': chatId,
      'senderId': senderId,
      'message': message,
      'media': media,
      'messageType': messageType,
    };

    _socket.emit('send-message', messageData);
  }

  void scrollToBottom() {
    // Implement your scroll controller logic or notify UI
  }

  @override
  void onClose() {
    _socket.dispose();
    // chatMessages.clear();
    super.onClose();
  }
}
