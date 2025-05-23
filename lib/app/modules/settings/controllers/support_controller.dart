import 'dart:convert';

import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';


class SupportController extends GetxController {
  RxString errorMessage = ''.obs;
  RxString content = ''.obs;
  RxBool isLoading = false.obs;
  fetchSupport() async {
    try {
      isLoading.value=true;
      var request = http.Request('GET', Uri.parse('ApiConstants.supportUrl'));
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        List<dynamic> contentMapData= responseData['data']['attributes'] as List<dynamic>;
        String contentData= contentMapData.first['content'];
        if(contentData.isNotEmpty){
          content.value=contentData;
        }
        print(content.value);
      } else {
        print('Error>>>');
        errorMessage.value = 'Failed to load data';
      }
    } on Exception catch (error) {
      print(error.toString());
      errorMessage.value = 'Something went wrong';
    }finally {
      isLoading.value=false;
    }
  }
}
