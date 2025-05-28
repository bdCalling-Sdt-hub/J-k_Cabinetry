import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/app/modules/cabinet_detail/controllers/cabinet_detail_controller.dart';
import 'package:jk_cabinet/app/modules/cabinet_detail/model/cabinet_parts_model.dart';
import 'package:jk_cabinet/app/modules/cart/controllers/cart_controller.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_constant/app_constant.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';

import '../../profile/controllers/profile_controller.dart';

class PartsCard extends StatefulWidget {
  final CabinetDetailController? cabinetDetailController;
  final int index;
  final int itemLength;
  final Part parts;

  const PartsCard({
    super.key,
    this.cabinetDetailController,
    required this.index,
    required this.itemLength,
    required this.parts,
  });

  @override
  State<PartsCard> createState() => _PartsCardState();
}

class _PartsCardState extends State<PartsCard> {

  final CartController _cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    final cabinetCode =  widget.cabinetDetailController?.cabinetDetailsModel.value.data?.code;
    final partName = widget.parts.title;
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${cabinetCode ?? ''} /${partName ?? ''}',
                // cabinet?.code ?? '...',
                // "S8/B09",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              /// ----->>>> Parts Image <<<<---------
              buildPartImage(),
              SizedBox(height: 8.h),

              /// View Details button
              buildViewDetailsButton(),
            ],
          ),
          SizedBox(width: 20.h),

          //
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // price
              Obx(() {
                final profileController = Get.put(ProfileController());
                final isDealer = profileController.profileModel.value.data?.dealer ?? false;
                return Text(
                  isDealer
                      ? "Price : \$${widget.parts.dealerPrice ?? 0}"
                      : "Price : \$${widget.parts.price}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                );
              }),
              const SizedBox(height: 8),

              /// qty increase-decrease buttons
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      widget.cabinetDetailController?.decrement(widget.index);
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Obx(() {
                    final qty = widget.cabinetDetailController!.quantity.length > widget.index
                        ? widget.cabinetDetailController?.quantity[widget.index]
                        : 1;
                    return Text(
                      "$qty",
                      style: AppStyles.h3(),
                    );
                  }),
                  IconButton(
                    onPressed: () {
                      widget.cabinetDetailController?.increment(widget.index);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              /// -[Add to cart] button
              CustomButton(
                onTap: () async {
                  final qty = widget.cabinetDetailController?.quantity[widget.index] ?? 1;
                  final profileController = Get.put(ProfileController());
                  final isDealer = profileController.profileModel.value.data?.dealer ?? false;
                  // Add to cart
                  _cartController.addToCart(
                    productId: widget.parts.id.toString(),
                    name: widget.cabinetDetailController?.cabinetDetailsModel.value.data?.code ?? 'Unknown',
                    // price: widget.parts.price != null
                    //     ? widget.parts.price!.toDouble()
                    //     : 0.0,
                    price: isDealer && widget.parts.dealerPrice != null ? widget.parts.dealerPrice!.toDouble() : widget.parts.price != null ? widget.parts.price!.toDouble() : 0.0,
                    quantity: qty,
                    productImg: widget.parts.images != null && widget.parts.images!.isNotEmpty
                        ? '${ApiConstants.imageBaseUrl}/${widget.parts.images?[0]}'
                        : AppConstants.demoImage,
                  );
                },
                text: 'Add to cart',
                width: 70.w,
              ),
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector buildViewDetailsButton() {
    return GestureDetector(
      onTap: () {
        final partsId = widget.parts.id;
        Get.toNamed(Routes.CABINET_PARTS, arguments: {'partsId': partsId});
      },
      child: Row(
        children: [
          const Text(
            "View Details -",
            style: TextStyle(decoration: TextDecoration.underline),
          ),
          SizedBox(width: 4.w),
          Icon(Icons.open_in_new, size: 16.sp),
        ],
      ),
    );
  }

  Container buildPartImage() {
    return Container(
              width: 80.h,
              height: 80.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: widget.parts.images != null && widget.parts.images!.isNotEmpty ? Image.network(
                '${ApiConstants.imageBaseUrl}/${widget.parts.images?[0]}',
                fit: BoxFit.cover,
              ): Center(
                child: Icon(Icons.image, size: 40.sp, color: Colors.grey),
              ),
            );
  }
}