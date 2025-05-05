import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/common/app_constant/app_constant.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';

import '../../../data/network_caller.dart';
import '../models/sign_in_model.dart';

class SignInController extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  //ProfileAttributes profileAttributes = ProfileAttributes();
  RxBool verifyLoading = false.obs;
  RxString errorMessage = ''.obs;

  // Future<void> login() async {
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //   };
  //
  //   var requestBody = {
  //     'email': emailCtrl.text.trim(),
  //     'password': passCtrl.text,
  //   };
  //
  //   try {
  //     verifyLoading.value = true;
  //     update();
  //
  //     Uri uri = Uri.parse(ApiConstants.logInUrl);
  //
  //     final response = await post(uri, headers: headers, body: jsonEncode(requestBody));
  //
  //     if (response.statusCode == 200) {
  //
  //     }
  //
  //   } on Exception catch (e) {
  //     errorMessage.value = 'Something went wrong';
  //   } finally {
  //     verifyLoading.value = false;
  //   }
  // }

  Future<bool> login() async {
    bool isSuccess = false;
    verifyLoading.value = true;
    update();
    final Map<String, String> requestBody = {
      'email': emailCtrl.text.trim(),
      'password': passCtrl.text,
    };

    final NetworkResponse response = await NetworkCaller().postRequest(ApiConstants.logInUrl, body: requestBody);

    if (response.isSuccess) {
      AuthSuccessModel signInModel = AuthSuccessModel.fromJson(response.responseData);
      PrefsHelper.setString(AppConstants.signInToken, signInModel.token);
      PrefsHelper.setString(AppConstants.userId, signInModel.data?.first.sId ?? '');
      signInModel.data?.first.sId;

      isSuccess = true;

    } else {
      errorMessage.value = response.errorMessage;
    }
    verifyLoading.value = false;
    update();
    return isSuccess;
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.onClose();
  }
}
