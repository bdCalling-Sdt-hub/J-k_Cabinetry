import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/app/modules/cart/models/payment_response_model.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_constant/app_constant.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../sk_key.dart';
import '../../profile/controllers/profile_controller.dart';
import 'cart_controller.dart';

class PaymentController extends GetxController{

  Rx<PaymentResponseModel> paymentResponseModel = PaymentResponseModel().obs;
  //
  final ProfileController _profileController = Get.put(ProfileController(),tag: 'me');
  final CartController _cartController = Get.put(CartController());
  final Logger _logger = Logger();

  Map<String, dynamic>? paymentIntent;
  Rx<bool> isLoading= false.obs;

  Future<void> makePayment(
      {required String amount,
        required String currency,
        dynamic subscriptionId,
        String? subscriberId}) async {

    try {
      isLoading.value = true;
      // Create payment intent data
      paymentIntent = await createPaymentIntent(amount, currency);
      // initialise the payment sheet setup
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Client secret key from payment data
          paymentIntentClientSecret: paymentIntent?['client_secret']??'',
          // Merchant Name
          merchantDisplayName: 'GolfTournament',
          // return URl if you want to add
          // returnURL: 'flutterstripe://redirect',
        ),
      );
      // Display payment sheet
      await displayPaymentSheet(subscriptionId,subscriberId!);
    }on SocketException catch (_) {
      Get.snackbar(
        'Error',
        'No internet connection. Please check your network and try again.',
        snackPosition: SnackPosition.TOP,
      );
    } catch (error) {
      print("exception $error");

      if (error is StripeConfigException) {
        print("Stripe exception ${error.message}");
      } else {
        print("exception $error");
      }
    } finally {
      isLoading.value = false;
    }
  }
  /// Display Stripe payment sheet
  displayPaymentSheet(String subscriptionId, String subscriberId) async {
    try {
      // "Display payment sheet";
      await Stripe.instance.presentPaymentSheet();
      // Show when payment is done
      dynamic transactionId = paymentIntent?['id'];
      String? currency = paymentIntent?['currency'];
      int? amount =paymentIntent?['amount'] ;
      String? purchaseToken =paymentIntent?['client_secret'];
      print(paymentIntent.toString());

      if(transactionId !=null && amount !=null && purchaseToken !=null){
        await handleOnlinePayment(transactionId,subscriptionId,amount, paymentIntent??{},subscriberId);
      }
      //Get.snackbar('Payment Successful', '');
      paymentIntent = null;
    } on StripeException catch (e) {
      print('Error: $e');
      Get.snackbar('Payment Abort', '');

    } catch (e) {
      print("Error in displaying");
      print('$e');
    }
  }
  /// Stripe payment intent creation
  Future<Map<String, dynamic>?> createPaymentIntent(String amount, String currency) async {
    try {
      // Validate amount input
      if (amount.isEmpty || double.tryParse(amount) == null) {
        print('Invalid amount: $amount');
        Get.snackbar("Error", "Invalid amount format.");
        return null;
      }

      int amountInCents = (double.parse(amount) * 100).toInt();

      Map<String, dynamic> body = {
        'amount': amountInCents.toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${SKey.sSecTestKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      var decodedBody= jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('Payment Intent created: ${response.body}');
        return  decodedBody;
      } else {
        print('Failed to create Payment Intent: ${response.body}');
        Get.snackbar("Error", "Failed to create payment intent.");
        return null;
      }
    } catch (err) {
      print('Error charging user: ${err.toString()}');
      Get.snackbar("Error", "Payment Intent creation error.");
      return null;
    }
  }

  // var products= {
  //  "image": "https://example.com/product-image1.jpg",
  //  "name": "A7/ASO",
  //  "quantity": 2,
  //  "assembly": "10",
  //  "total": 20.00
  //  };



  var products=<CartProduct>[].obs;

  /// Handle payment response
  handleOnlinePayment(
      dynamic transactionId,
      String subscriptionId,
      int amountInCent,
      Map<String, dynamic> stripeResponseData,
      String subscriberId,
      ) async {
    String userToken = await PrefsHelper.getString(AppConstants.signInToken);
    print('Stripe response data===========: $stripeResponseData');
    _logger.i('''
    Payment Transaction Details====>>>
    Transaction ID: $transactionId
    Stripe Order Data: $stripeResponseData
    ''');
    double amount = (amountInCent/100).toDouble();
    final userData = _profileController.profileModel.value.data;
    Map<String,dynamic> body =
    _cartController.isExistingBillingAddress.value ?
    {
      "stripeSubscriptionId": subscriptionId,
      "stripeCustomerId": subscriberId,
      "planPrice": amount,
      "paymentMethod": _cartController.isOnlinePayment.value ? "stripe" : "cash",
      "companyName": userData?.companyName,
      "firstName": userData?.firstName,
      "lastName": userData?.lastName,
      "phoneNumber": userData?.phone,
      "address": userData?.address,
      "city": userData?.city,
      "state": userData?.state,
      "zipCode": userData?.zipCode,
      "isBillingSame": true,
      "paymentData" : [
        {
          "stripPaymentId" : transactionId,
          "amount" : amountInCent,
          "currency": stripeResponseData['currency'] ?? 'usd'
        }
      ],
      "products": _cartController.cartItems.map((item) => {
        "name": item.name,
        "quantity": item.quantity,
        "assembly": item.assemblyCost > 0
            ? "\$${item.assemblyCost.toStringAsFixed(2)}"
            : null,
        "total": item.totalPrice,
      }).toList(),
    } : {
      "stripeSubscriptionId": subscriptionId,
      "stripeCustomerId": subscriberId,
      "planPrice": amount,
      "paymentMethod": _cartController.isOnlinePayment.value ? "stripe" : "cash",
      "companyName": _cartController.companyNameCtrl.text,
      "firstName": _cartController.firstNameCtrl.text,
      "lastName": _cartController.lastNameCtrl.text,
      "phoneNumber": _cartController.phoneCtrl.text,
      "address": _cartController.addressCtrl.text,
      "city": _cartController.cityCtrl.text,
      "state": _cartController.stateCtrl.text,
      "zipCode": _cartController.zipCodeCtrl.text,
      "isBillingSame": false,
      "paymentData" : [
        {
          "stripPaymentId" : transactionId,
          "amount" : amountInCent,
          "currency": stripeResponseData['currency'] ?? 'usd'
        }
      ],
      "products": _cartController.cartItems.map((item) => {
        "name": item.name,
        "quantity": item.quantity,
        "assembly": item.assemblyCost > 0
            ? "\$${item.assemblyCost.toStringAsFixed(2)}"
            : null,
        "total": item.totalPrice,
      }).toList(),
    } ;

    Map<String,String> header={
      'Content-Type':'application/json',
      'Authorization': 'Bearer $userToken'
    };
    Get.toNamed(Routes.INVOICE, arguments: {'transactionId':transactionId});

    var request = await http.post(
      Uri.parse(ApiConstants.createOrderUrl),
      body: jsonEncode(body),
      headers: header,
    );

    var responseBody = jsonDecode(request.body);
    if (request.statusCode == 200) {
      // paymentResponseModel.value = PaymentResponseModel.fromJson(responseBody);
      _logger.i("Payment response: $responseBody");
      await _cartController.clearCart();
      Get.dialog(
        barrierDismissible: true,
        AlertDialog(
          title: const Text('Payment Successful'),
          content: const Text('Your payment has been processed successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      Get.snackbar('Failed payment record ', responseBody['message'].toString(),);
    }
  }


  /// Cash payment
  handleCashPayment() async {
    String userToken = await PrefsHelper.getString('sign-in-token');
    // String branchId = _cartController.

    // double amount = (amountInCent/100).toDouble();
    final userData = _profileController.profileModel.value.data;
    Map<String,dynamic> body =
    _cartController.isExistingBillingAddress.value ?
    {
      // "stripeSubscriptionId": subscriptionId,
      // "stripeCustomerId": subscriberId,
      // "planPrice": amount,
      "paymentMethod": _cartController.isOnlinePayment.value ? "stripe" : "cash",
      "companyName": userData?.companyName,
      "firstName": userData?.firstName,
      "lastName": userData?.lastName,
      "phoneNumber": userData?.phone,
      "address": userData?.address,
      "city": userData?.city,
      "state": userData?.state,
      "zipCode": userData?.zipCode,
      "isBillingSame": true,
      "products": _cartController.cartItems.map((item) => {
        "name": item.name,
        "quantity": item.quantity,
        "assembly": item.assemblyCost > 0
            ? "\$${item.assemblyCost.toStringAsFixed(2)}"
            : null,
        "total": item.totalPrice.toDouble(),
      }).toList(),
    } : {
      // "stripeSubscriptionId": subscriptionId,
      // "stripeCustomerId": subscriberId,
      // "planPrice": amount,
      "paymentMethod": _cartController.isOnlinePayment.value ? "stripe" : "cash",
      "companyName": _cartController.companyNameCtrl.text,
      "firstName": _cartController.firstNameCtrl.text,
      "lastName": _cartController.lastNameCtrl.text,
      "phoneNumber": _cartController.phoneCtrl.text,
      "address": _cartController.addressCtrl.text,
      "city": _cartController.cityCtrl.text,
      "state": _cartController.stateCtrl.text,
      "zipCode": _cartController.zipCodeCtrl.text,
      "isBillingSame": false,
      "products": _cartController.cartItems.map((item) => {
        "name": item.name,
        "quantity": item.quantity,
        "assembly": item.assemblyCost > 0
            ? "\$${item.assemblyCost.toStringAsFixed(2)}"
            : null,
        "total": item.totalPrice.toDouble(),
      }).toList(),
    } ;

    Map<String,String> header={
      'Content-Type':'application/json',
      'Authorization': 'Bearer $userToken'
    };

    // Be aware! API Call happening!!!
    var request = await http.post(
      Uri.parse(ApiConstants.createOrderUrl),
      body: jsonEncode(body),
      headers: header,
    );

    var responseBody = jsonDecode(request.body);
    if (request.statusCode == 200 || request.statusCode == 201) {
      paymentResponseModel.value = PaymentResponseModel.fromJson(responseBody);
      _logger.i("Payment response: $responseBody");
      await _cartController.clearCart();
      // Get.toNamed(Routes.INVOICE);
      Get.toNamed(Routes.CASH_PAYMENT_PROCESS);
      // Get.dialog(
      //   barrierDismissible: true,
      //   AlertDialog(
      //     title: const Text('Payment Successful'),
      //     content: const Text('Your payment has been processed successfully.'),
      //     actions: [
      //       TextButton(
      //         onPressed: () {
      //           Get.back();
      //         },
      //         child: const Text('OK'),
      //       ),
      //     ],
      //   ),
      // );
    } else {
      Get.snackbar('Failed payment record ', responseBody['message'].toString(),);
      _logger.e(responseBody['message'].toString());
    }
  }
}

class CartProduct {
  final String image;
  final String name;
  final int quantity;
  final String assembly;
  final double total;

  CartProduct({
    required this.image,
    required this.name,
    required this.quantity,
    required this.assembly,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'quantity': quantity,
      'assembly': assembly,
      'total': total,
    };
  }

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      assembly: json['assembly'] ?? '',
      total: (json['total'] ?? 0.0).toDouble(),
    );
  }
}