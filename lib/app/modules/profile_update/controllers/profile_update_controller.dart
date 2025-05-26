import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/app/modules/profile/model/profile_model.dart';
import 'package:jk_cabinet/common/app_constant/app_constant.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';
import 'package:jk_cabinet/main.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

import '../../../data/network_caller_pro.dart';

class ProfileUpdateController extends GetxController {
  ProfileModel? user;

  TextEditingController companyNameCtrl = TextEditingController();
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController address2Ctrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();
  TextEditingController zipCodeCtrl = TextEditingController();
  TextEditingController salesRepCtrl = TextEditingController();

  // fetch the profile details into the text field
  getProfile() {
    companyNameCtrl.text = user?.data?.companyName ?? '';
    firstNameCtrl.text = user?.data?.firstName ?? '';
    lastNameCtrl.text = user?.data?.lastName ?? '';
    phoneCtrl.text = user?.data?.phone ?? '';
    addressCtrl.text = user?.data?.address ?? '';
    address2Ctrl.text = user?.data?.addressLine2 ?? '';
    cityCtrl.text = user?.data?.city ?? '';
    stateCtrl.text = user?.data?.state ?? '';
    zipCodeCtrl.text = user?.data?.zipCode ?? '';
    salesRepCtrl.text = user?.data?.salesRepresentativeName ?? '';
  }

  // Related to profile pic
  File? selectedProfileImage;
  var profileImagePath = ''.obs;

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Rx<File?> profileImage = Rx<File?>(null);

  // Image picker method for choosing profile photo
  Future<void> pickImageFromCameraForProfilePic(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);

    if (returnImage == null) return;

    selectedProfileImage = File(returnImage.path);
    profileImagePath.value = selectedProfileImage!.path;

    update(); // Updates the UI
    print('ImagePath: ${profileImagePath.value}');
    //Get.back(); // Dismiss the image picker dialog
  }

  // pickImageFromGallery(ImageSource source) async {
  //   final returnImage = await ImagePicker().pickImage(source: source);
  //
  //   if (returnImage == null) return;
  //
  //   selectedProfileImage = File(returnImage.path);
  //   profileImagePath.value = selectedProfileImage!.path;
  //   update(); // Updates the UI
  //   print('ImagePath: ${profileImagePath.value}');
  // }

  // buildImageForUpload(File? selectedImage, http.MultipartRequest request,
  //     {required String fileKey}) {
  //   if (selectedImage != null) {
  //     final mimeType = lookupMimeType(selectedImage.path) ?? 'image/jpeg';
  //     final mimeTypeData = mimeType.split('/');
  //
  //     request.files.add(
  //       http.MultipartFile(
  //         fileKey, // This should match your API's expected file key
  //         selectedImage.readAsBytes().asStream(),
  //         selectedImage.lengthSync(),
  //         filename: selectedImage.path.split('/').last,
  //         contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
  //       ),
  //     );
  //   }
  // }

  /// the patch request for update profile
  Future<void> updateProfile({required Function(String?) callBack}) async {
    isLoading.value = true;

    try {
      String token = await PrefsHelper.getString(AppConstants.signInToken);

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      };

      Map<String, String> body = {
        "companyName": companyNameCtrl.text.trim(),
        "firstName": firstNameCtrl.text.trim(),
        "lastName": lastNameCtrl.text.trim(),
        "phone": phoneCtrl.text.trim(),
        "address": addressCtrl.text.trim(),
        "addressLine2": address2Ctrl.text.trim(),
        "city": cityCtrl.text.trim(),
        "state": stateCtrl.text.trim(),
        "zipCode": zipCodeCtrl.text.trim(),
        "salesRepresentativeName": salesRepCtrl.text.trim(),
      };

      /// previous code i did 👇
      // final imgFile = <MultipartFileBody>[
      //   if (profileImage.value?.path != null) MultipartFileBody('profileImage', profileImage.value!)
      // ];

      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(ApiConstants.updateProfileUrl),
      );

      request.headers.addAll(headers);
      request.fields.addAll(body);

      // check if an image is selected for upload
      if (selectedProfileImage != null) {
        imageForUpload(
          selectedProfileImage,
          request,
          fileKey: 'profileImage',
        );
      }

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Profile updated successfully: ${responseBody.body}');
      var decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
        return callBack(decodedBody['message'].toString());
      } else {
        print('Error: ${response.statusCode}');
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
    } finally {
      isLoading.value = false;
    }

    // final imgFile = <MultipartFileBody>[];
    // if (profileImage.value != null) {
    //   imgFile.add(
    //     MultipartFileBody(
    //       'profileImage',
    //       profileImage.value!,
    //     ),
    //   );
    // }

    // final response = await NetworkCaller2().request(
    //   url: ApiConstants.updateProfileUrl,
    //   method: HttpMethod.PATCH,
    //   body: body,
    //   //files:profileImage.value?.path != null? imgFile: <MultipartFileBody>[],
    //   files: imgFile,
    //   token: token,
    // );
    //
    // if (response.isSuccess) {
    //   Get.snackbar('Success', 'Profile updated successfully');
    // } else {
    //   errorMessage.value = response.errorMessage ?? 'An error occurred';
    //   Get.snackbar('Error', errorMessage.value);
    // }
    // isLoading.value = false;
  }

  imageForUpload(File? selectedImage, http.MultipartRequest request,
      {required String fileKey}) {
    if (selectedImage != null) {
      final mimeType = lookupMimeType(selectedImage.path) ?? 'image/jpeg';
      final mimeTypeData = mimeType.split('/');

      request.files.add(
        http.MultipartFile(
          fileKey,
          selectedImage.readAsBytes().asStream(),
          selectedImage.lengthSync(),
          filename: selectedImage.path.split('/').last,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ),
      );
    }
  }
}
