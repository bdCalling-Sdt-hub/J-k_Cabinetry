import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/app/modules/cabinet_detail/model/cabinet_details.dart';
import 'package:http/http.dart' as http;

class CabinetDetailController extends GetxController {


  RxList<int> quantity = <int>[1].obs;

  buildItemList(int itemLength){
    quantity.value = List.generate(itemLength, (index) => 1).obs;
  }

  void increment(int index) {
    quantity[index] ++;
  }
  void decrement(int index) {
    if (quantity[index] > 1 ) {
      quantity[index] --;
    }
  }

  ///======================== Network call==================================

  Rx<CabinetDetailsModel> cabinetryDetailsModel = CabinetDetailsModel().obs;
  RxBool isLoading= false.obs;

  fetchCabinetDetails() async {
    isLoading.value = true;
    try {

      Map<String, String> headers = {
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.cabinetDetailsUrl));

      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String,dynamic> decodedBody = jsonDecode(responseBody.body);
      if (response.statusCode == 200) {
        cabinetryDetailsModel.value= CabinetDetailsModel.fromJson(decodedBody);
        print(cabinetryDetailsModel.value);
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
