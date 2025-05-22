import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/app/modules/cabinet_detail/model/cabinet_parts_model.dart';
import 'package:jk_cabinet/app/modules/cabinet_parts/controllers/cabinet_parts_controller.dart';
import 'package:jk_cabinet/app/modules/cart/controllers/cart_controller.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_constant/app_constant.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';
import 'package:jk_cabinet/common/widgets/custom_cart_floating_button.dart';
import 'package:jk_cabinet/common/widgets/custom_loading.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';

import '../../cabinet_detail/controllers/cabinet_detail_controller.dart';

class CabinetPartsView extends StatefulWidget {
  const CabinetPartsView({super.key});

  @override
  _CabinetPartsViewState createState() => _CabinetPartsViewState();
}

class _CabinetPartsViewState extends State<CabinetPartsView> {
  final CabinetPartsController _cabinetPartsController = Get.find<CabinetPartsController>();

  final CabinetDetailController _cabinetDetailController = Get.find<CabinetDetailController>();
  var x = 0;
  final Part parts = Part();

  @override
  void initState() {
    super.initState();
    _cabinetPartsController.fetchPartsDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarTitle(
        text: 'Sink & Vanity Bases',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Main Product Image
              Center(
                child: Obx(
                  () {
                    if (_cabinetPartsController.productImages.isEmpty || _cabinetPartsController.selectedImageIndex.value < 0 || _cabinetPartsController.selectedImageIndex.value >= _cabinetPartsController.productImages.length) {
                      return const Center(child: CustomLoading());
                    }
                    return GestureDetector(
                      onTap: () {
                        showImageDialog(context, _cabinetPartsController.selectedImageIndex.value);
                      },
                      child: Container(
                        width: 180.w,
                        height: 180.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: _cabinetPartsController.singlePartDetailsModel.value.data?.images != null &&
                            _cabinetPartsController.singlePartDetailsModel.value.data!.images!.isNotEmpty ? Image.network(
                          '${ApiConstants.imageBaseUrl}/${_cabinetPartsController.singlePartDetailsModel.value.data?.images?[_cabinetPartsController.selectedImageIndex.value]}',
                          fit: BoxFit.cover,
                        ): Center(
                          child: Icon(Icons.image, size: 40.sp, color: Colors.grey),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 12.h),

              /// Thumbnail Selector
              Obx(
                () {
                  if (_cabinetPartsController.productImages.isEmpty) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: const Center(child: Icon(Icons.image)),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_cabinetPartsController.singlePartDetailsModel.value.data?.images?.length ?? 0,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                                _cabinetPartsController
                                    .selectedImageIndex.value = index;
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _cabinetPartsController.selectedImageIndex.value == index
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                              ),
                            ),
                            child: _cabinetPartsController.singlePartDetailsModel.value.data?.images != null ? Image.network(
                              '${ApiConstants.imageBaseUrl}/${_cabinetPartsController.singlePartDetailsModel.value.data?.images?[index]}',
                              fit: BoxFit.contain,
                            ) : const Icon(Icons.image),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 8.h),

              /// Product Category
              Text(
                "Drawers",
                style: AppStyles.h4(color: AppColors.primaryColor),
              ),
              SizedBox(height: 4.h),

              /// Product Title / code
              Text(
                _cabinetDetailController.cabinetDetailsModel.value.data!.code ?? '',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),

              /// Product Description
              const Text(
                "BASE CABINET 1 DRAWER, 1 DOOR, 1 SHELF - 9” WIDE X 24” DEEP X 34.5” HIGH",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 8.h),

              /// Product Price
              Obx(() {
                  return Text(
                    "Price : \$${(_cabinetPartsController.singlePartDetailsModel.value.data?.price != null ?_cabinetPartsController.singlePartDetailsModel.value.data!.price! * _cabinetPartsController.quantity.value : 0).toStringAsFixed(2) }",
                    //"Price : \$${(_cabinetDetailController.cabinetryPartsModel.value.data!.first.categories!.first.parts![x].price! * _cabinetPartsController.quantity.value).toStringAsFixed(2)}",
                    style: AppStyles.h2(color: AppColors.primaryColor),
                  );
                },
              ),
              SizedBox(height: 12.h),

              /// Quantity Selector & Add to Cart Button
              Row(
                children: [
                  /// Quantity Selector
                  Row(
                    children: [
                      IconButton(
                        onPressed: _cabinetPartsController.decrement,
                        icon: const Icon(Icons.remove),
                      ),
                      Obx(
                        () {
                          return Text(
                            "${_cabinetPartsController.quantity}",
                            style: AppStyles.h3(),
                          );
                        },
                      ),
                      IconButton(
                        onPressed: _cabinetPartsController.increment,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),

                  SizedBox(width: 20.w),

                  /// Add to Cart Button
                  CustomButton(
                    onTap: () async {
                      final controller = Get.find<CartController>();
                      final partsController = Get.find<CabinetPartsController>();
                      final detailController = Get.find<CabinetDetailController>();

                      final part = partsController.singlePartDetailsModel.value.data;
                      if (part != null) {
                        await controller.addToCart(
                          productId: part.sId.toString(),
                          name: detailController.cabinetDetailsModel.value.data?.code ?? 'Unknown',
                          price: part.price!.toDouble(),
                          quantity: partsController.quantity.value,
                          productImg: part.images != null &&
                                  part.images!.isNotEmpty
                              ? '${ApiConstants.imageBaseUrl}/${part.images?.first}'
                              : AppConstants.demoImage,
                        );


                        Get.snackbar(
                          'Success',
                          'Item added to cart',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    text: 'Add to cart',
                    width: 70.w,
                  ),
                ],
              ),
              verticalSpacing(12.h),
              Divider(
                color: Colors.grey.shade400,
              ),

              // todo: implement this [Recently Viewed] feature if possible
              // RecentlyViewed(
              //   key: widget.key,
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: const CustomCartFloatingButton(),
    );
  }

  void showImageDialog(BuildContext context, int imageIndex) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            //backgroundColor: Colors.transparent,
            title: _cabinetPartsController.singlePartDetailsModel.value.data?.images != null ? Image.network(
                '${ApiConstants.imageBaseUrl}/${_cabinetPartsController.singlePartDetailsModel.value.data!.images![imageIndex]}') : const Icon(Icons.image),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                },
                child: const Text("Close"),
              ),
            ],
          );
        });
  }
}
