import 'package:get/get.dart';
import 'package:jk_cabinet/common/app_images/network_image%20.dart';

class RecentlyViewedController extends GetxController {
  var recentlyViewed = <String>[].obs; // List of recently viewed items

  @override
  void onInit() {
    super.onInit();
    /// Dummy data
    recentlyViewed.addAll([
      AppNetworkImage.cabinet1Img,
      AppNetworkImage.cabinet2Img,
      AppNetworkImage.cabinet3Img,
    ]);
  }

  void removeItem(int index) {
    recentlyViewed.removeAt(index);
  }

  void clearAll() {
    recentlyViewed.clear();
  }
}
