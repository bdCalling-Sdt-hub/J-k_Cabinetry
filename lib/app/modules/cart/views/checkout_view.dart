import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/cart/controllers/cart_controller.dart';
import 'package:jk_cabinet/app/modules/cart/controllers/make_payment_controller.dart';
import 'package:jk_cabinet/app/modules/profile/controllers/profile_controller.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_drawer/app_drawer.dart';
import 'package:jk_cabinet/common/app_string/app_string.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';
import 'package:jk_cabinet/common/widgets/custom_text_field.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';
import 'package:jk_cabinet/common/widgets/text_required.dart';

class CheckoutView extends StatelessWidget {
  CheckoutView({super.key});

  final CartController _cartController = Get.find();
  final PaymentController _paymentController = Get.put(PaymentController());
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarTitle(
        isShowChat: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment',
                style: AppStyles.h1(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  children: [
                    const Icon(Icons.shield_outlined),
                    horizontalSpacing(6.w),
                    Text(
                      'All transactions are secure and encrypted.',
                      style: AppStyles.h5(),
                    )
                  ],
                ),
              ),

              /// Payment options
              verticalSpacing(12.h),
              Text(
                'Payment options',
                style: AppStyles.h4(fontWeight: FontWeight.bold),
              ),
              Obx(() {
                return Wrap(
                  children: [
                    /// Cash/Check Radio Button
                    RadioListTile<bool>(
                      value: true,
                      // Shipping option is selected
                      groupValue: _cartController.isCashPayment.value,
                      // Shared group value
                      onChanged: (newValue) {
                        _cartController.isCashPayment.value =
                            true; // Select Cash
                        _cartController.isOnlinePayment.value =
                            false; // Deselect online
                      },
                      title: Text(
                        'Cash/Check',
                        style: AppStyles.h4(),
                      ),
                      subtitle: Text(
                        '(We will contact you for more information regarding the payment.)',
                        style: AppStyles.h5(),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      fillColor:
                          WidgetStateProperty.all(AppColors.primaryColor),
                    ),

                    /// Online payment Radio Button
                    RadioListTile<bool>(
                      value: false,
                      // Pickup option is selected
                      groupValue: _cartController.isCashPayment.value,
                      // Shared group value
                      onChanged: (newValue) {
                        _cartController.isOnlinePayment.value =
                            true; // Select online
                        _cartController.isCashPayment.value =
                            false; // Deselect Cash
                      },
                      title: Text(
                        'Online payment ',
                        style: AppStyles.h4(),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      fillColor:
                          WidgetStateProperty.all(AppColors.primaryColor),
                    ),
                  ],
                );
              }),

              /// Shipping Address
              verticalSpacing(12.h),
              Text(
                'Shipping Address',
                style: AppStyles.h4(fontWeight: FontWeight.bold),
              ),
              Obx(() {
                return Wrap(
                  children: [
                    /// Existing Address Radio Button
                    RadioListTile<bool>(
                      value: true,
                      // Shipping option is selected
                      groupValue:
                          _cartController.isExistingBillingAddress.value,
                      // Shared group value
                      onChanged: (newValue) {
                        _cartController.isExistingBillingAddress.value = true;
                        _cartController.isNewBillingAddress.value = false;
                      },
                      title: Text(
                        'Same as Billing Address (If shipping)',
                        style: AppStyles.h4(),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      fillColor:
                          WidgetStateProperty.all(AppColors.primaryColor),
                    ),

                    /// New Address Radio Button
                    RadioListTile<bool>(
                      value: false,
                      // Pickup option is selected
                      groupValue:
                          _cartController.isExistingBillingAddress.value,
                      // Shared group value
                      onChanged: (newValue) {
                        _cartController.isNewBillingAddress.value = true;
                        _cartController.isExistingBillingAddress.value = false;
                      },
                      title: Text(
                        'Use a different Shipping Address (If shipping) ',
                        style: AppStyles.h4(),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      fillColor:
                          WidgetStateProperty.all(AppColors.primaryColor),
                    ),
                  ],
                );
              }),

              Obx(() {
                return Column(
                  children: [
                    _cartController.isNewBillingAddress.value
                        ? Column(
                            children: [
                              _buildNewAddressLine(
                                  AppString.companyNameText,
                                  'Type company name',
                                  _cartController.companyNameCtrl),
                              _buildNewAddressLine(
                                  AppString.firstNameText,
                                  'Type first name',
                                  _cartController.firstNameCtrl),
                              _buildNewAddressLine(
                                  AppString.lastNameText,
                                  'Type last name',
                                  _cartController.lastNameCtrl),
                              _buildNewAddressLine(
                                  AppString.phoneText,
                                  'Type phone number',
                                  _cartController.phoneCtrl),
                              _buildNewAddressLine('Address ', 'Type address',
                                  _cartController.addressCtrl),
                              verticalSpacing(8.h),
                              _buildNewRowAddressLine(
                                  'Address Line 2',
                                  'Type address line 2',
                                  _cartController.address2Ctrl,
                                  'State',
                                  'Type state',
                                  _cartController.stateCtrl),
                              verticalSpacing(8.h),
                              _buildNewRowAddressLine(
                                  'City',
                                  'Type city',
                                  _cartController.cityCtrl,
                                  'Zip code',
                                  'Type Zip code',
                                  _cartController.zipCodeCtrl),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              }),
              verticalSpacing(14.h),
              ExpansionTile(
                title: Text(
                  'Order Summery',
                  style: AppStyles.h3(),
                ),
                maintainState: true,
                initiallyExpanded: true,
                controlAffinity: ListTileControlAffinity.platform,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                trailing: const Icon(Icons.arrow_drop_down_circle_outlined),
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Name',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Quantity',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Assembly',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Total',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(
                    color: Colors.grey.shade400,
                  ),

                  // Cart Item
                  ...List.generate(_cartController.cartItems.length, (index) {
                    final cartItem = _cartController.cartItems[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///Name
                          Text(
                            cartItem.name,
                            style: AppStyles.h5(),
                          ),

                          ///Qty
                          Text(cartItem.quantity.toString(),
                              style: AppStyles.h5()),

                          /// Assembly
                          Text('\$${cartItem.assemblyCost.toStringAsFixed(2)}',
                              style: AppStyles.h5()),

                          /// Total
                          Text('\$${cartItem.totalPrice.toStringAsFixed(2)}',
                              style: AppStyles.h5()),
                        ],
                      ),
                    );
                  }),
                  verticalSpacing(12.h),
                  Text(
                    'Shipping :-',
                    style: AppStyles.h4(),
                  ),

                  verticalSpacing(8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'By J&K Cabinetry',
                          style: AppStyles.h4(),
                        ),
                        Text(
                          '\$${_cartController.isShip.value ? _cartController.shippingCost.toStringAsFixed(2) : 0.toStringAsFixed(2)}',
                          style: AppStyles.h5(),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade400,
                  ),
                  verticalSpacing(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sub-Total :', style: AppStyles.h4()),
                      Text(
                          '\$${_cartController.subtotal.value.toStringAsFixed(2)}',
                          style: AppStyles.h5()),
                    ],
                  ),
                  verticalSpacing(14.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx((){
                        final tax = _profileController.profileModel.value.data?.branchTax ?? 0.0;
                        final isTax = _profileController.profileModel.value.data?.isTax ?? false;
                        return Text(
                            'Sales Tax (${isTax ? tax : 0}%) :', style: AppStyles.h4());
                      }),
                      Obx((){
                        final tax = _profileController.profileModel.value.data?.branchTax ?? 0.0;
                        final isTax = _profileController.profileModel.value.data?.isTax ?? false;
                        return Text(
                            '\$${((isTax ? tax : 0) * _cartController.subtotal.value / 100).toStringAsFixed(2)}',
                            style: AppStyles.h5());
                      }),
                    ],
                  ),
                  verticalSpacing(12.h),
                ],
              ),
              verticalSpacing(15.h),

              /// Total Price
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total :',
                      style: AppStyles.h1(color: AppColors.primaryColor),
                    ),
                    Text(
                      ' \$${_cartController.inTotal.value.toDouble().toStringAsFixed(2)}',
                      style: AppStyles.h1(color: AppColors.primaryColor),
                    ),
                  ],
                );
              }),
              verticalSpacing(15.h),

              /// The call to action button at the bottom of the checkout page - [Complete Order/Pay Now] Button
              Obx(() {
                return CustomButton(
                  loading: _paymentController.isLoading.value,
                    onTap: () async {
                    // if online payment option is selected, make the stripe payment
                      if (_cartController.isOnlinePayment.value) {
                        await _paymentController.makePayment(
                            amount: '${_cartController.inTotal.value}',
                            currency: 'USD',
                            subscriptionId: 'shuvoJk52',
                            subscriberId: 'shuvoJk52',
                        );
                      } else {
                        // otherwise, this is a cash payment order so hit the cash payment api and then navigate to the next page...
                        _paymentController.handleCashPayment();
                      }
                    },
                    text: _cartController.isOnlinePayment.value
                        ? 'Pay Now'
                        : 'Complete order',
                );
              }),
              verticalSpacing(16.h),
            ],
          ),
        ),
      ),
    );
  }

  _buildNewAddressLine(
      String headerTitle, String hintText, TextEditingController controller) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      verticalSpacing(10.h),
      TextRequired(
          text: headerTitle, textStyle: AppStyles.h4(family: "Schuyler")),
      verticalSpacing(10.h),
      CustomTextField(
          hintText: hintText,
          contentPaddingVertical: 16.h,
          controller: controller),
    ]);
  }

  _buildNewRowAddressLine(
    String headerTitle1,
    String hintText1,
    TextEditingController controller1,
    String headerTitle2,
    String hintText2,
    TextEditingController controller2,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextRequired(
                  text: headerTitle1,
                  textStyle: AppStyles.h4(family: "Schuyler")),
              CustomTextField(
                  hintText: hintText1,
                  contentPaddingVertical: 16.h,
                  controller: controller1),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextRequired(
                  text: headerTitle2,
                  textStyle: AppStyles.h4(family: "Schuyler")),
              CustomTextField(
                  hintText: hintText2,
                  contentPaddingVertical: 16.h,
                  controller: controller2),
            ],
          ),
        ),
      ],
    );
  }
}
