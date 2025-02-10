import 'package:get/get.dart';

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
}
