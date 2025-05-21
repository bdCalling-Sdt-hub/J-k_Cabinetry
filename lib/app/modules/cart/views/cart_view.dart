import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jk_cabinet/app/modules/bottom_menu/bottom_menu..dart';
import 'package:jk_cabinet/app/modules/home/controllers/home_controller.dart';
import 'package:jk_cabinet/app/modules/home/model/branch_model.dart';
import 'package:jk_cabinet/app/modules/home/widgets/topbar_contact_info.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_drawer/app_drawer.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/casess_network_image.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';
import 'package:path_provider/path_provider.dart';

import '../controllers/cart_controller.dart';

class CartView extends StatefulWidget {
  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartController cartController = Get.put(CartController());
  final HomeController homeController = Get.put(HomeController());
  BranchData? branchData;

  File? _cachedImageFile;
  bool _isDownloading = false;

  Future<void> _saveAndDisplayImage(String imageUrl) async {
    setState(() => _isDownloading = true);

    try {
      // download image bytes
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to download image');
      }

      // compress the image
      final compressedBytes = await FlutterImageCompress.compressWithList(
        response.bodyBytes,
        minHeight: 800,
        minWidth: 800,
        quality: 85,
        format: CompressFormat.jpeg,
      );

      // Get CACHE directory (temporary storage)
      final cacheDirectory = await getTemporaryDirectory();
      // create file name from url
      final fileName = 'cached_${DateTime.now().millisecondsSinceEpoch}.jpg';
      print(fileName);
      final filePath = '${cacheDirectory.path}/$fileName';
      print(filePath);

      // save to cache
      final file = File(filePath);
      await file.writeAsBytes(compressedBytes);

      setState(() {
        _cachedImageFile = file;
        _isDownloading = false;
      });
    } catch (e) {
      setState(() => _isDownloading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__)async{
      branchData = await homeController.saveBranchInfo();
      setState(() {});
      print(branchData);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(2),
      appBar: CustomAppBarTitle(
        isShowChat: true,
        chatOnTap: () {},
        notificationCount: '40',
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBarContactInfo(branchData: branchData,),
              verticalSpacing(12.h),
              ///search field
              // SearchField(),
              // verticalSpacing(8.h),
              const Text(
                "Final Pricing may differ due to pricing updates, tax, assembly fee, or shipping fees.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 400.h,
                child: Obx(() {
                  if (cartController.cartItems.isEmpty) {
                    return const Center(child: Text("No items in cart."));
                  }
                  return ListView.builder(
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartController.cartItems[index];

                      return Card(
                        margin: EdgeInsets.only(bottom: 16.h),
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Product Name & Remove Button
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: () => cartController.removeItem(index),
                                    child: const Icon(Icons.close, size: 20),
                                  ),
                                ],
                              ),
                               /// unit price
                              Text(
                                "Unit Price : \$${item.price.toStringAsFixed(2)}",
                                style: AppStyles.h4(),
                              ),
                               SizedBox(height: 8.h),

                              /// Quantity Selector
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  ///--->>>>> The product image here <<<<<-------
                                  // FutureBuilder<void>(future: _saveAndDisplayImage(item.productImg), builder: (context, snapshot) {
                                  //   if (_cachedImageFile != null) {
                                  //     return Image.file(_cachedImageFile!);
                                  //   }
                                  //   return const SizedBox();
                                  // }),
                                  CustomNetworkImage(
                                    imageUrl: item.productImg,
                                    height: 70.h,
                                    width: 80.w,
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        "Quantity",
                                        style: AppStyles.h5(),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () => cartController
                                                .decrementQuantity(index),
                                            icon: const Icon(Icons.remove),
                                          ),
                                          Text(
                                            item.quantity.toString(),
                                            style: AppStyles.h3(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () => cartController
                                                .incrementQuantity(index),
                                            icon: const Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              /// Total Price
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Total Price: \$${item.totalPrice.toStringAsFixed(2)}",
                                  style: AppStyles.h3(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),

                              /// Assembly Checkbox
                              Row(
                                children: [
                                  Checkbox(
                                    value: item.isAssemblyChecked,
                                    onChanged: (val) => cartController.toggleAssembly(index),
                                    activeColor: Colors.red,
                                  ),
                                  const Text("Assembly (per quantity)"),
                                  const Spacer(),
                                  const Text("\$10.01"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              ///Shipping
              verticalSpacing(12.h),
              Text('Shipping', style: AppStyles.h1()),
              Obx(() {
                return Wrap(
                  children: [
                    /// Shipping Radio Button
                    RadioListTile<bool>(
                      value: true,  // Shipping option is selected
                      groupValue: cartController.isShip.value, // Shared group value
                      onChanged: (newValue) {
                        cartController.isShip.value = true; // Select shipping
                        cartController.isPickup.value = false; // Deselect pickup
                      },
                      title: Text(
                        'By J&K Cabinetry',
                        style: AppStyles.h4(),
                      ),
                      subtitle: Text(
                        '\$${cartController.shippingCost.value.toStringAsFixed(2)}',
                        style: AppStyles.h5(),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      fillColor: WidgetStateProperty.all(AppColors.primaryColor),
                    ),
                    /// Pickup Radio Button
                    RadioListTile<bool>(
                      value: false,  // Pickup option is selected
                      groupValue: cartController.isShip.value, // Shared group value
                      onChanged: (newValue) {
                        cartController.isPickup.value = true; // Select pickup
                        cartController.isShip.value = false; // Deselect shipping
                      },
                      title: Text(
                        'Pickup',
                        style: AppStyles.h4(),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      fillColor: WidgetStateProperty.all(AppColors.primaryColor),
                    ),
                  ],
                );
              }),

              verticalSpacing(12.h),
              Align(
                alignment: Alignment.bottomRight,
                child: Obx(() {
                  return Text('Sub Total : \$${cartController.subtotal.value.toStringAsFixed(2)}',
                    style: AppStyles.h1(color: AppColors.primaryColor),
                  );
                }),
              ),
              verticalSpacing(12.h),
              CustomButton(
                onTap: () {
                  Get.toNamed(Routes.CHECKOUT);
                },
                text: 'CheckOut',
              ),
              verticalSpacing(16.h),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem {
  String id;
  String name;
  double price;
  int quantity;
  double assemblyCost;
  bool isAssemblyChecked;
  String productImg;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.assemblyCost,
    required this.productImg,
    this.isAssemblyChecked = false,
  });

  double get totalPrice => (price * quantity) + (isAssemblyChecked ? assemblyCost * quantity : 0);
}
