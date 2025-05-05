import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jk_cabinet/app/data/network_caller_pro.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/prefs_helper/prefs_helpers.dart';
import '../../../routes/app_pages.dart';

class ChangePasswordController extends GetxController {
  TextEditingController newPassCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  final String email = Get.arguments['email'] ?? '';

  Future<void> resetPassword() async {
    isLoading.value = true;
    update();

    final requestBody = {
      "newPassword": newPassCtrl.text,
      "confirmNewPassword": confirmPassCtrl.text,
    };

    final response = await NetworkCallerPro().request(
      url: ApiConstants.resetPasswordUrl(email),
      method: HttpMethod.PATCH,
      body: requestBody,
    );

    if (response.isSuccess) {
      await PrefsHelper.remove(AppConstants.signInToken);
      await PrefsHelper.remove(AppConstants.userId);
      //Get.toNamed(Routes.SIGN_IN);
    }
  }

  @override
  void onClose() {
    // newPassCtrl.clear();
    // confirmPassCtrl.clear();
    newPassCtrl.dispose();
    confirmPassCtrl.dispose();
    super.onClose();
  }
}
