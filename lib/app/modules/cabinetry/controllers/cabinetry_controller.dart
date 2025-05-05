import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/app/modules/cabinetry/model/cabinetry_model.dart';
import 'package:http/http.dart' as http;

class CabinetryController extends GetxController {
  Rx<CabinetryModel> cabinetryModel = CabinetryModel().obs;
  RxBool isLoading= false.obs;


  fetchCabinetry(String branchId) async {
    isLoading.value = true;
    try {

      Map<String, String> headers = {
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.cabinetryUrl(branchId)));

      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);
      if (response.statusCode == 200) {
        cabinetryModel.value= CabinetryModel.fromJson(decodedBody['data']);
        print(cabinetryModel.value);
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
  }

}
