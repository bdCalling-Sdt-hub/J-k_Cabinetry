import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/common/app_constant/app_constant.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:image_picker/image_picker.dart';


class SignUpController extends GetxController {
  // TextEditingControllers for all the form fields
  TextEditingController companyNameCtrl = TextEditingController();
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController address2Ctrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController zipCodeCtrl = TextEditingController();
  TextEditingController salesRepCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  // For file upload
  //File? businessLicense;
  //File? driversLicense;

  Rxn<File> businessLicense = Rxn<File>();
  Rxn<File> driversLicense = Rxn<File>();


  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  // State and agency selection
  RxString? state = "".obs;
  RxString? agency = "".obs;
  List<String> stateList = ["State1", "State2", "State3"]; // Example
  List<String> agencyList = ["Agency1", "Agency2", "Agency3"]; // Example

  RxBool showroom = false.obs;
  final RxBool builder = false.obs;
  final RxBool designer = false.obs;
  final RxBool contractor = false.obs;
  final RxBool dealer = false.obs;

  List<String> selectedRoles = [];

  // API Call to perform sign-up
  Future<void> signUp() async {
    isLoading.value = true;

    try {
      String token = await PrefsHelper.getString(AppConstants.signInToken);

      Map<String, String> headers = {
        //'Authorization': 'Bearer $token',
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
        "zipCode": zipCodeCtrl.text.trim(),
        "salesRepresentativeName": salesRepCtrl.text.trim(),
        "email": emailCtrl.text.trim(),
        "password": passwordCtrl.text.trim(),
        "confirmPassword": confirmPasswordCtrl.text.trim(),
        "state": state?.value ?? '',
        "selectYourAgency": agency?.value ?? '',
        "showroom": showroom.value.toString(),
        "builder": builder.value.toString(),
        "designer": designer.value.toString(),
        "contractor": contractor.value.toString(),
        "dealer": dealer.value.toString(),
        "branch": 'West Coast Branch',
        "role": 'user'
      };

      var request = http.MultipartRequest('POST', Uri.parse(ApiConstants.signUpUrl),);

      request.headers.addAll(headers);
      request.fields.assignAll(body);

      // Check if any files need to be uploaded
      if (businessLicense != null) {
        imageForUpload(businessLicense.value, request, fileKey: 'businessLicense');
      }

      if (driversLicense != null) {
        imageForUpload(driversLicense.value, request, fileKey: 'driveingLicense');
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      print('Sign-up response: $responseBody');
      var decodedBody = jsonDecode(responseBody);

      if (response.statusCode == 200) {
        Get.snackbar('Success', decodedBody['message']);
        // Navigate to the next page or perform any other actions
      } else {
        Get.snackbar('Error', decodedBody['message']);
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
  }

  // Helper function to upload images
  void imageForUpload(File? selectedImage, http.MultipartRequest request, {required String fileKey}) {
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

  // Method to pick files (for Business License and Driver's License)
  Future<void> pickFile({bool isBusinessLicence = false}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File selectedFile = File(pickedFile.path);

      if (isBusinessLicence) {
        businessLicense.value = selectedFile;
      } else {
        driversLicense.value = selectedFile;
      }
    }
  }
}
