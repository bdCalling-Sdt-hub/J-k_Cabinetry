import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class ProfileUpdateController extends GetxController {
  TextEditingController companyNameCtrl = TextEditingController(text: "No Name");
  TextEditingController firstNameCtrl = TextEditingController(text: "Mahmudur Rahman Talukder");
  TextEditingController lastNameCtrl = TextEditingController(text: "Talukder");
  TextEditingController phoneCtrl = TextEditingController(text: "+880 1770504877");
  TextEditingController addressCtrl = TextEditingController(text: "Sylhet, Moulvibazar");
  TextEditingController address2Ctrl = TextEditingController(text: "Kulaura");
  TextEditingController cityCtrl = TextEditingController(text: "Kulaura");
  TextEditingController stateCtrl = TextEditingController(text: "Kulaura");
  TextEditingController zipCodeCtrl = TextEditingController(text: "3230");
  TextEditingController salesRepCtrl = TextEditingController(text: "Nill");


  File? selectedProfileImage;
  var profileImagePath = ''.obs;

  ///For Profile Pic
   pickImageFromGallery(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);

    if (returnImage == null) return;

    selectedProfileImage = File(returnImage.path);
    profileImagePath.value = selectedProfileImage!.path;
    update(); // Updates the UI
    print('ImagePath: ${profileImagePath.value}');
  }

  buildImageForUpload(File? selectedImage, http.MultipartRequest request,
      {required String fileKey}) {
    if (selectedImage != null) {
      final mimeType = lookupMimeType(selectedImage.path) ?? 'image/jpeg';
      final mimeTypeData = mimeType.split('/');

      request.files.add(
        http.MultipartFile(
          fileKey, // This should match your API's expected file key
          selectedImage.readAsBytes().asStream(),
          selectedImage.lengthSync(),
          filename: selectedImage.path.split('/').last,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ),
      );
    }
  }

}
