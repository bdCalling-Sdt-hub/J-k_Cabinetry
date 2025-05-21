// import 'dart:convert';
// import 'dart:io';
//
// import 'package:get/get.dart';
// import 'package:jk_cabinet/app/data/api_constants.dart';
// import 'package:jk_cabinet/app/modules/cabinet_detail/model/cabinet_details_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:jk_cabinet/app/modules/cabinet_detail/model/parts_model.dart';
// import 'package:logger/logger.dart';
//
// class CabinetDetailTabBarController extends GetxController {
//   final String cabinetId = Get.arguments['cabinetId' ?? ''];
//
//   RxList<int> quantity = <int>[1].obs;
//
//   Rx<CabinetDetailsModel>  cabinetDetailsModel = CabinetDetailsModel().obs;
//   Rx<PartsModel> partsDetails = PartsModel().obs;
//
//   final Logger _logger = Logger();
//   buildItemList(int itemLength) {
//     quantity.value = List.generate(itemLength, (index) => 1).obs;
//   }
//
//   void increment(int index) {
//     quantity[index]++;
//   }
//
//   void decrement(int index) {
//     if (quantity[index] > 1) {
//       quantity[index]--;
//     }
//   }
//
//   ///======================== Network call==================================
//
//   RxBool isCabinetLoading = false.obs;
//   RxBool isPartsLoading = false.obs;
//
//   fetchCabinetDetails() async {
//     isCabinetLoading.value = true;
//     try {
//       Map<String, String> headers = {'Content-Type': 'application/json'};
//
//       var request = http.Request(
//         'GET',
//         Uri.parse(
//           ApiConstants.cabinetDetailsUrl(cabinetId),
//         ),
//       );
//
//       request.headers.addAll(headers);
//       var response = await request.send();
//       var responseBody = await http.Response.fromStream(response);
//
//       print('Response body: ${responseBody.body}');
//       _logger.i('Response body: ${responseBody.body}');
//
//       Map<String, dynamic> decodedBody = jsonDecode(responseBody.body);
//       if (response.statusCode == 200) {
//         cabinetDetailsModel.value = CabinetDetailsModel.fromJson(decodedBody);
//         print(cabinetDetailsModel.value);
//         _logger.i(cabinetDetailsModel.value);
//       } else {
//         print('Error: ${response.statusCode}');
//         _logger.e('Error: ${response.statusCode}');
//         Get.snackbar('Failed', decodedBody['message']);
//       }
//     } on SocketException catch (_) {
//       Get.snackbar(
//         'Error',
//         'No internet connection. Please check your network and try again.',
//         snackPosition: SnackPosition.TOP,
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Something went wrong. Please try again later.',
//         snackPosition: SnackPosition.TOP,
//       );
//       print(e);
//       _logger.e(e);
//     } finally {
//       isCabinetLoading.value = false;
//     }
//   }
//
//   /// Fetch Parts
//   fetchStockItemProductDetails() async {
//     isPartsLoading.value = true;
//     try {
//       Map<String, String> headers = {'Content-Type': 'application/json'};
//
//       var request = http.Request(
//         'GET',
//         Uri.parse(
//           ApiConstants.cabinetPartsDetailsUrl,
//         ),
//       );
//
//       request.headers.addAll(headers);
//       var response = await request.send();
//       var responseBody = await http.Response.fromStream(response);
//
//       print('Response body: ${responseBody.body}');
//       _logger.i('Response body: ${responseBody.body}');
//       Map<String, dynamic> decodedBody = jsonDecode(responseBody.body);
//
//       if (response.statusCode == 200) {
//         partsDetails.value = PartsModel.fromJson(decodedBody);
//         print(partsDetails.value);
//         _logger.i(partsDetails.value);
//       } else {
//         print('Error: ${response.statusCode}');
//         Get.snackbar('Failed', decodedBody['message']);
//       }
//     } on SocketException catch (_) {
//       Get.snackbar(
//         'Error',
//         'No internet connection. Please check your network and try again.',
//         snackPosition: SnackPosition.TOP,
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Something went wrong. Please try again later.',
//         snackPosition: SnackPosition.TOP,
//       );
//       print(e);
//       _logger.e(e);
//     } finally {
//       isPartsLoading.value = false;
//     }
//   }
// }
