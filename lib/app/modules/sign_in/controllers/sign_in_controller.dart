import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/common/app_constant/app_constant.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';

import '../../../../main.dart';
import '../../../data/network_caller.dart';
import '../../../routes/app_pages.dart';
import '../models/auth_success_model.dart';

class SignInController extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  Rx<AuthSuccessModel> authSuccessModel = AuthSuccessModel().obs;

  //ProfileAttributes profileAttributes = ProfileAttributes();
  RxBool verifyLoading = false.obs;
  RxBool isUserVerified = false.obs;
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
      authSuccessModel.value = AuthSuccessModel.fromJson(response.responseData);
      PrefsHelper.setString(AppConstants.signInToken, authSuccessModel.value.token);
      PrefsHelper.setString(AppConstants.userId, authSuccessModel.value.data?.first.sId ?? '');
      // authSuccessModel.value.data?.first.sId;

      // Check verification status
      isUserVerified.value = authSuccessModel.value.data?.first.isverified ?? false;
      isSuccess = true;
      Get.toNamed(Routes.HOME);
      emailCtrl.clear();
      passCtrl.clear();
    } else {
      errorMessage.value = response.errorMessage;
    }
    verifyLoading.value = false;
    update();
    return isSuccess;
  }

  @override
  void onClose() {
    emailCtrl.clear();
    passCtrl.clear();
    super.onClose();
  }
}
