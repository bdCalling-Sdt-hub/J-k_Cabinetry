import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/data/network_caller_pro.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';

import '../../../routes/app_pages.dart';

/// This is the page where user provides the email

class ForgotPasswordController extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  var isLoading = false.obs; // Observable loading state
  RxString errorMessage = ''.obs;

  Future<void> sendMail() async {
    isLoading.value = true;

    if (emailCtrl.text.isEmpty) {
      print("Email is required");
      return;
    }
    //
    // if (isLoading.value) {
    //   return; // Prevent multiple taps
    // }

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      "email": emailCtrl.text.trim(),
    };

    print('Request URL: ${ApiConstants.emailVerificationUrl}');
    print('Request Headers: ${headers.toString()}');
    print('Request Body: ${jsonEncode(requestBody)}');

    // final url = Uri.parse(ApiConstants.emailVerificationUrl);
    // final request = http.Request('POST', url)
    //   ..headers.addAll(headers)
    //   ..body = jsonEncode(requestBody);

    // Send the request and get the streamed response
    //final streamedResponse = await request.send();

    // Convert streamed response to a regular response
    //final response = await http.Response.fromStream(streamedResponse);
    // if (response.statusCode == 200) {
    //   var responseData = jsonDecode(response.body);
    //   print('Response Data: $responseData');
    //   // Get.toNamed(Routes.otpScreen, arguments: {
    //   //   'email': emailCtrl.text,
    //   //   'isPassreset': isResetPass ?? false,
    //   // });
    // } else {
    //   print('Error: ${response.statusCode}, Message: ${response.body}');
    // }

    final response = await NetworkCallerPro().request(
      url: ApiConstants.emailVerificationUrl,
      method: HttpMethod.POST,
      body: requestBody,
    );

    if (response.isSuccess) {
      Get.toNamed(
        Routes.OTP,
        arguments: {'email': emailCtrl.text.trim()},
      );
    } else {
      errorMessage.value = response.errorMessage;
    }
    isLoading.value = false;
  }

}
