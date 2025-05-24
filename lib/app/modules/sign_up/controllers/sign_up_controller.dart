import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_constant/app_constant.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/services/branch_service.dart';
import '../../home/model/branch_model.dart';


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

  // State and branch selection
  RxString? state = "".obs;
  List<String> stateList = [
    "Alabama",
    "Alaska",
    "Arizona",
    "Arkansas",
    "California",
    "Colorado",
    "Connecticut",
    "Delaware",
    "Florida",
    "Georgia",
    "Hawaii",
    "Idaho",
    "Illinois",
    "Indiana",
    "Iowa",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Maine",
    "Maryland",
    "Massachusetts",
    "Michigan",
    "Minnesota",
    "Mississippi",
    "Missouri",
    "Montana",
    "Nebraska",
    "Nevada",
    "New Hampshire",
    "New Jersey",
    "New Mexico",
    "New York",
    "North Carolina",
    "North Dakota",
    "Ohio",
    "Oklahoma",
    "Oregon",
    "Pennsylvania",
    "Rhode Island",
    "South Carolina",
    "South Dakota",
    "Tennessee",
    "Texas",
    "Utah",
    "Vermont",
    "Virginia",
    "Washington",
    "West Virginia",
    "Wisconsin",
    "Wyoming",
    "American Samoa",
    "Guam",
    "Northern Mariana Islands",
    "Puerto Rico",
    "U.S. Virgin Islands"
  ];


  RxString? branch = "".obs;
  RxString selectedBranchId = ''.obs;
  // final Rx<Map<String, dynamic>?> selectedBranch = Rx<Map<String, dynamic>?>(null);
  // RxList<String> branchList = <String>[].obs;
  Rxn<BranchData> selectedBranch = Rxn<BranchData>();   // Store selected branch object
  RxList<BranchData> branchList = <BranchData>[].obs;  // List of BranchData objects

  RxBool showroom = false.obs;
  final RxBool builder = false.obs;
  final RxBool designer = false.obs;
  final RxBool contractor = false.obs;
  final RxBool dealer = false.obs;
  final Logger _logger = Logger();

  List<String> selectedRoles = [];

  @override
  void onInit() {
    super.onInit();
    fetchBranch();
  }

  // Fetch branches from API
  Future<void> fetchBranch() async {
    isLoading.value = true;
    try {
      final branchService = Get.find<BranchService>();
      final branches = await branchService.getBranches();
      if (branches.data != null) {
        branchList.clear();
        branchList.addAll(branches.data!);
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
      _logger.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  // API Call to perform sign-up
  Future<void> signUp() async {
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
        "zipCode": zipCodeCtrl.text.trim(),
        "salesRepresentativeName": salesRepCtrl.text.trim(),
        "email": emailCtrl.text.trim(),
        "password": passwordCtrl.text.trim(),
        "confirmPassword": confirmPasswordCtrl.text.trim(),
        "state": state?.value ?? '',
        "selectYourAgency": branch?.value ?? '',
        "showroom": showroom.value.toString(),
        "builder": builder.value.toString(),
        "designer": designer.value.toString(),
        "contractor": contractor.value.toString(),
        "dealer": dealer.value.toString(),
        "branch": selectedBranch.value?.name ?? '',/// todo: fix this
        "branchID": selectedBranch.value?.sId ?? '',
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
      _logger.i('Sign-up response: $responseBody');
      var decodedBody = jsonDecode(responseBody);

      if (response.statusCode == 200) {
        Get.snackbar('Success', decodedBody['message']);
        Get.toNamed(Routes.SIGN_IN);
        _logger.i(responseBody);
        // Navigate to the next page or perform any other actions
      } else {
        Get.snackbar('Error', decodedBody['message']);
        _logger.e(decodedBody['message']);
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
      _logger.e(e);
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
