import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';
import '../../../data/api_constants.dart';
import '../../../../common/prefs_helper/prefs_helpers.dart';
import '../model/all_chats_model.dart';

class AllChatsController extends GetxController {
  RxList<MessageAttributes> allChats = <MessageAttributes>[].obs;
  Rx<AllChatsModel> allChatsModel = AllChatsModel().obs;
  RxBool isLoading = false.obs;
  final Logger _logger = Logger();

  @override
  void onReady() {
    super.onReady();
    fetchAllChats();
  }

  Future<void> fetchAllChats() async {
    {
      isLoading.value = true;
      try {
        String token = await PrefsHelper.getString('sign-in-token');

        Map<String, String> headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        };

        var request = http.Request(
          'GET',
          Uri.parse(
            ApiConstants.getMyChatsUrl,
          ),
        );

        request.headers.addAll(headers);
        var response = await request.send();
        var responseBody = await http.Response.fromStream(response);
        print('Response body: ${responseBody.body}');
        _logger.i('Response body: ${responseBody.body}');
        Map<String, dynamic> decodedBody = jsonDecode(responseBody.body);
        if (response.statusCode == 200) {
          allChatsModel.value = AllChatsModel.fromJson(decodedBody);
          print(allChatsModel.value);
          _logger.i(allChatsModel.value);
        } else {
          print('Error: ${response.statusCode}');
          _logger.e('Error: ${response.statusCode}');
          Get.snackbar('Failed', decodedBody['message']);
        }
      } on SocketException catch (_) {
        Get.snackbar(
          'Error',
          'No internet connection. Please check your network and try again.',
          snackPosition: SnackPosition.TOP,
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          'Something went wrong. Please try again later.',
          snackPosition: SnackPosition.TOP,
        );
        print(e);
        _logger.e(e);
      } finally {
        isLoading.value = false;
      }
    }
    // Future<void> fetchAllChats() async {
    //   isLoading.value = true;
    //   try {
    //     final token = await PrefsHelper.getString('sign-in-token');
    //     final headers = {
    //       'Authorization': 'Bearer $token',
    //       'Content-Type': 'application/json'
    //     };
    //
    //     final response = await http.get(Uri.parse(ApiConstants.getMyChatsUrl), headers: headers);
    //     if (response.statusCode == 200) {
    //       final decodedBody = json.decode(response.body);
    //       _logger.i(decodedBody);
    //       allChatsModel.value = AllChatsModel.fromJson(decodedBody);
    //       allChats.assignAll(allChatsModel.data?.results ?? []);
    //     } else {
    //       Get.snackbar('Error', 'Failed to load chats');
    //     }
    //   } catch (e) {
    //     Get.snackbar('Error', 'An error occurred: $e');
    //   } finally {
    //     isLoading.value = false;
    //   }
    // }
  }
}
