import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {

  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController companyNameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController address2Ctrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();
  TextEditingController zipCodeCtrl = TextEditingController();
  TextEditingController salesRepCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

   String? state;
   List<String> stateList = ["Select State", "New York", "California", "Texas"]; // Add required states

   String? agency;
   List<String> agencyList = ["J&K New York", "J&K California"]; // Add required agencies

   List<String> selectedRoles = [];

   Rx<File?> businessLicence= Rx<File?>(null);
   Rx<File?> driverLicence= Rx<File?>(null);

  pickFile({bool isBusinessLicence = false}) async {
    FilePickerResult? results = await FilePicker.platform.pickFiles();
    if (results != null && results.files.single.path != null) {
      File file = File(results.files.single.path!);
      if (isBusinessLicence) {
        businessLicence.value = file;
        if(businessLicence.value!.path.isNotEmpty){
          Get.snackbar('Business Licence File Selected', businessLicence.value!.path);
        }
      } else {
        driverLicence.value = file;
        if(driverLicence.value!.path.isNotEmpty){
          Get.snackbar('Driver Licence File Selected', driverLicence.value!.path);
        }
      }
    }
  }


}
