import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/cart/models/cart_item_model.dart';
import 'package:jk_cabinet/app/modules/cart/views/cart_view.dart';
import 'package:jk_cabinet/app/modules/profile/controllers/profile_controller.dart';
import 'package:jk_cabinet/app/modules/profile/model/profile_model.dart';
import 'package:jk_cabinet/common/helper/logger_helper.dart';
import 'package:jk_cabinet/common/helper/sql_helper.dart';

import 'make_payment_controller.dart';

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
 final ProfileController _profileController = Get.put(ProfileController());

  RxList<CartItem> cartItems = <CartItem>[].obs;
  RxBool isShip= true.obs;
  RxBool isPickup= false.obs;
  RxBool isCashPayment= true.obs;
  RxBool isOnlinePayment= false.obs;
  RxBool isExistingBillingAddress= true.obs;
  RxBool isNewBillingAddress= false.obs;
 RxDouble shippingCost = 10.01.obs;
 // RxDouble salesTax = 0.06.obs;
   late RxInt salesTaxAmount;
   late RxInt salesTax;
   // final tax = _profileController.profileModel.value.data?.branchTax ?? 0.0;
   // late RxInt salesTaxAmount;


  final DatabaseHelper _dbHelper = DatabaseHelper(dbName: 'jk_cabinet.db');
  final String _cartTable = 'cart_items';

  @override
  void onInit() {
    super.onInit();
    final taxPercent = (_profileController.profileModel.value.data?.branchTax ?? 0).obs;
    salesTaxAmount = ((taxPercent * subtotal.value / 100).round()).obs;
    salesTax = taxPercent;
    loadCartItems();
    WidgetsBinding.instance.addPostFrameCallback((__){
      // cartItems.addAll([
      //   CartItem(name: "A7/ASO", price: 10, quantity: 2, assemblyCost: 0, productImg:AppNetworkImage.cabinet2Img),
      //   CartItem(name: "S8/S80", price: 20, quantity: 4, assemblyCost: 0, productImg: AppNetworkImage.cabinet1Img),
      // ]);
    });

  }

  // Load cart items from database
  Future<void> loadCartItems() async {
    try {
      bool tableExists = await _dbHelper.tableExists(_cartTable);
      if (!tableExists) {
        LoggerHelper.info("Cart table doesn't exist yet!");
        return;
      }

      final items = await _dbHelper.query(_cartTable);
      cartItems.clear();

      for (var item in items) {
        CartItemModel cartItemModel = CartItemModel.fromMap(item);
        cartItems.add(cartItemModel.toCartItem());
        // _paymentController.products.add(cartItemModel.);
      }
      LoggerHelper.info("Loaded ${cartItems.length} items from the database");
    } catch (e) {
      LoggerHelper.error("Error loading cart items: $e");
    }
  }

  // Add item to cart
  Future<void> addToCart({
    required String productId,
    required String name,
    required double price,
    required int quantity,
    required String productImg,
    double assemblyCost = 0.0,
}) async {
    try {
      // Check if the product already exists in cart
      int existingIndex = -1;
      for (int i = 0; i < cartItems.length; i++) {
        if (cartItems[i].id == productId) {
          existingIndex = i;
          break;
        }
      }

      if (existingIndex >= 0) {
        // Update existing item
        CartItem existingItem = cartItems[existingIndex];
        CartItemModel updatedItem = CartItemModel(
          productId: productId,
          name: name,
          price: price,
          quantity: existingItem.quantity + quantity,
          assemblyCost: existingItem.assemblyCost,
          isAssemblyChecked: existingItem.isAssemblyChecked,
          productImg: productImg,
        );

        await _dbHelper.update(
          _cartTable,
          updatedItem.toMap(),
          where: 'productId = ?',
          whereArgs: [productId],
        );

        // update ui
        cartItems[existingIndex].quantity += quantity;
        cartItems.refresh();

        LoggerHelper.info('Updated cart item: $name');
      } else {
        // Add new item
        CartItemModel newItem = CartItemModel(
          productId: productId,
          name: name,
          price: price,
          quantity: quantity,
          assemblyCost: assemblyCost,
          productImg: productImg,
        );

        await _dbHelper.insert(_cartTable, newItem.toMap());

        // Add to UI
        cartItems.add(CartItem(
          id:productId ,
          name: name,
          price: price,
          quantity: quantity,
          assemblyCost: assemblyCost,
          productImg: productImg,
        ));

        LoggerHelper.info('Added new item to cart: $name');
      }

      // Show success message
      Get.snackbar(
        'Success',
        'Item added to cart',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      LoggerHelper.error('Error adding item to cart: $e');
      Get.snackbar(
        'Error',
        'Failed to add item to cart',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void incrementQuantity(int index) async {
    cartItems[index].quantity++;
    cartItems.refresh();

    // Update in database
    try {
      final item = cartItems[index];
      CartItemModel cartItemModel = CartItemModel(
        // id: 23,
        productId: item.id,
        name: item.name,
        price: item.price,
        quantity: item.quantity,
        assemblyCost: item.assemblyCost,
        isAssemblyChecked: item.isAssemblyChecked,
        productImg: item.productImg,
      );

      await _dbHelper.update(
        _cartTable,
        cartItemModel.toUpdateMap(),
        where: 'productId = ?',
        whereArgs: [item.id],
      );
    } catch (e) {
      LoggerHelper.error('Error updating quantity: $e');
    }
  }

  void decrementQuantity(int index) async {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();

      // Update in database
      try {
        final item = cartItems[index];
        CartItemModel cartItemModel = CartItemModel(
          productId: item.name,
          name: item.name,
          price: item.price,
          quantity: item.quantity,
          productImg: item.productImg,
          assemblyCost: item.assemblyCost,
          isAssemblyChecked: item.isAssemblyChecked,
        );

        await _dbHelper.update(
          _cartTable,
          cartItemModel.toMap(),
          where: 'name = ?',
          whereArgs: [item.name],
        );
      } catch (e) {
        LoggerHelper.error('Error updating quantity: $e');
      }
    }
  }

  void toggleAssembly(int index) async {
    final item = cartItems[index];
    item.isAssemblyChecked = !item.isAssemblyChecked;
    if(item.isAssemblyChecked) {
      item.assemblyCost += shippingCost.value;
      cartItems.refresh();
    } else if(!item.isAssemblyChecked) {
      item.assemblyCost -= shippingCost.value;
      cartItems.refresh();
    }
    cartItems.refresh();

    // update in database
    try {
      CartItemModel cartItemModel = CartItemModel(
        productId: item.name,
        name: item.name,
        price: item.price,
        quantity: item.quantity,
        productImg: item.productImg,
        assemblyCost: item.assemblyCost,
        isAssemblyChecked: item.isAssemblyChecked,
      );

      await _dbHelper.update(
        _cartTable,
        cartItemModel.toMap(),
        where: 'name = ?',
        whereArgs: [item.name],
      );
    } catch (e) {
      LoggerHelper.error('Error updating assembly: $e');
    }
  }

  void removeItem(int index) async {
    final itemName = cartItems[index].name;

    // Remove from database
    try {
      await _dbHelper.delete(
        _cartTable,
        where: 'name = ?',
        whereArgs: [itemName],
      );

      // Remove from UI
      cartItems.removeAt(index);
      LoggerHelper.info('Removed item from cart: $itemName');
    } catch (e) {
      LoggerHelper.error('Error removing item: $e');
    }
  }


  // Clear cart
  Future<void> clearCart() async {
    try {
      await _dbHelper.delete(_cartTable);
      cartItems.clear();
      LoggerHelper.info('Cart cleared');
    } catch (e) {
      LoggerHelper.error('Error clearing cart: $e');
    }
  }



  ///sub-total
  RxDouble get subtotal => ( cartItems.fold(0.0, (sum, item) => sum + item.totalPrice) + (isShip.value ? 10.0 : 0.0)  ).obs;
  // RxDouble get inTotal => ((_profileController.profileModel.value.data?.branchTax ?? 0.0) * subtotal.value + subtotal.value).obs;
  // RxDouble get inTotal=> ((_profileController.profileModel.value.data?.branchTax ?? 0 /* * subtotal.value*/ ) + subtotal.value).obs;
  // RxDouble get inTotal=> (salesTax.value + subtotal.value).obs;

  RxDouble get inTotal {
    final tax = _profileController.profileModel.value.data?.branchTax ?? 0.0;
    final isTax = _profileController.profileModel.value.data?.isTax ?? false;
    return (subtotal.value + ((isTax ? tax : 0) * subtotal.value / 100)).obs;
  }

  // RxDouble get subtotal {
  //   double sum = 0.0;
  //   for (var item in cartItems) {
  //     sum += item.totalPrice;
  //   }
  //   sum += (isShip.value ? 10.0 : 0.0); // Add shipping if enabled
  //   return sum.obs;
  // }
}