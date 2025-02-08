import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jk_cabinet/common/file_picker/media_type_image.dart';
import 'package:mime/mime.dart';

class ProfileController extends GetxController {
  File? selectedIFile;
  var filePath=''.obs;

  Future pickImageFromCamera(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;
    selectedIFile = File(returnImage.path);
    filePath.value=selectedIFile!.path;
    //  image = File(returnImage.path).readAsBytesSync();
    update();
    print('ImagesPath:$filePath');
  }



}
