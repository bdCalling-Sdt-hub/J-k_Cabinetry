import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:jk_cabinet/app/modules/cabinet_detail/model/cabinet_parts_model.dart';
import '../model/cabinet_details_model.dart';

class CabinetDetailController extends GetxController {
  RxList<int> quantity = <int>[].obs;
  Rx<CabinetDetailsModel> cabinetryDetailsModel = CabinetDetailsModel().obs;

  Rx<PartResponseModel> cabinetryPartsModel = PartResponseModel().obs;
  Rx<CabinetDetailsModel> cabinetDetailsModel = CabinetDetailsModel().obs;
  RxBool isLoading = false.obs;

  // Initialize quantity list based on the total number of parts
  void initializeQuantities(List<PartData> partsData) {
    quantity.clear();
    for (var stockItem in partsData) {
      for (var category in stockItem.categoriesWithParts ?? []) {
        for (var part in category.parts ?? []) {
          quantity.add(1); // Default quantity of 1 for each part
        }
      }
    }
    quantity.refresh();
  }

  void increment(int index) {
    if (index >= 0 && index < quantity.length) {
      quantity[index]++;
      quantity.refresh();
    }
  }

  void decrement(int index) {
    if (index >= 0 && index < quantity.length && quantity[index] > 1) {
      quantity[index]--;
      quantity.refresh();
    }
  }

  ///======================== Network call==================================

  fetchCabinetParts() async {
    isLoading.value = true;
    String cabinetId = Get.arguments['cabinetId'];
    print(cabinetId);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.cabinetPartsUrl));
      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String, dynamic> decodedBody = jsonDecode(responseBody.body);
      if (response.statusCode == 200) {
        cabinetryPartsModel.value = PartResponseModel.fromJson(decodedBody);
        // Initialize quantities after fetching parts
        initializeQuantities(cabinetryPartsModel.value.data ?? []);
        print(cabinetryPartsModel.value);
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
  fetchCabinetDetails() async {
    isLoading.value = true;
    String cabinetId = Get.arguments['cabinetId'];
    print(cabinetId);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', Uri.parse(ApiConstants.cabinetDetailsUrl(cabinetId)));
      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      print('Response body: ${responseBody.body}');
      Map<String, dynamic> decodedBody = jsonDecode(responseBody.body);
      if (response.statusCode == 200) {
        cabinetDetailsModel.value = CabinetDetailsModel.fromJson(decodedBody);
        // Initialize quantities after fetching parts
        initializeQuantities(cabinetryPartsModel.value.data ?? []);
        print(cabinetryPartsModel.value);
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