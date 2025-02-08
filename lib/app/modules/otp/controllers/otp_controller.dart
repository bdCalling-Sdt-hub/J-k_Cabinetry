import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';

class OtpController extends GetxController {
  TextEditingController otpCtrl = TextEditingController();
  //ProfileAttributes profileAttributes = ProfileAttributes();
  RxString otpErrorMessage=''.obs;
  var verifyLoading = false.obs;

  Future<void> sendOtp(bool? isResetPass) async {
    Map<String,String> headers = {
      'Content-Type': 'application/json',
    };
    try {
      verifyLoading.value=true;
      var body = {'email': Get.arguments['email'].toString() ,'oneTimeCode':otpCtrl.text };
      var response = await http.post(Uri.parse(ApiConstants.verifyEmailWithOtpUrl), body:  jsonEncode(body),headers: headers);
      final responseData = jsonDecode( response.body);
      if (response.statusCode == 200) {
        // profileAttributes= ProfileAttributes.fromJson(responseData['data']['attributes']);
        // print(profileAttributes.toString());
        // await PrefsHelper.setString('token', profileAttributes.tokens!.access?.token);
        String token = await PrefsHelper.getString('token');
        print(token);

        if(isResetPass==true){
          // Get.toNamed(Routes.passwordChangeScreen,arguments: {'email': Get.arguments['email']});
        }else{
          Get.toNamed(Routes.SIGN_IN);
        }

      } else {
        print('Error>>>');
        print('Error>>>${response.body}');
        otpErrorMessage.value = responseData['message'];
        Get.snackbar(otpErrorMessage.value.toString(), '');
      }
    } on Exception catch (e) {
      otpErrorMessage.value='$e';
      Get.snackbar(otpErrorMessage.value.toString(), '');
    }finally{
      verifyLoading.value=false;
    }
  }
  @override
  void onClose() {
    otpCtrl.dispose();
    super.onClose();
  }
}
