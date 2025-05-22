import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:jk_cabinet/common/app_images/network_image%20.dart';
import 'package:logger/logger.dart';
import '../../../data/api_constants.dart';
import '../../cabinet_detail/model/cabinet_details_model.dart';
import '../../cabinet_detail/model/cabinet_parts_model.dart';
import '../models/single_part_model.dart';

class CabinetPartsController extends GetxController {
  RxInt quantity = 1.obs;
  RxInt selectedImageIndex = 0.obs;
  final Logger _logger = Logger();

  Rx<SinglePartModel> singlePartDetailsModel = SinglePartModel().obs;

  final partsId = Get.arguments['partsId'];

  // final List<String> productImages = [
  //   AppNetworkImage.cabinet1Img,
  //   AppNetworkImage.cabinet2Img,
  //   AppNetworkImage.cabinet3Img,
  //   AppNetworkImage.cabinet4Img,
  // ];
  final RxList<String> productImages = RxList<String>([]);

  @override
  void onInit(){
    super.onInit();
    // productImages.addAll(singlePartDetailsModel.value.data?.images ?? []);
  }

  void increment() {
      quantity.value++;
  }

  void decrement() {
    if (quantity.value > 1) {
        quantity.value--;
    }
  }

  RxBool isCabinetLoading = false.obs;
  RxBool isPartsLoading = false.obs;

  fetchPartsDetails() async {
    isCabinetLoading.value = true;
    try {
      Map<String, String> headers = {'Content-Type': 'application/json'};
      print('====:::====>>>> $partsId');
      var request = http.Request('GET', Uri.parse(ApiConstants.cabinetPartsDetailsUrl(partsId)));
      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      print('Response body: ${responseBody.body}');
      _logger.i('Response body: ${responseBody.body}');

      Map<String, dynamic> decodedBody = jsonDecode(responseBody.body);

      if (response.statusCode == 200) {
        singlePartDetailsModel.value = SinglePartModel.fromJson(decodedBody);
        productImages.addAll(singlePartDetailsModel.value.data?.images ?? []);
        update();
      } else {
        print('Error: ${response.statusCode}');
        _logger.e('Error: ${response.statusCode}');
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
      _logger.e(e);
    } finally {
      isCabinetLoading.value = false;
    }
  }

}
