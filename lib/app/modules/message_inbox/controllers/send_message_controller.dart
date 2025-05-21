import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/app/modules/message_inbox/controllers/message_inbox_controller.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';
import 'package:logger/logger.dart';

import '../model/inbox_history_model.dart';


class SendMessageController extends GetxController {
  RxString commentMessage = ''.obs;
  File? selectedIFile;
  var filePath=''.obs;
  RxBool isLoading=false.obs;
  String chatId = Get.arguments['chatId'];
  final _logger = Logger();
final MessageInboxController _messageInboxController=Get.put(MessageInboxController());
  sendMessage(
      {required String message,
      String? filePath,
      required String receiverId,
        required String chatId}) async {
    String token = await PrefsHelper.getString('sign-in-token');
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data'
    };
    Map<String, String> body = {
      'message': message ?? '',
      'chatId': chatId,
      'receiverId': receiverId,
    };

    var request =  http.MultipartRequest('POST', Uri.parse(ApiConstants.sendMessageUrl));
    request.fields.addAll(body);

    File fileData = File(filePath!);

    try {
      // Determine file type and add it to the request
      isLoading.value=true;
      if(fileData.path.isNotEmpty){
        await _addFileToRequest(request, fileData);
      }

      request.headers.addAll(headers);

      // Print request body fields and files
      print('Request Fields: ${request.fields}');
      print('Request Files: ${request.files.map((file) => file.filename)}');

      http.StreamedResponse response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == HttpStatus.ok ||response.statusCode == HttpStatus.created ) {
        var responseData = jsonDecode(responseBody);
        commentMessage.value = responseData['message'];
        var newMessage = MessageAttributes.fromJson(responseData['data']);
        _logger.e(newMessage);
        // _messageInboxController.chatMessages.add(newMessage);

        print("Response Success : $responseBody");
      } else {
        var errorData = jsonDecode(responseBody);
        commentMessage.value = errorData['message'] ?? 'Something went wrong';
        print("Response Error (${response.statusCode}): $responseBody");
        Get.snackbar('Failed', commentMessage.value);
      }
    } on Exception catch (e) {
      print(e.toString());
      commentMessage.value = 'An error occurred while uploading the file.';
      Get.snackbar('Failed', commentMessage.value);
    }finally{
      isLoading.value=false;
    }
  }

  pickImageFromGallery() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    selectedIFile = File(returnImage.path);
    filePath.value=selectedIFile!.path;
    print('ImagesPath:$filePath');
    if(filePath.value.isNotEmpty){
      Get.snackbar('File selected', '');
    }
  }

  // Helper method to add file based on its type
  _addFileToRequest(http.MultipartRequest request, File file) async {
    String fileName = file.path.split('/').last;
    String fileType = fileName.split('.').last.toLowerCase();

    if (fileType == 'png') {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        await file.readAsBytes(),
        filename: fileName,
        contentType: MediaType('image', 'png'),
      ));
      debugPrint("Media type png ==== $fileName");
    } else if (fileType == 'jpg' || fileType == 'jpeg') {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        await file.readAsBytes(),
        filename: fileName,
        contentType: MediaType('image', fileType),
      ));
      debugPrint("Media type $fileType ==== $fileName");
    } else {
      debugPrint("Unsupported media type: $fileName");
      throw Exception('Unsupported file type');
    }
  }


}
