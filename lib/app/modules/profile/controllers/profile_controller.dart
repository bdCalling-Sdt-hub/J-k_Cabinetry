import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jk_cabinet/app/data/network_caller_pro.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';

import '../model/profile_model.dart';

class ProfileController extends GetxController {
  File? selectedIFile;
  var filePath = ''.obs;
  RxBool verifyLoading = false.obs;
  RxString errorMessage = ''.obs;
  Rx<ProfileModel> profileModel = ProfileModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  Future pickImageFromCamera(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;
    selectedIFile = File(returnImage.path);
    filePath.value = selectedIFile!.path;
    //  image = File(returnImage.path).readAsBytesSync();
    update();
    print('ImagesPath:$filePath');
  }

  Future<void> fetchProfileData() async {
    verifyLoading.value = true;
    var userId = await PrefsHelper.getString('user-id');
    var userToken = await PrefsHelper.getString('sign-in-token');

    final response = await NetworkCallerPro().request(
      url: ApiConstants.profileViewUrl + userId,
      method: HttpMethod.GET,
      token: userToken,);

    if (response.isSuccess) {
      profileModel.value = ProfileModel.fromJson(response.responseData);
    } else {
      errorMessage.value = response.errorMessage;
      Get.snackbar('Something went wrong', response.errorMessage);
    }
    verifyLoading.value = false;
    update();
  }
}
