import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/cart/views/cart_view.dart';
import 'package:jk_cabinet/common/app_images/network_image%20.dart';

class CartController extends GetxController {
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController companyNameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController address2Ctrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();
  TextEditingController zipCodeCtrl = TextEditingController();

  RxList<CartItem> cartItems = <CartItem>[].obs;
  RxBool isShip= true.obs;
  RxBool isPickup= false.obs;
  RxBool isCashPayment= true.obs;
  RxBool isOnlinePayment= false.obs;
  RxBool isExistingBillingAddress= true.obs;
  RxBool isNewBillingAddress= false.obs;
  double shippingCost=10.01;
  double salesTax=0.06;


  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((__){
      cartItems.addAll([
        CartItem(name: "A7/ASO", price: 10, quantity: 2, assemblyCost: 0, productImg:AppNetworkImage.cabinet2Img),
        CartItem(name: "S8/S80", price: 20, quantity: 4, assemblyCost: 0, productImg: AppNetworkImage.cabinet1Img),
      ]);
    });

  }

  void incrementQuantity(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  void decrementQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
    }
  }

  void toggleAssembly(int index) {
    cartItems[index].isAssemblyChecked = !cartItems[index].isAssemblyChecked;
    if(cartItems[index].isAssemblyChecked){
      cartItems[index].assemblyCost += shippingCost;
      cartItems.refresh();
    } else if(!cartItems[index].isAssemblyChecked){
      cartItems[index].assemblyCost -= shippingCost;
      cartItems.refresh();
    }
    cartItems.refresh();
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
  }
  ///sub-total
  RxDouble get subtotal => ( cartItems.fold(0.0, (sum, item) => sum + item.totalPrice) + (isShip.value ? 10.0 : 0.0)  ).obs;

  // RxDouble get subtotal {
  //   double sum = 0.0;
  //   for (var item in cartItems) {
  //     sum += item.totalPrice;
  //   }
  //   sum += (isShip.value ? 10.0 : 0.0); // Add shipping if enabled
  //   return sum.obs;
  // }

  RxDouble get inTotal=> ((salesTax * subtotal.value) + subtotal.value).obs;

}