import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/common/app_images/network_image%20.dart';

class CabinetPartsRecentViewedDetailsController extends GetxController {
  RxInt quantity = 1.obs;
  RxInt selectedImageIndex = 0.obs;

  final List<String> productImages = [
    AppNetworkImage.cabinet1Img,
    AppNetworkImage.cabinet2Img,
    AppNetworkImage.cabinet3Img,
    AppNetworkImage.cabinet4Img,];

  void increment() {
    quantity.value++;
  }

  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
}
